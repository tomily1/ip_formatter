 ### IP Formatter
 ``` 
 Problem Set: Given a  an input of IPV4 addresses in a txt file, create a command line application that takes the input and prints out a set of unique ips with addresses in sorted order 
 ```

```
Example: Given IPs 1.2.3.5:25,7,8  1.2.3.5:25,7,8,8,1  1.2.3.6:10,1,12,1,1,14,2,1,9,5,7 in a text file

Output should be: 
    1.2.3.5: 1, 7, 8, 25
    1.2.3.6:1, 2, 5, 7, 10, 12, 14
```

#### How to Run Program

1. `git clone` the repo 
2. `cd` into the folder cloned
3.  run `ruby ./lib/ip_formatter.rb 'text_file_name.txt'` on the command line. e.g. to use the test file included in this repository, run `ruby ./lib/ip_formatter.rb './test.txt'` on the command line
4. Tada! you have your result displayed :)