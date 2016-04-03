#!/bin/bash 

perl -e '
         undef $/;
         $file=<>;
         while($file=~ /\G((\S+\s+){7000})/gc)
         {
            $i++;
            open A,">","chunk-$i.txt";
            print A $1;
            close A;
         }
         $i++;
         if($file=~ /\G(.+)\Z/sg)
         {
          open A,">","chunk-$i.txt";
          print A $1;
         }
        '  $1
