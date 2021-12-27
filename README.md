# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


rails new blog --skip-action-mailer --skip-action-mailbox --skip-active-job --skip-action-cable --skip-jbuilder --api --skip-bundle

rails generate scaffold Post title:string body:text published:boolean --api

rails generate rspec:install
