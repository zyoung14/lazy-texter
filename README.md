lazy_texter
===========
###The app for lazy ppl
Who want to text their circles in one **easy** step

### Things to be done

1. Make circles page (DONE)
2. Make new circles page where user can input names, numbers, ideal text, and group name
	-store info in session hash (DONE)
<<<<<<< HEAD
3. Post circles from session on circles page, with button "Text 'em" (DONE)
5. Design circles site to make it prettier
	- lists are inline, *a bit* like yearbook (DONE)

5. Allow circles to be edited on edits page
	- add/delete of people arrays
	- able to edit default message

6. Connect text API functionality when circle is clicked on, with blue circle and order connected (DONE)

7. tidy up edit/new page (DONE)
8. launch on Heroku
9. for project demo, have group with entire class on it and text everyone message at beginning, then mention how it was done


|Group   | Message |
| ------ |:-------:|
|Ballers | Come to PW in 30 to ball |
|Thai food lovers | Join me for Thai food tonight? |
|Swing & Blues peeps | Let's practice Swing and Blues |



|Page | purpose |


HTTP Verb | URL | used for 
----------|-----|----------
GET  |/	|displays group names in order of how many ppl with button, with option to create/delete/edit groups at bottom (DONE)
GET | /new | display form for edit/new (DONE)
POST |/| create/edit group with title, text, list of names & numbers
DELETE |/ | delete group (DONE)

