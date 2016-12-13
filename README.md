# Udacity-Catalogue
A web application that provides a list of items within a variety of categories and integrates third party user registration and authentication.

## Overview

The Udacity Catalogue project implements a data-driven web application that provides create-read-update-delete operations on items that are organised in to categories.

To guide the project, the conceptual basis of a museum catalogue has been adopted: it is imagined that the categories capture the creative modalities of the modern era, and that items within those categories are instances of those modalities.

![Main page](./screenshots/main_page.png)

## Installation

The project can be installed and run on a local machine, assuming that [Vagrant](https://www.vagrantup.com) is available. _The following instructions assume that Vagrant is available._

1. Clone this project to a convenient location
2. From the terminal, `$ cd /path/to/Udacity-Catalogue`
3. `$ vagrant up`

 When the Vagrant initialisation has completed, all of the resources necessary to run the project – including the database and its data – should be available within the VM.

4. `$ vagrant ssh`
5. `vagrant@vagrant-ubuntu-trusty-32:~$ cd /vagrant/app/`
6. `vagrant@vagrant-ubuntu-trusty-32:/vagrant/app$ python main.py `

Now, open a web browser and navigate to [localhost:5000](http://localhost:5000); if the set up process has been successful, you will see the homepage list six categories.

### Troubleshooting

The application has been tested on independent machines, and the shell script associated with the virtual machine successfully creates and populates the database in all cases. Nonetheless, reviewers have encountered an issue where the database does not get created (i.e `sql.exc.OperationalError: database 'catalogue' does not exist`)

![Error](./screenshots/error.png)

This can be resolved by properly creating the `catalogue` database and importing the data. Assuming that you are connected to the Vagrant VM shell	 via SSH, recreate the `catalogue` database:

1. `vagrant@vagrant-ubuntu-trusty-32:~$ dropdb catalogue`
2. `vagrant@vagrant-ubuntu-trusty-32:~$ create catalogue`
3. `vagrant@vagrant-ubuntu-trusty-32:~$ psql catalogue < /vagrant/app/model/catalogue.sql`

Note that step one will fail if the `catalogue` database already exists – `createdb: database creation failed: ERROR:  database "catalogue" already exists
` – continue with the subsequent steps nonetheless.

Now, rerun the application from the Vagrant VM shell:

1. `vagrant@vagrant-ubuntu-trusty-32:~$ cd /vagrant/app/`
2. `vagrant@vagrant-ubuntu-trusty-32:/vagrant/app$ python main.py`


## Usage

### Read

All visitors are able to read information. Choosing a category directs visitors to a page listing examples of works falling under that category.

![The art category](./screenshots/art.png)

Selecting a work directs visitors to a page with more detail.

![A specific artwork](./screenshots/artwork.png)


### Log In / Log Out

The user authentication and authorisation function leverages Google's OAuth service. Clicking the _Log In_ button initiates the sign in process.

![Sign in](./screenshots/sign_in.png)

A signed in visitor has the ability to mutate any content for which they are the creator.

![Signed in](./screenshots/signed_in.png)

The _Log Out_ button is available for a signed in visitor; clicking it invalidates their session.

### Create

A signed in visitor can create a new item in any of the predefined categories by navigating to a category and choosing the _New_ link.

![New link](./screenshots/new_link.png)

The form will perform validation against the _Name_ and image upload fields to ensure that content has been provided.

![New artwork with validation errors](./screenshots/new_artwork.png)

If the form has been filled out correctly and the visitor is signed in, the new item will be added to the designated category.

![New artwork page](./screenshots/new_artwork_detail.png)

### Update

The creator of an item is allowed to edit that item. They navigate to the item page and select the _Edit_ link.

![Edit link](./screenshots/edit_link.png)

This renders a similar page to that which was presented during the creation process, and populates it with the existing data.

![Edit link](./screenshots/editing.png)

The visitor can alter the data and, again, if the form validates and the visitor is both signed in _and_ the creator of the original content, it will be updated.

![Edited content](./screenshots/edited.png)

### Delete

To delete content, a visitor navigates to the page of an item for which they are the creator.

![Selecting an item](./screenshots/select_an_item.png)

They are now able to choose the _Delete_ link.

![Deleting an item](./screenshots/delete_an_item.png)

Assuming that the signed in user is the content creator, the item will be deleted.

![Item is deleted](./screenshots/deleted_item.png)

### JSON Endpoint

It may be helpful for other applications to access the data in a machine-readable format; as such, the application provides a JSON endpoint.

To observe this, navigate to [localhost:5000/catalogue.json](http://localhost:5000/catalogue.json).

![JSON representation](./screenshots/json.png)

The format of the data will be:

```
{
	Category: { // The top-level container
		Category_Name: { // E.g. "Art"
			image_path: ... // The image for the category
			Examples: [ // An array of items in the category
				{
					creator_email: ...
					detail: ...
					id: ...
					image_path: ...
					name: ...
					year: ...
				},
				...
			]
		},
		...
	}
}
					
```

Likewise, a JSON representation of an arbitrary item can be accessed by appending `/json` to the URI for an item:

![JSON for an item](./screenshots/item_json.png)