# Food App

To run this project, make sure you have docker installed.

## Setup :
 - `docker-compose build`
 - `docker-compose run web rake db:migrate`
 - `docker-compose up`

This should setup the environement, first time building can take some time.

## The project :

Navigate to `localhost:3000` in your browser, which should redirect you to the mealplanner view, nothing should be there, that is because the DB has just been created and is empty. You can then hit the `update` button in top left corner to generate the DB, which should display the meals.

You can navigate to other view to update or browse the DB (two tables, food and types).

The update button only works if you are in the mealplanner view.

The design is mainly inspired from the company who requested this test, and is VERY poor at the moment.

The mealplanner view finds all the meal using a methods that allows :
- Load on scroll
- Efficient research (best case cost in `o(n)` if n is the number of dishes : no meal is under 500 cals, and worst case cost in `o(n^3 / 9)` if all meal combinaison is under 500 cals).

Stack : angularjs + bower / ruby on rails, works with docker

The application uses angular router and rails yield router, which causes some big routing problems, some header links sometimes don't work and sometimes work
