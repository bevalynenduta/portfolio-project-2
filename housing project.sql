select * from dbo.NashvilleHousing


--standardize Date Format
select SaleDateConverted, CONVERT(Date, SaleDate)
from dbo.NashvilleHousing

update  dbo.NashvilleHousing
SET SaleDate = CONVERT(Date, SaleDate)

ALTER TABLE dbo.NashvilleHousing
ADD SaleDateConverted Date

UPDATE dbo.NashvilleHousing
SET SaleDateConverted = CONVERT(Date, SaleDate)

--Populate Property Address data

select *
from dbo.NashvilleHousing
--where PropertyAddress is null
order by ParcelID

select nash.ParcelID, nash.PropertyAddress, nas.ParcelID, nas.PropertyAddress, ISNULL(nash.PropertyAddress, nas.PropertyAddress)
from dbo.NashvilleHousing as nash
join dbo.NashvilleHousing as nas
on nash.ParcelID = nas.ParcelID
AND nash.[UniqueID] <> nas.[UniqueID]
where nash.PropertyAddress is null

update nash
set PropertyAddress = ISNULL(nash.PropertyAddress, nas.PropertyAddress)
from dbo.NashvilleHousing as nash
join dbo.NashvilleHousing as nas
on nash.ParcelID = nas.ParcelID
AND nash.[UniqueID] <> nas.[UniqueID]
where nash.PropertyAddress is null

--Breaking out Address into individual columns (Address, city, State)

select PropertyAddress
from dbo.NashvilleHousing
where PropertyAddress is null
order by ParcelID

select 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1,LEN(PropertyAddress)) as Address
from dbo.NashvilleHousing
 
select *
from dbo.NashvilleHousing

Alter table  dbo.NashvilleHousing
ADD PropertySplitAddress Nvarchar(255);

update  dbo.NashvilleHousing
SET PropertySplitAddress =SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) 

ALTER TABLE dbo.NashvilleHousing
ADD PropertySplitCitr nvarchar(255);


update  dbo.NashvilleHousing
SET PropertySplitCity =SUBSTRING (PropertyAddress, CHARINDEX(',', PropertyAddress) +1,LEN(PropertyAddress))


select *
from dbo.NashvilleHousing

sp_rename 'dbo.NashvilleHousing.PropertySplitCitr', 'PropertySplitCity'

select OwnerAddress
from dbo.NashvilleHousing
where OwnerAddress is not null

select 
PARSENAME(REPLACE(OwnerAddress,',', '.'),3)
,PARSENAME(REPLACE(OwnerAddress,',', '.'),2)
,PARSENAME(REPLACE(OwnerAddress,',', '.'),1)
from dbo.NashvilleHousing
WHERE OwnerAddress is not null

Alter Table dbo.NashvilleHousing
ADD OwnerSplitAddress nvarchar(255);

update  dbo.NashvilleHousing
set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',', '.'),3)

Alter Table dbo.NashvilleHousing
ADD OwnerSpliCity nvarchar(255);

sp_rename 'dbo.NashvilleHousing.OwnerSpliCity', 'OwnerSplitCity'
  
update  dbo.NashvilleHousing
set OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',', '.'),1)


select *
from dbo.NashvilleHousing
where OwnerAddress is not null

select DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
from dbo.NashvilleHousing
Group by SoldAsVacant
Order by 2

select SoldAsVacant
,CASE
WHEN SoldAsVacant = 'Y' THEN 'YES'
WHEN SoldAsVacant = 'N' THEN 'NO'
ELSE SoldAsVacant
END
from dbo.NashvilleHousing

update 
dbo.NashvilleHousing 
set 
 SoldAsVacant =
CASE
WHEN SoldAsVacant = 'Y' THEN 'YES'
WHEN SoldAsVacant = 'N' THEN 'NO'
ELSE SoldAsVacant
END

--Remove Duplicates
WITH CTE_RowNum AS (
select *,
ROW_NUMBER() OVER(PARTITION BY ParcelID, 
                               SalePrice, 
							   SaleDate, 
							   LegalReference
                               order by UniqueID) row_num
from dbo.NashvilleHousing
--order by ParcelID)
)
select * 
--delete 
from CTE_RowNum
where row_num > 1
order by PropertyAddress



--Delete Unused Columns


select *
from dbo.NashvilleHousing
where OwnerAddress is not null

 ALTER TABLE 
dbo.NashvilleHousing
DROP COLUMN SaleDate