# MediaWiki-API-sample-


1.	A UITableView to MainViewController that has a header View that displays the string “Results”.

2.  A table view cell subclass using AutoLayout, that displays an image on the left side, and a title and subtitle to the right of the image. 
     Cell height is dynamic depending on the data to be shown.

3.	The Wikipedia API used to search for results of what the user types into the UISearchBar already added to MainViewController. This load results from the API and display each result in the table view added previously. 

4.	This is an “autocomplete” search, that conducts the search as the user types in the search bar and does not wait for the user to tap the “Search” key.

5.	The constraints in the cell dynamically change to show and hide the image on the left of the cell depending on whether there is an image in the result given by the API request. 

6.	A view controller which display more information about the result from the Wikipedia API when the user taps on the cell.

7.  A save button on the home page, tapping this action will save the current search along with the results fetched in data base. Allowing only last 20 searches to be saved along with all results.

8.  The last searches saved are shown in a horizontal scroll list below the search bar, list shows each search text only with 15 padding on both sides.

9.  Tapping the search cell will load search results for that search, same as would have happen for new search.

