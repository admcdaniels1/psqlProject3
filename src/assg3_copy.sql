--use the psql command
--\i assg3_copy.sql
-- to load and run this batch file

--Copies the text files into the database.
--@author Andrew McDaniels & April Crawford
--@version 28 March 2017

\copy sailors from '../data/sailors_data.txt';
\copy boats from '../data/boats_data.txt';
\copy reserves from '../data/reserves_data.txt';
