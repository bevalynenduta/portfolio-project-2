--this data was obtained from kaggle
--This dataset offers a thorough compilation of data about several smartphones, facilitating an in-depth examination 
--of their features and costs. Researchers, data analysts, and machine learning enthusiasts interested in the smartphone 
--sector will find it to be a helpful resource as it covers a broad spectrum of handsets, including various brands, models,
--and configurations.
--Smartphone Name: The unique identifier or model name of the smartphone.
--Brand: Smartphone brand.
--Model: Smartphone brand model.
--RAM (Random Access Memory): The amount of memory available for multitasking.
--Storage: capacity of the smartphone.
--Color: Color of the smarthpone.
--Free: Yes/No if the smartphone is attached to a cell company contract.
--Price: The cost of the smartphone in the respective currency.
--By utilizing this dataset, researchers and analysts can explore patterns, trends, and relationships between smartphone specifications and their pricing. It serves as an excellent resource for tasks such as price prediction, market analysis, and comparison of different smartphone configurations. Whether you are interested in identifying the most cost-effective options or understanding the impact of specific hardware components on smartphone
--prices, this dataset offers abundant possibilities for in-depth exploration.

--1.find the average prices of smartphones by brands

select Brand,avg([Final Price]) as AvgPrice
from SmartPhonesPrices
group by Brand

--2.list all smart phones with more than 4 Gb RAM

select Smartphone, RAM
from SmartPhonesPrices
where RAM > 4

--3.Find the most expensive SmartPhone  for each brand

select a.Smartphone, a.Brand, a.[Final Price] 
from SmartPhonesPrices as a
join
(select Brand, max( [Final Price]) as maxprice
from SmartPhonesPrices
group by Brand) as max_price
on a.Brand =max_price.Brand
and a.Smartphone = max_price.maxprice
order by a.Brand desc, [Final Price]


--4.Get the count of smartPhones by brand
 select Brand, count(Brand) as Free_SmartPhone_Count
 from 
 SmartPhonesPrices
 where Free = 'Yes'
 group by Brand
 order by count(Brand) desc


 --5.Find the cheapest SmartPhone With at Least128 GB storage

 select Smartphone, [Final Price], RAM
 from SmartPhonesPrices
 where Storage > 128
 and RAM is not null
 order by [Final Price] asc


 --6.calculate the average price of smartphones with differen tram size

 select RAM, Avg([Final Price]) avg_price
 from SmartPhonesPrices
 Group by RAM
 Order by avg([Final Price])

 --7.identify smartphones brands available in multiple color
 
 select Brand, count(Distinct Color) as count_of_multiple_colours
 from SmartPhonesPrices
 group by Brand
 having count(Distinct Color) > 1
 order by count(Distinct Color) desc

 --8.compare the average prices of free vs nonfree smaertphones

 select Free, avg([Final Price]) as avg_price
 from SmartPhonesPrices
 group by Free

 --9.Find the smaert Phone with the highest price to Ram Ratio

 select Smartphone, ([Final Price] / RAM) Price_to_RAM_Ratio
 from SmartPhonesPrices
 order by ([Final Price] / RAM) desc


 --10.list all models of a specific  brand with their prices

 select 
 Model, [Final Price]
 from
 SmartPhonesPrices
 where Brand = 'Xiaomi'


 --11.identify the most popular storage capacity

 select Storage, count(*) as count_of_storage
 from SmartPhonesPrices
 where storage is not null
 group by Storage
 having count(*) > 1
 order by count(*) desc


 

