-- WORDS, a Latin dictionary, by Colonel William Whitaker (USAF, Retired)
--
-- Copyright William A. Whitaker (1936–2010)
--
-- This is a free program, which means it is proper to copy it and pass
-- it on to your friends. Consider it a developmental item for which
-- there is no charge. However, just for form, it is Copyrighted
-- (c). Permission is hereby freely given for any and all use of program
-- and data. You can sell it as your own, but at least tell me.
--
-- This version is distributed without obligation, but the developer
-- would appreciate comments and suggestions.
--
-- All parts of the WORDS system, source code and data files, are made freely
-- available to anyone who wishes to use them, for whatever purpose.

with Text_IO; use Text_IO;
with Latin_Utils.Strings_Package; use Latin_Utils.Strings_Package;
procedure page2htm is
   line : String (1 .. 300) := (others => ' ');
   last : Integer := 0;

   input, output : File_Type;

begin
   Put_Line ("DICTPAGE.RAW (sorted) -> DICTPAGE.HTM");
   Put_Line ("For use in preparing a DICTPAGE.HTM after" &
     " running DICTPAGE and sorting.");

   Open (input, In_File, "DICTPAGE.RAW");
   Create (output, Out_File, "DICTPAGE.HTM");

   while not End_Of_File (input)  loop
      Get_Line (input, line, last);
      if line (1) /= '#'  then
         Put_Line ("BAD LINE   >" & line (1 .. last));
      end if;
      for i in 1 .. last  loop
         if line (i) = '['  then
            Put (output, "<B>" & line (2 .. i - 1) & "</B>  ");
            Put_Line (output, Trim (line (i .. i + 6) & "<BR>"));
         end if;
         if line (i .. i + 1) = "::"  then
            Put_Line (output, Trim (line (i + 2 .. last)) & "<BR>");
            exit;
         end if;
      end loop;  --  On LINE

   end loop;  --  On file

end page2htm;
