<h1 align="center">PSA-Weather</h1>
iOS developer technical Interview for PSA
<p align="center">
  <a href="https://upload.wikimedia.org/wikipedia/commons/7/78/IOS_11_logo.png"><img alt="ios" src="https://upload.wikimedia.org/wikipedia/commons/7/78/IOS_11_logo.png"/></a>
</p>

## Implementation

### Contraints
> unable to use third party libraries
> 
> Apply good practices
>
> Create Framework API

## Interface

<p align="center">
  <a href="https://github.com/elaidi93/PSA-Weather/blob/main/Readme_img/screenshot_villes.jpeg"><img alt="ios" src="https://github.com/elaidi93/PSA-Weather/blob/main/Readme_img/screenshot_villes.jpeg"/></a>
    <a href="https://github.com/elaidi93/PSA-Weather/blob/main/Readme_img/screenshot_list.jpeg"><img alt="ios" src="https://github.com/elaidi93/PSA-Weather/blob/main/Readme_img/screenshot_list.jpeg"/></a>
</p>

## Architecture 

I used an MVVM architecture for my application. 

![MVVM Architecture](https://upload.wikimedia.org/wikipedia/commons/8/87/MVVMPattern.png "")

I found this architecture pretty well because thanks to it, I can easily test the business logic, I just have to test the MEessageViewModel class to do it. 

The whole architecture is designed to make each component as independent as possible.

I used also dependency injection for calling DB_weatherManager to avoid controller creation an instance object for it, and make it easier to call
And i used Result and GCD (Grand Central Dispatch) to handle response in a backround thread

## Framework

I also creat my custom framework APIFramework that allow me to create requetes and get data via ws

## Unit tests

I used [XCTest](https://developer.apple.com/documentation/xctest) 

## Time Challenge

It tooke me over 12 hours to complete the whole teste, it was pretty easy so i tried to implement the best practice that I've learned during my career.
