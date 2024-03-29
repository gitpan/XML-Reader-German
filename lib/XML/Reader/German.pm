our $VERSION = '0.04';

print "This document is the German translation from English of the module XML::Reader. In order to\n";
print "get the Perl source code of the module, please see file XML/Reader.pm\n";
print "\n";
print "Dieses Dokument ist die Deutsche Uebersetzung aus dem Englischen des Moduls XML::Reader. Um\n";
print "den Perl Quelltext des Moduls zu lesen, gehen Sie bitte zur Datei XML/Reader.pm\n";
print "\n";

1;

=pod

=head1 NAME

XML::Reader::German - Lesen von XML-Dateien und Bereitstellung der Pfad information basierend auf einem Pull-Parser.

=head1 E<Uuml>BERSETZUNG

This document is the German translation from English of the module XML::Reader. In order to
get the Perl source code of the module, please see file XML/Reader.pm

Dieses Dokument ist die Deutsche E<Uuml>bersetzung aus dem Englischen des Moduls XML::Reader. Um
den Perl Quelltext des Moduls zu lesen, gehen Sie bitte zur Datei XML/Reader.pm

=head1 SYNOPSIS

  use XML::Reader;

  my $text = q{<init>n <?test pi?> t<page node="400">m <!-- remark --> r</page></init>};

  my $rdr = XML::Reader->newhd(\$text) or die "Error: $!";
  while ($rdr->iterate) {
      printf "Path: %-19s, Value: %s\n", $rdr->path, $rdr->value;
  }

Dieses Programm erzeugt folgendes Resultat:

  Path: /init              , Value: n t
  Path: /init/page/@node   , Value: 400
  Path: /init/page         , Value: m r
  Path: /init              , Value:

=head1 BESCHREIBUNG

XML::Reader stellt ein einfach zu bedienendes Interface zur VerfE<uuml>gung mit dem man XML-Dateien
sequentiell lesen kann (sogenanntes "pull-mode" parsing). Der aktuelle XML-Pfad wird ebenfalls gepflegt.

XML::Reader wurde als eine HE<uuml>lle E<uuml>ber dem bestehenden Modul XML::Parser entwickelt (ausserdem wurden
einige Grundfunktionen des Moduls XML::TokeParser mit E<uuml>bernommen). Die bestehenden Module XML::Parser und
XML::TokeParser ermE<ouml>glichen beide das sequentielle Verarbeiten von XML-Dateien, jedoch wird in diesen
Modulen der XML-Pfad nicht gepflegt. Ausserdem muss man mit den Modulen XML::Parser und XML::TokeParser
die Unterscheidung zwischen Start-Tags, End-Tags und Text machen, was meiner Meinung nach die Sache
verkompliziert (obwohl man auch dieselbe Situation in XML::Reader simulieren kann, und zwar durch die
Option {filter => 4}, wenn es das ist was man will).

Es existiert auch ein Modul namens XML::TiePYX, welches ebenfalls das sequentielle Verarbeiten von
XML-Dateien erlaubt (siehe L<http://www.xml.com/pub/a/2000/03/15/feature/index.html> fE<uuml>r eine EinfE<uuml>hrung
in PYX). Aber dennoch, auch mit XML::TiePYX ist man gezwungen eine Unterscheidung zwischen Start-Tags,
End-Tags und Text zu machen und der XML-Pfad wird auch nicht gepflegt.

Im Gegensatz dazu E<uuml>bersetzt XML::Reader die in der XML-Datei bestehenden Start-Tags, End-Tags und Text
in XPath-E<auml>hnliche AusdrE<uuml>cke, man erhE<auml>lt also nur einen Pfad und einen Wert, so einfach ist es. (Sollte man
jedoch mit XML::Reader PYX-kompatible AusdrE<uuml>cke erzeugen wollen, dann kann man das auch mit der Option
{filter => 4}, wie zuvor erwE<auml>hnt, erreichen).

Aber kommen wir zurE<uuml>ck zur normalen Benutzung von XML::Reader, dieses hier ist eine Beispiel XML-Datei, kodiert in der Variablen
'$line1':

  my $line1 = 
  q{<?xml version="1.0" encoding="iso-8859-1"?>
    <data>
      <item>abc</item>
      <item><!-- c1 -->
        <dummy/>
        fgh
        <inner name="ttt" id="fff">
          ooo <!-- c2 --> ppp
        </inner>
      </item>
    </data>
  };

Diese Beispiel XML-Datei kann man mit XML::Reader lesen, und zwar indem man die Methode C<iterate>
verwendet um das jeweils nE<auml>chste XML-Element zu lesen. Danach kann man dann mit den Methoden C<path> und
C<value> den Pfad und den aktuellen Wert lesen.

Man kann ausserdem, wenn man es denn so mE<ouml>chte, die jeweiligen Start- und End-Tags erkennen: Es existiert
die Methode C<is_start>, die genau dann 1 zurE<uuml>ckgibt, wenn an der aktuellen Positon in der XML-Datei
ein Start-Tag existiert, ansonsten gibt die Methode 0 zurE<uuml>ck. Es existiert ebenso die zugehE<ouml>rige Methode
C<is_end>, die genau dann 1 zurE<uuml>ckgibt, wenn nach der aktuellen Positon in der XML-Datei
ein End-Tag existiert, ansonsten gibt die Methode 0 zurE<uuml>ck.

Es existieren zusE<auml>tzlich die Methoden C<tag>, C<attr>, C<type> und C<level>. Die Methode C<tag> liefert den aktuellen
Tag-Namen, C<attr> liefert den Attribut-Namen, C<type> liefert entweder 'T' fE<uuml>r Text oder '@' fE<uuml>r Attribute,
C<level> liefert die im Moment aktive Verschachtelungstiefe (das ist ein numerischer Wert >= 0)

Hier folgend wird, um das Prinzip zu erklE<auml>ren, ein Beispielprogramm aufgefE<uuml>hrt, welches die vorangegangene
XML-Datei in '$line1' einliest...

  use XML::Reader;

  my $rdr = XML::Reader->newhd(\$line1) or die "Error: $!";
  my $i = 0;
  while ($rdr->iterate) { $i++;
      printf "%3d. pat=%-22s, val=%-9s, s=%-1s, e=%-1s, tag=%-6s, atr=%-6s, t=%-1s, lvl=%2d\n", $i,
        $rdr->path, $rdr->value, $rdr->is_start, $rdr->is_end, $rdr->tag, $rdr->attr, $rdr->type, $rdr->level;
  }

...und das hier ist das Resultat:

   1. pat=/data                 , val=         , s=1, e=0, tag=data  , atr=      , t=T, lvl= 1
   2. pat=/data/item            , val=abc      , s=1, e=1, tag=item  , atr=      , t=T, lvl= 2
   3. pat=/data                 , val=         , s=0, e=0, tag=data  , atr=      , t=T, lvl= 1
   4. pat=/data/item            , val=         , s=1, e=0, tag=item  , atr=      , t=T, lvl= 2
   5. pat=/data/item/dummy      , val=         , s=1, e=1, tag=dummy , atr=      , t=T, lvl= 3
   6. pat=/data/item            , val=fgh      , s=0, e=0, tag=item  , atr=      , t=T, lvl= 2
   7. pat=/data/item/inner/@id  , val=fff      , s=0, e=0, tag=@id   , atr=id    , t=@, lvl= 4
   8. pat=/data/item/inner/@name, val=ttt      , s=0, e=0, tag=@name , atr=name  , t=@, lvl= 4
   9. pat=/data/item/inner      , val=ooo ppp  , s=1, e=1, tag=inner , atr=      , t=T, lvl= 3
  10. pat=/data/item            , val=         , s=0, e=1, tag=item  , atr=      , t=T, lvl= 2
  11. pat=/data                 , val=         , s=0, e=1, tag=data  , atr=      , t=T, lvl= 1

=head1 INTERFACE

=head2 Objekt Erstellung

Um ein Objekt vom Typ XML::Reader zu erstellen, wird folgende Syntax verwendet:

  my $rdr = XML::Reader->newhd($data,
    {strip => 1, filter => 2, using => ['/path1', '/path2']})
    or die "Error: $!";

Der Parameter $data (welcher immer mit angegeben werden muss) ist entweder der Name einer
XML-Datei, oder eine Referenz auf eine Zeichenkette (sodass der Inhalt dieser Zeichenkette
als XML verarbeitet werden kann), oder ein zuvor geE<ouml>ffnetes Dateihandle, z.B. \*STDIN, (in diesem
Fall wird einfach das Filehandle benutzt um die XML-Daten zu lesen).

Hier ist ein Beispiel um ein Objekt des Typs XML::Reader mit einem einfachen Datei-Namen zu
erzeugen:

  my $rdr = XML::Reader->newhd('input.xml') or die "Error: $!";

Hier ist ein weiteres Beispiel um ein Objekt des Typs XML::Reader mit einer Referenz
auf eine Zeichenkette zu erzeugen:

  my $rdr = XML::Reader->newhd(\'<data>abc</data>') or die "Error: $!";

Hier ist noch ein weiteres Beispiel um ein Objekt des Typs XML::Reader mit einem
zuvor geE<ouml>ffneneten Dateihandle zu erzeugen:

  open my $fh, '<', 'input.xml' or die "Error: $!";
  my $rdr = XML::Reader->newhd($fh);

Hier ist schliesslich ein Beispiel um ein Objekt des Typs XML::Reader mit \*STDIN zu erzeugen:

  my $rdr = XML::Reader->newhd(\*STDIN);

Eine oder mehrere Optionen kE<ouml>nnen als eine Hash-Referenz hinzugefE<uuml>gt werden:

=over

=item Option {parse_ct => }

Option {parse_ct => 1} ermE<ouml>glicht es XML-Kommentare zu lesen, die Voreinstellung ist {parse_ct => 0}

=item Option {parse_pi => }

Option {parse_pi => 1} ermE<ouml>glicht es processing-instructions und XML-Declarations zu lesen, die
Voreinstellung ist {parse_pi => 0}

=item Option {using => }

Option {using => } ermE<ouml>glicht es einen Teil-Baum der XML-Datei zu selektieren.

Die Syntax hierfE<uuml>r lautet: {using => ['/pfad1/pfad2/pfad3', '/pfad4/pfad5/pfad6']}

=item Option {filter => }

Option {filter => 2} zeigt alle XML-Zeilen an, einschliesslich der Attribute.

Option {filter => 3} entfernt die Attribut-Zeilen (d.h. alle Zeilen mit $rdr->type eq '@' werden
entfernt). Anstelle dessen werden die Attribute in einer Hash-Referenz $rdr->att_hash zurE<uuml>ckgeliefert.

Option {filter => 4} bricht alle Zeilen in individuelle Start-Tags, End-Tags, Attribute, Kommentare und
Processing-Instructions auf. Damit wird die Verarbeitung der XML-Datei im PYX-Format ermE<ouml>glicht.

Option {filter => 5} selektiert nur die Daten fE<uuml>r die vorgegebenen Wurzeln ("root"). Die Datenelemente
jeder Wurzel werden in einer Array Referenz (wie spezifiziert durch den "branch" Parameter) gesammelt
und dann zurE<uuml>ckgegeben wenn der "branch" komplett ist. Diese Vorgehensweise liegt auf halbem Weg
zwischen der Option "using" (wo alle Elemente einzeln zurE<uuml>ckgeliefert werden) und der Funktion
"slurp_xml" (wo alle Elemente in einem "branch" gesammelt werden, und alle "branches" dann am Ende in
einer grossen Speicherstruktur auf einmal zurE<uuml>ckgeliefert werden).

Die Syntax lautet {filter => 2|3|4|5}, die Voreinstellung ist {filter => 2}

=item Option {strip => }

Option {strip => 1} entfernt sowohl fE<uuml>hrende, als auch am Ende befindliche Leerzeichen in Text und
in Kommentaren. (Attributen bleiben hiervon unberE<uuml>hrt). {strip => 0} lE<auml>sst Text und
Kommentare so wie sie in der XML-Datei existieren, mit alle Leerzeichen.

Die Syntax hierfE<uuml>r lautet {strip => 0|1}, die Voreinstellung ist {strip => 1}

=back

=head2 Methoden

Ein erfolgreich erstelltes Objekt vom Typ XML::Reader stellt folgende Methoden zur VerfE<uuml>gung:

=over

=item iterate

Liest das nE<auml>chste XML-Element. Die Methode liefert den Wert 1 zurE<uuml>ck wenn das Lesen erfolgreich war,
oder undef falls das Ende der XML-Datei erreicht wurde.

=item path

Liefert den gesamten Pfad des aktuellen XML-Elements zurE<uuml>ck, Attribute werden mit einem fE<uuml>hrenden 
'@'-Zeichen markiert.

=item value

Liefert den aktuellen Wert zurE<uuml>ck (d.h. den Wert des aktuellen Textes oder den des aktuellen Attributes).

Bitte beachten Sie dass wenn {filter => 2 oder 3} selektiert wurde und wenn zusE<auml>tzlich das aktuelle Element eine XML-Deklaration ist
(d.h. $rdr->is_decl == 1), dann ist es ratsam den aktuellen Wert nicht zu berE<uuml>cksichtigen (er ist dann sowieso
leer). Ein typisches Beispiel wE<auml>re:

  print $rdr->value, "\n" unless $rdr->is_decl;

Dieses oben angegebe Beispiel trifft jedoch nicht zu wenn {filter => 4} aktiv ist. In diesem falle genE<uuml>gt ein
einfaches "print $rdr->value;":

  print $rdr->value, "\n";

=item comment

Liefert den aktuellen Kommentar zurE<uuml>ck. Bevor man diesen Wert benutzt, sollte man mit $rdr->C<is_comment> prE<uuml>fen
ob das aktuelle Element wirklich ein Kommentar ist.

=item type

Liefert den Typ des Wertes zurE<uuml>ck: 'T' fE<uuml>r Text, '@' fE<uuml>r Attribute.

Falls Option {filter => 4} aktiviert ist, dann kann der Typ folgende Werte annehmen: 'T' fE<uuml>r Text, '@' fE<uuml>r
Attribute, 'S' fE<uuml>r Start-Tags, 'E' fE<uuml>r End-Tags, '#' fE<uuml>r Kommentare, 'D' fE<uuml>r XML-Declarationen, '?' fE<uuml>r
Processing-Instructions.

=item tag

Liefert den aktuellen Tag-Namen zurE<uuml>ck.

=item attr

Liefert den aktuellen Attribut-Namen zurE<uuml>ck (liefert eine leere Zeichenkette zurE<uuml>ck falls das aktuelle Element
kein Attribut ist).

=item level

Zeigt die aktuelle Verschachtelungstiefe des XPath-Ausdruckes an (das ist ein numerischer Wert > 0)

=item prefix

Liefert den PrE<auml>fix zurE<uuml>ck der durch die Option {using => ...} entfernt wurde. Falls die Option {using => ...}
nicht benutzt wurde, wird eine leere Zeichenkette zurE<uuml>ckgegeben

=item att_hash

Liefert eine Referenz zu einem Hash zurE<uuml>ck der die aktuellen Attribute eines Start-Tags enthE<auml>lt (der Hash
ist leer falls der aktuelle Tag kein Start-Tag ist)

=item dec_hash

Liefert eine Referenz zu einem Hash zurE<uuml>ck der die aktuellen Attribute einer XML-Declaration enthE<auml>lt (der Hash
ist leer falls der aktuelle Tag keine XML-Declaration ist)

=item proc_tgt

Liefert den Ziel Wert (d.h. den ersten Teil) einer Processing-Instruction zurE<uuml>ck (eine leere Zeichenkette
wird zurE<uuml>ckgegeben falls der aktuelle Tag keine Processing-Instruction ist)

=item proc_data

Liefert den Daten Wert (d.h. den zweiten Teil) einer Processing-Instruction zurE<uuml>ck (eine leere Zeichenkette
wird zurE<uuml>ckgegeben falls der aktuelle Tag keine Processing-Instruction ist)

=item pyx

Liefert eine Zeichenkette im PYX-Format des aktuellen Tags zurE<uuml>ck.

Das PYX-Format ist eine Zeichenkette deren erstes Zeichen eine spezielle Bedeutung hat. Dieses erste Zeichen
einer jeweiligen PYX-Zeichenkette gibt den Typ des Ereignisses an mit dem man es zu tun hat: falls das erste
Zeichen ein '(' ist, dann hat man es mit einem Start-Tag zu tun, wenn es ein ')' ist, dann hat man es mit
einem End-Tag zu tun, wenn es ein 'A' ist, dann hat man es mit einem Attribut zu tun, wenn es ein '-' ist,
dann hat man es mit einem Text zu tun, wenn es ein '?' ist, dann hat man es mit einer Processing-Instruction
zu tun. (siehe L<http://www.xml.com/pub/a/2000/03/15/feature/index.html> fE<uuml>r eine EinfE<uuml>hrung in PYX)

Die Methode C<pyx> macht nur Sinn falls die Option {filter => 4} aktiviert wurde, ansonsten wird undef
zurE<uuml>ckgeliefert.

=item is_start

Liefert 1 zurE<uuml>ck falls die aktuelle Position ein Start-Tag ist, ansonsten wird 0 zurE<uuml>ckgeliefert.

=item is_end

Liefert 1 zurE<uuml>ck falls die aktuelle Position ein End-Tag ist, ansonsten wird 0 zurE<uuml>ckgeliefert.

=item is_decl

Liefert 1 zurE<uuml>ck falls die aktuelle Position eine XML-Declaration ist, ansonsten wird 0 zurE<uuml>ckgeliefert.

=item is_proc

Liefert 1 zurE<uuml>ck falls die aktuelle Position eine Processing-Instruction ist, ansonsten wird 0 zurE<uuml>ckgeliefert.

=item is_comment

Liefert 1 zurE<uuml>ck falls die aktuelle Position ein Kommentar ist, ansonsten wird 0 zurE<uuml>ckgeliefert.

=item is_text

Liefert 1 zurE<uuml>ck falls die aktuelle Position ein Text ist, ansonsten wird 0 zurE<uuml>ckgeliefert.

=item is_attr

Liefert 1 zurE<uuml>ck falls die aktuelle Position ein Attribut ist, ansonsten wird 0 zurE<uuml>ckgeliefert.

=item is_value

Liefert 1 zurE<uuml>ck falls die aktuelle Position ein Text oder ein Attribut ist, ansonsten wird 0 zurE<uuml>ckgeliefert.
Diese Methode ist insbesondere nE<uuml>tzlich wenn {filter => 4} aktiv ist, in diesem Falle kann man damit testen
ob es sinnvoll ist die Methode value() aufzurufen.

=back

=head1 OPTION USING

Mit der Option {using => ...} kann man einen Teil-Baum der XML-Datei selektieren.

So funktioniert das im Detail...

Die Option {using => ['/pfad1/pfad2/pfad3', '/pfad4/pfad5/pfad6']} eliminiert alle Zeilen deren
Pfad nicht mit '/pfad1/pfad2/pfad3' (oder nicht mit '/pfad4/pfad5/pfad6') beginnen. Das lE<auml>sst
dann nur noch Zeilen E<uuml>brig, die dann mit '/pfad1/pfad2/pfad3' oder mit '/pfad4/pfad5/pfad6' beginnen.

Diese Zeilen (die nicht eliminiert wurden) haben dann einen kE<uuml>rzeren Pfad, weil der PrE<auml>fix
'/pfad1/pfad2/pfad3' (oder '/pfad4/pfad5/pfad6') entfernt wurde. Der entfernte PrE<auml>fix erscheint
dann aber in der Methode prefix().

Man kann sagen dass die Pfade '/pfad1/pfad2/pfad3' und '/pfad4/pfad5/pfad6' "absolut" und
"komplett" sind. Der Begriff "absolut" bedeutet dass die Pfade mit einem '/' beginnen mE<uuml>ssen,
der Begriff "komplett" bedeutet dass der Pfad intern mit einem anghE<auml>ngten '/'-Zeichen
abgeschlossen wird.

=head2 Ein Beispiel mit Option 'using'

Das folgende Programm liest eine XML-Datei und parst sie mit XML::Reader, die Option 'using'
selektiert dabei nur einen Teil des XML-Baumes:

  use XML::Reader;

  my $line2 = q{
  <data>
    <order>
      <database>
        <customer name="aaa" />
        <customer name="bbb" />
        <customer name="ccc" />
        <customer name="ddd" />
      </database>
    </order>
    <dummy value="ttt">test</dummy>
    <supplier>hhh</supplier>
    <supplier>iii</supplier>
    <supplier>jjj</supplier>
  </data>
  };

  my $rdr = XML::Reader->newhd(\$line2,
    {using => ['/data/order/database/customer', '/data/supplier']});

  my $i = 0;
  while ($rdr->iterate) { $i++;
      printf "%3d. prf=%-29s, pat=%-7s, val=%-3s, tag=%-6s, t=%-1s, lvl=%2d\n",
        $i, $rdr->prefix, $rdr->path, $rdr->value, $rdr->tag, $rdr->type, $rdr->level;
  }

Das ist das Ergebnis dieses Programms:

   1. prf=/data/order/database/customer, pat=/@name , val=aaa, tag=@name , t=@, lvl= 1
   2. prf=/data/order/database/customer, pat=/      , val=   , tag=      , t=T, lvl= 0
   3. prf=/data/order/database/customer, pat=/@name , val=bbb, tag=@name , t=@, lvl= 1
   4. prf=/data/order/database/customer, pat=/      , val=   , tag=      , t=T, lvl= 0
   5. prf=/data/order/database/customer, pat=/@name , val=ccc, tag=@name , t=@, lvl= 1
   6. prf=/data/order/database/customer, pat=/      , val=   , tag=      , t=T, lvl= 0
   7. prf=/data/order/database/customer, pat=/@name , val=ddd, tag=@name , t=@, lvl= 1
   8. prf=/data/order/database/customer, pat=/      , val=   , tag=      , t=T, lvl= 0
   9. prf=/data/supplier               , pat=/      , val=hhh, tag=      , t=T, lvl= 0
  10. prf=/data/supplier               , pat=/      , val=iii, tag=      , t=T, lvl= 0
  11. prf=/data/supplier               , pat=/      , val=jjj, tag=      , t=T, lvl= 0

=head2 Ein Beispiel ohne Option 'using'

Das folgende Programm liest eine XML-Datei und parst sie mit XML::Reader, jedoch ohne Option 'using'.

  use XML::Reader;

  my $rdr = XML::Reader->newhd(\$line2);
  my $i = 0;
  while ($rdr->iterate) { $i++;
      printf "%3d. prf=%-1s, pat=%-37s, val=%-6s, tag=%-11s, t=%-1s, lvl=%2d\n",
       $i, $rdr->prefix, $rdr->path, $rdr->value, $rdr->tag, $rdr->type, $rdr->level;
  }

Wie man in dem folgenden Resultat sehen kann, werden mehr Ausgabezeilen geschrieben, der PrE<auml>fix ist
leer und der Pfad ist jetzt lE<auml>nger als zuvor.

   1. prf= , pat=/data                                , val=      , tag=data       , t=T, lvl= 1
   2. prf= , pat=/data/order                          , val=      , tag=order      , t=T, lvl= 2
   3. prf= , pat=/data/order/database                 , val=      , tag=database   , t=T, lvl= 3
   4. prf= , pat=/data/order/database/customer/@name  , val=aaa   , tag=@name      , t=@, lvl= 5
   5. prf= , pat=/data/order/database/customer        , val=      , tag=customer   , t=T, lvl= 4
   6. prf= , pat=/data/order/database                 , val=      , tag=database   , t=T, lvl= 3
   7. prf= , pat=/data/order/database/customer/@name  , val=bbb   , tag=@name      , t=@, lvl= 5
   8. prf= , pat=/data/order/database/customer        , val=      , tag=customer   , t=T, lvl= 4
   9. prf= , pat=/data/order/database                 , val=      , tag=database   , t=T, lvl= 3
  10. prf= , pat=/data/order/database/customer/@name  , val=ccc   , tag=@name      , t=@, lvl= 5
  11. prf= , pat=/data/order/database/customer        , val=      , tag=customer   , t=T, lvl= 4
  12. prf= , pat=/data/order/database                 , val=      , tag=database   , t=T, lvl= 3
  13. prf= , pat=/data/order/database/customer/@name  , val=ddd   , tag=@name      , t=@, lvl= 5
  14. prf= , pat=/data/order/database/customer        , val=      , tag=customer   , t=T, lvl= 4
  15. prf= , pat=/data/order/database                 , val=      , tag=database   , t=T, lvl= 3
  16. prf= , pat=/data/order                          , val=      , tag=order      , t=T, lvl= 2
  17. prf= , pat=/data                                , val=      , tag=data       , t=T, lvl= 1
  18. prf= , pat=/data/dummy/@value                   , val=ttt   , tag=@value     , t=@, lvl= 3
  19. prf= , pat=/data/dummy                          , val=test  , tag=dummy      , t=T, lvl= 2
  20. prf= , pat=/data                                , val=      , tag=data       , t=T, lvl= 1
  21. prf= , pat=/data/supplier                       , val=hhh   , tag=supplier   , t=T, lvl= 2
  22. prf= , pat=/data                                , val=      , tag=data       , t=T, lvl= 1
  23. prf= , pat=/data/supplier                       , val=iii   , tag=supplier   , t=T, lvl= 2
  24. prf= , pat=/data                                , val=      , tag=data       , t=T, lvl= 1
  25. prf= , pat=/data/supplier                       , val=jjj   , tag=supplier   , t=T, lvl= 2
  26. prf= , pat=/data                                , val=      , tag=data       , t=T, lvl= 1

=head1 OPTION PARSE_CT

Die Option {parse_ct => 1} erlaubt das Lesen von Kommentaren (normalerweise werden Kommentare von
XML::Reader ignoriert, d.h. {parse_ct => 0} ist die Voreinstellung).

Hier ist ein Beispiel wo Kommentare, wie voreingestellt, ignoriert werden:

  use XML::Reader;

  my $text = q{<?xml version="1.0"?><dummy>xyz <!-- remark --> stu <?ab cde?> test</dummy>};

  my $rdr = XML::Reader->newhd(\$text) or die "Error: $!";

  while ($rdr->iterate) {
      if ($rdr->is_decl)    { my %h = %{$rdr->dec_hash};
                              print "Found decl     ",  join('', map{" $_='$h{$_}'"} sort keys %h), "\n"; }
      if ($rdr->is_proc)    { print "Found proc      ", "t=", $rdr->proc_tgt, ", d=", $rdr->proc_data, "\n"; }
      if ($rdr->is_comment) { print "Found comment   ", $rdr->comment, "\n"; }
      print "Text '", $rdr->value, "'\n" unless $rdr->is_decl;
  }

Hier ist das Ergebnis:

  Text 'xyz stu test'

Jetzt ein Beispiel mit den selben XML-Daten und dem selben Algorithmus, ausser dass die Option
{parse_ct => 1} jetzt aktiviert ist:

  use XML::Reader;

  my $text = q{<?xml version="1.0"?><dummy>xyz <!-- remark --> stu <?ab cde?> test</dummy>};

  my $rdr = XML::Reader->newhd(\$text, {parse_ct => 1}) or die "Error: $!";

  while ($rdr->iterate) {
      if ($rdr->is_decl)    { my %h = %{$rdr->dec_hash};
                              print "Found decl     ",  join('', map{" $_='$h{$_}'"} sort keys %h), "\n"; }
      if ($rdr->is_proc)    { print "Found proc      ", "t=", $rdr->proc_tgt, ", d=", $rdr->proc_data, "\n"; }
      if ($rdr->is_comment) { print "Found comment   ", $rdr->comment, "\n"; }
      print "Text '", $rdr->value, "'\n" unless $rdr->is_decl;
  }

Hier ist das Ergebnis:

  Text 'xyz'
  Found comment   remark
  Text 'stu test'

=head1 OPTION PARSE_PI

Die Option {parse_pi => 1} erlaubt das Lesen von Processing-Instructions und XML-Declarations (normalerweise
werden Processing-Instructions und XML-Declarations von XML::Reader ignoriert, d.h. {parse_pi => 0}  ist die
Voreinstellung).

Als Beispiel benutzen wir hier die selben XML-Daten und den selben Algorithmus wie zuvor, ausser dass die
Option {parse_pi => 1} aktiviert ist (zusammen mit der schon aktivierten Option {parse_ct => 1}):

  use XML::Reader;

  my $text = q{<?xml version="1.0"?><dummy>xyz <!-- remark --> stu <?ab cde?> test</dummy>};

  my $rdr = XML::Reader->newhd(\$text, {parse_ct => 1, parse_pi => 1}) or die "Error: $!";

  while ($rdr->iterate) {
      if ($rdr->is_decl)    { my %h = %{$rdr->dec_hash};
                              print "Found decl     ",  join('', map{" $_='$h{$_}'"} sort keys %h), "\n"; }
      if ($rdr->is_proc)    { print "Found proc      ", "t=", $rdr->proc_tgt, ", d=", $rdr->proc_data, "\n"; }
      if ($rdr->is_comment) { print "Found comment   ", $rdr->comment, "\n"; }
      print "Text '", $rdr->value, "'\n" unless $rdr->is_decl;
  }

Beachten sie im obigen Programm die Zeile "unless $rdr->is_decl". Diese Zeile existiert damit verhindert wird dass
der Wert einer XML-Declaration ausgegeben wird (dieser Wert wE<auml>re dann sowieso leer).

Hier ist das Resultat:

  Found decl      version='1.0'
  Text 'xyz'
  Found comment   remark
  Text 'stu'
  Found proc      t=ab, d=cde
  Text 'test'

=head1 OPTION FILTER

Die Option Filter erlaubt verschiedene Grundeinstellungen zum Verarbeiten von XML-Daten.

=head2 Option {filter => 2}

Mit der Option {filter => 2}, XML::Reader erzeugt eine Zeile fE<uuml>r jedes Text-Event. Falls der vorangehende
Tag ein Start-Tag ist, dann wird die Methode C<is_start> auf 1 gesetzt. Falls der folgende Tag ein End-Tag
ist, dann wird die Methode C<is_end> auf 1 gesetzt. Falls der vorangehende Tag ein Kommentar ist, dann wird
die Methode C<is_comment> auf 1 gesetzt. Falls der vorangehende Tag eine XML-Declaration ist, dann wird die Methode
C<is_decl> auf 1 gesetzt. Falls der vorangehende Tag eine Processing-Instruction ist, dann wird die Methode C<is_proc>
auf 1 gesetzt.

ZusE<auml>tzlich, Attribute werden als spezielle Zeilen mit der '/@...' Syntax hinzugefE<uuml>gt.

Option {filter => 2} ist die Voreinstellung.

Hier ist ein Beispiel...

  use XML::Reader;

  my $text = q{<root><test param="v"><a><b>e<data id="z">g</data>f</b></a></test>x <!-- remark --> yz</root>};

  my $rdr = XML::Reader->newhd(\$text) or die "Error: $!";
  while ($rdr->iterate) {
      printf "Path: %-24s, Value: %s\n", $rdr->path, $rdr->value;
  }

Dieses Programm (mit der impliziten Option {filter => 2} als Voreinstellung) produziert folgendes Resultat:

  Path: /root                   , Value:
  Path: /root/test/@param       , Value: v
  Path: /root/test              , Value:
  Path: /root/test/a            , Value:
  Path: /root/test/a/b          , Value: e
  Path: /root/test/a/b/data/@id , Value: z
  Path: /root/test/a/b/data     , Value: g
  Path: /root/test/a/b          , Value: f
  Path: /root/test/a            , Value:
  Path: /root/test              , Value:
  Path: /root                   , Value: x yz

Dieselbe Option {filter => 2} erlaubt die Erkennung der XML-Struktur mithilfe der Methoden
C<is_start> und C<is_end>. Bitte beachten Sie ebenso in dem obigen Resultat dass die erste Zeile
("Path: /root, Value:") zwar leer ist, jedoch sehr wichtig fE<uuml>r die XML-Struktur ist. Daher dE<uuml>rfen
wir diese Zeile nicht vergessen.

Betrachten wir jetzt das selbe Beispiel (mit der Option {filter => 2}), jedoch mit einem zusE<auml>tzlichen Algorithmus
um die originale XML-Struktur wieder herzustellen:

  use XML::Reader;

  my $text = q{<root><test param="v"><a><b>e<data id="z">g</data>f</b></a></test>x <!-- remark --> yz</root>};

  my $rdr = XML::Reader->newhd(\$text) or die "Error: $!";

  my %at;

  while ($rdr->iterate) {
      my $indentation = '  ' x ($rdr->level - 1);

      if ($rdr->type eq '@')  { $at{$rdr->attr} = $rdr->value; }

      if ($rdr->is_start) {
          print $indentation, '<', $rdr->tag, join('', map{" $_='$at{$_}'"} sort keys %at), '>', "\n";
      }

      unless ($rdr->type eq '@') { %at = (); }

      if ($rdr->type eq 'T' and $rdr->value ne '') {
          print $indentation, '  ', $rdr->value, "\n";
      }

      if ($rdr->is_end) {
          print $indentation, '</', $rdr->tag, '>', "\n";
      }
  }

...hier ist das Resultat:

  <root>
    <test param='v'>
      <a>
        <b>
          e
          <data id='z'>
            g
          </data>
          f
        </b>
      </a>
    </test>
    x yz
  </root>

...Dieses Resultat beweist dass die originale XML-Struktur nicht verloren gegangen ist.

=head2 Option {filter => 3}

Die Option {filter => 3} funktioniert E<auml>hnlich wie {filter => 2}.

Der Unterschied jedoch ist dass mit Option {filter => 3} alle Attribut-Zeilen eliminiert werden
und anstelle dessen die Attribute fE<uuml>r ein Start-Tag im hash $rdr->att_hash() erscheinen.

Damit wird die Benutzung einer globalen %at-Variable im oben angegebenen Algorithmus nicht mehr
notwendig und kann daher durch die Konstruktion %{$rdr->att_hash} erstzt werden.

Hier ist ein neuer Algorithmus fE<uuml>r {filter => 3}, wir brauchen uns nicht mehr explizit um
Attribut-Zeilen zu kE<uuml>mmern (d.h. wir brauchen nicht mehr abzufragen ob $rdr->C<type> eq '@') und,
wie schon bemerkt, die %at-Variable wird ersetzt durch %{$rdr->C<att_hash>} :

  use XML::Reader;

  my $text = q{<root><test param="v"><a><b>e<data id="z">g</data>f</b></a></test>x <!-- remark --> yz</root>};

  my $rdr = XML::Reader->newhd(\$text, {filter => 3}) or die "Error: $!";

  while ($rdr->iterate) {
      my $indentation = '  ' x ($rdr->level - 1);

      if ($rdr->is_start) {
          print $indentation, '<', $rdr->tag,
            join('', map{" $_='".$rdr->att_hash->{$_}."'"} sort keys %{$rdr->att_hash}),
            '>', "\n";
      }

      if ($rdr->type eq 'T' and $rdr->value ne '') {
          print $indentation, '  ', $rdr->value, "\n";
      }

      if ($rdr->is_end) {
          print $indentation, '</', $rdr->tag, '>', "\n";
      }
  }

...das Resultat fE<uuml>r {filter => 3} ist identisch mit dem Resultat fE<uuml>r {filter => 2}:

  <root>
    <test param='v'>
      <a>
        <b>
          e
          <data id='z'>
            g
          </data>
          f
        </b>
      </a>
    </test>
    x yz
  </root>

=head2 Option {filter => 4}

Obwohl es nicht die Hauptfunktion von XML::Reader darstellt, erlaubt die Option {filter => 4} die Erzeugung von
individuellen Zeilen fE<uuml>r jeweils das Start-Tag, das End-Tag, Kommentare, Processing-Instructions und
XML-Declarations. Der Sinn ist eine PYX-kompatible Ausgabe-Zeichenkette zur weiteren Verarbeitung zu erzeugen.

Hier ist ein Beispiel:

  use XML::Reader;

  my $text = q{<?xml version="1.0" encoding="iso-8859-1"?>
    <delta>
      <dim alter="511">
        <gamma />
        <beta>
          car <?tt dat?>
        </beta>
      </dim>
      dskjfh <!-- remark --> uuu
    </delta>};

  my $rdr = XML::Reader->newhd(\$text, {filter => 4, parse_pi => 1}) or die "Error: $!";

  while ($rdr->iterate) {
      printf "Type = %1s, pyx = %s\n", $rdr->type, $rdr->pyx;
  }

und hier ist das Resultat:

  Type = D, pyx = ?xml version='1.0' encoding='iso-8859-1'
  Type = S, pyx = (delta
  Type = S, pyx = (dim
  Type = @, pyx = Aalter 511
  Type = S, pyx = (gamma
  Type = E, pyx = )gamma
  Type = S, pyx = (beta
  Type = T, pyx = -car
  Type = ?, pyx = ?tt dat
  Type = E, pyx = )beta
  Type = E, pyx = )dim
  Type = T, pyx = -dskjfh uuu
  Type = E, pyx = )delta

Bitte berE<uuml>cksichtigen Sie dass, falls {parse_ct => 1} gesetzt ist, Kommentare in der Methode C<pyx> in einem
nicht-standardisierten Format erzeugt werden. Die Kommentare werden dann mit einem fE<uuml>hrenden Doppelkreuz
erzugt welches nicht in der PYX-Spezifikation existiert. Das folgende Beispiel demonstriert diesen Fall:

  use XML::Reader;

  my $text = q{
    <delta>
      <!-- remark -->
    </delta>};

  my $rdr = XML::Reader->newhd(\$text, {filter => 4, parse_ct => 1}) or die "Error: $!";

  while ($rdr->iterate) {
      printf "Type = %1s, pyx = %s\n", $rdr->type, $rdr->pyx;
  }

Hier ist das Ergebnis:

  Type = S, pyx = (delta
  Type = #, pyx = #remark
  Type = E, pyx = )delta

Ausserdem, falls {filter => 4} gesetzt ist, bleiben folgende Methoden gE<uuml>ltig: (C<value>, C<attr>,
C<path>, C<is_start>, C<is_end>, C<is_decl>, C<is_proc>, C<is_comment>, C<is_attr>, C<is_text>,
C<is_value>, C<comment>, C<proc_tgt>, C<proc_data>, C<dec_hash> und C<att_hash>). Hier ist ein Beispiel:

  use XML::Reader;

  my $text = q{<?xml version="1.0"?>
    <parent abc="def"> <?pt hmf?>
      dskjfh <!-- remark -->
      <child>ghi</child>
    </parent>};

  my $rdr = XML::Reader->newhd(\$text, {filter => 4, parse_pi => 1, parse_ct => 1}) or die "Error: $!";

  while ($rdr->iterate) {
      printf "Path %-15s v=%s ", $rdr->path, $rdr->is_value;

      if    ($rdr->is_start)   { print "Found start tag ", $rdr->tag, "\n"; }
      elsif ($rdr->is_end)     { print "Found end tag   ", $rdr->tag, "\n"; }
      elsif ($rdr->is_decl)    { my %h = %{$rdr->dec_hash};
                                 print "Found decl     ",  join('', map{" $_='$h{$_}'"} sort keys %h), "\n"; }
      elsif ($rdr->is_proc)    { print "Found proc      ", "t=",    $rdr->proc_tgt, ", d=", $rdr->proc_data, "\n"; }
      elsif ($rdr->is_comment) { print "Found comment   ", $rdr->comment, "\n"; }
      elsif ($rdr->is_attr)    { print "Found attribute ", $rdr->attr, "='", $rdr->value, "'\n"; }
      elsif ($rdr->is_text)    { print "Found text      ", $rdr->value, "\n"; }
  }

Hier ist das Ergebnis:

  Path /               v=0 Found decl      version='1.0'
  Path /parent         v=0 Found start tag parent
  Path /parent/@abc    v=1 Found attribute abc='def'
  Path /parent         v=0 Found proc      t=pt, d=hmf
  Path /parent         v=1 Found text      dskjfh
  Path /parent         v=0 Found comment   remark
  Path /parent/child   v=0 Found start tag child
  Path /parent/child   v=1 Found text      ghi
  Path /parent/child   v=0 Found end tag   child
  Path /parent         v=0 Found end tag   parent


Bitte beachten Sie dass fE<uuml>r alle Texte und fE<uuml>r alle Attribute v=1 gesetzt ist (d.h. $rdr->C<is_value> == 1).

=head2 Option {filter => 5}

Mit der Option {filter => 5} spezifiziert man eine (oder mehrere) Wurzeln ("root"), jede "root" hat eine Liste
von E<Auml>sten ("branch"). Man erhE<auml>lt daraufhin genau einen Record fE<uuml>r jedes Auftreten der "root" in
der XML Struktur. Jeder Record enthE<auml>lt genau die Elemente die in der "branch" Struktur definiert wurden.
Am einfachsten lE<auml>sst sich dieses an einem Beispiel erklE<auml>ren:

  use XML::Reader;

  my $line2 = q{
  <data>
    <supplier>ggg</supplier>
    <supplier>hhh</supplier>
    <order>
      <database>
        <customer name="smith" id="652">
          <street>high street</street>
          <city>boston</city>
        </customer>
        <customer name="jones" id="184">
          <street>maple street</street>
          <city>new york</city>
        </customer>
        <customer name="stewart" id="520">
          <street>ring road</street>
          <city>dallas</city>
        </customer>
      </database>
    </order>
    <dummy value="ttt">test</dummy>
    <supplier>iii</supplier>
    <supplier>jjj</supplier>
  </data>
  };

Wir wollen aus der oben angegebenen XML-Datei die Elemente "name", "street" und "city"
fE<uuml>r alle Customer des Pfades '/data/order/database/customer' auslesen. Ausserdem wollen
wir den Supplier im Pfad '/data/supplier' lesen. Die Daten der ersten Wurzel
'/data/order/database/customer' erkennt man anhand der Bedingung $rdr->rx == 0, die
Daten der zweiten Wurzel '/data/supplier' erkennt man anhand der Bedingung $rdr->rx == 1.

  my $rdr = XML::Reader->newhd(\$line2, {filter => 5},
    { root => '/data/order/database/customer', branch => ['/@name', '/street', '/city'] },
    { root => '/data/supplier',                branch => ['/']                          },
  );

  while ($rdr->iterate) {
      if ($rdr->rx == 0) {
          for ($rdr->rvalue) {
              printf "Cust: Name = %-7s Street = %-12s City = %s\n", $_->[0], $_->[1], $_->[2];
          }
      }
      elsif ($rdr->rx == 1) {
          for ($rdr->rvalue) {
              printf "Supp: Name = %s\n", $_->[0];
          }
      }
  }

Hier ist das Ergebnis:

  Supp: Name = ggg
  Supp: Name = hhh
  Cust: Name = smith   Street = high street  City = boston
  Cust: Name = jones   Street = maple street City = new york
  Cust: Name = stewart Street = ring road    City = dallas
  Supp: Name = iii
  Supp: Name = jjj

=head1 BEISPIELE

Betrachten wir nun folgende XML-Datei, von der wir die Werte innerhalb der Tags E<lt>itemE<gt> (dabei meine
ich nur den ersten Teil 'start...', und nicht den zweiten Teil 'end...') plus die Attribute "p1" und
"p3" extrahieren wollen. Der E<lt>itemE<gt>-Tag muss exact im Pfad /start/param/data existieren (und *nicht*
im Pfad /start/param/dataz).

  my $text = q{
    <start>
      <param>
        <data>
          <item p1="a" p2="b" p3="c">start1 <inner p1="p">i1</inner> end1</item>
          <item p1="d" p2="e" p3="f">start2 <inner p1="q">i2</inner> end2</item>
          <item p1="g" p2="h" p3="i">start3 <inner p1="r">i3</inner> end3</item>
        </data>
        <dataz>
          <item p1="j" p2="k" p3="l">start9 <inner p1="s">i9</inner> end9</item>
        </dataz>
        <data>
          <item p1="m" p2="n" p3="o">start4 <inner p1="t">i4</inner> end4</item>
        </data>
      </param>
    </start>};

Wir erwarten genau 4 Ergebnis-Zeilen von unserem Parse-Lauf (d.h. wir erwarten keine
'dataz' - 'start9' Werte):

  item = 'start1', p1 = 'a', p3 = 'c'
  item = 'start2', p1 = 'd', p3 = 'f'
  item = 'start3', p1 = 'g', p3 = 'i'
  item = 'start4', p1 = 'm', p3 = 'o'

=head2 XML-Parsen mit {filter => 2}

Hier ist ein Beispiel-Programm um die XML-Datei mit {filter => 2} zu parsen. (Bitte
beachten Sie wie der PrE<auml>fix '/start/param/data/item' in der {using => ...} Option
von newhd verwendet wird). Wir brauchen ausserdem zwei scalar Variablen ('$p1' und '$p3')
um die Parameter in '/@p1' und '/@p3' aufzunehmen und sie in den Programmteil
$rdr->is_start zu E<uuml>bertragen, wo sie dann ausgegeben werden kE<ouml>nnen.

  my $rdr = XML::Reader->newhd(\$text,
    {filter => 2, using => '/start/param/data/item'}) or die "Error: $!";

  my ($p1, $p3);

  while ($rdr->iterate) {
      if    ($rdr->path eq '/@p1') { $p1 = $rdr->value; }
      elsif ($rdr->path eq '/@p3') { $p3 = $rdr->value; }
      elsif ($rdr->path eq '/' and $rdr->is_start) {
          printf "item = '%s', p1 = '%s', p3 = '%s'\n",
            $rdr->value, $p1, $p3;
      }
      unless ($rdr->is_attr) { $p1 = undef; $p3 = undef; }
  }

=head2 XML-Parsen mit {filter => 3}

Mit {filter => 3} kE<ouml>nnen wir auf die zwei scalar Variablen ('$p1' und '$p3') verzichten, das
Programm vereinfacht sich wie folgt:

  my $rdr = XML::Reader->newhd(\$text,
    {filter => 3, using => '/start/param/data/item'}) or die "Error: $!";

  while ($rdr->iterate) {
      if ($rdr->path eq '/' and $rdr->is_start) {
          printf "item = '%s', p1 = '%s', p3 = '%s'\n",
            $rdr->value, $rdr->att_hash->{p1}, $rdr->att_hash->{p3};
      }
  }

=head2 XML-Parsen mit {filter => 4}

Jedoch mit {filter => 4} wird das Programm wieder komplizierter: Wie schon im Beispiel
fE<uuml>r {filter => 2} gezeigt, benE<ouml>tigen wir hier wieder zwei scalar Variablen ('$p1' und '$p3')
um die Parameter in '/@p1' und '/@p3' aufzunehmen und sie dann zu E<uuml>bertragen. ZusE<auml>tzlich
mE<uuml>ssen wir hier jedoch auch noch Text-Werte zE<auml>hlen kE<ouml>nnen (siehe scalar Variable '$count'),
sodass wir zwischen dem ersten Wert 'start...' (welchen wir ausgeben wollen) und dem zweiten
Wert 'end...' (welchen wir nicht ausgeben wollen) unterscheiden kE<ouml>nnen.

  my $rdr = XML::Reader->newhd(\$text,
    {filter => 4, using => '/start/param/data/item'}) or die "Error: $!";

  my ($count, $p1, $p3);

  while ($rdr->iterate) {
      if    ($rdr->path eq '/@p1') { $p1 = $rdr->value; }
      elsif ($rdr->path eq '/@p3') { $p3 = $rdr->value; }
      elsif ($rdr->path eq '/') {
          if    ($rdr->is_start) { $count = 0; $p1 = undef; $p3 = undef; }
          elsif ($rdr->is_text) {
              $count++;
              if ($count == 1) {
                  printf "item = '%s', p1 = '%s', p3 = '%s'\n",
                    $rdr->value, $p1, $p3;
              }
          }
      }
  }

=head1 FUNKTIONEN

=head2 Funktion slurp_xml

Die Funktion slurp_xml liest eine XML Datei und legt die Daten in einer Array-Referenz ab. Hier ist
ein Beispiel in dem wir den Namen, die Strasse und die Stadt fE<uuml>r alle Kunden im Pfad
'/data/order/database/customer' erhalten wollen. Wir wollen ausserdem alle Supplier im Pfad
'/data/supplier' erhalten:

  use XML::Reader qw(slurp_xml);

  my $line2 = q{
  <data>
    <supplier>ggg</supplier>
    <supplier>hhh</supplier>
    <order>
      <database>
        <customer name="smith" id="652">
          <street>high street</street>
          <city>boston</city>
        </customer>
        <customer name="jones" id="184">
          <street>maple street</street>
          <city>new york</city>
        </customer>
        <customer name="stewart" id="520">
          <street>ring road</street>
          <city>dallas</city>
        </customer>
      </database>
    </order>
    <dummy value="ttt">test</dummy>
    <supplier>iii</supplier>
    <supplier>jjj</supplier>
  </data>
  };

  my $aref = slurp_xml(\$line2,
    { root => '/data/order/database/customer', branch => ['/@name', '/street', '/city'] },
    { root => '/data/supplier',                branch => ['/']                          },
  );

  for (@{$aref->[0]}) {
      printf "Cust: Name = %-7s Street = %-12s City = %s\n", $_->[0], $_->[1], $_->[2];
  }

  print "\n";

  for (@{$aref->[1]}) {
      printf "Supp: Name = %s\n", $_->[0];
  }

Der erste Parameter in slurp_xml ist entweder der Dateiname (oder eine Skalar Referenz, oder ein offenes
Dateihandle) der XML Datei die wir einlesen wollen. In diesem Fall lesen wir von der Skalar Referenz \$line2.
Der nE<auml>chste Parameter ist die Wurzel des Baumes den wir einlesen wollen (in diesem Falle wE<auml>re das
'/data/order/database/customer') mit einer Liste von Elementen die wir, relativ zur Wurzel, selektieren
wollen, in diesem Falle wE<auml>re das ['/@name', '/street', '/city']. Der darauffolgende Parameter ist eine
zweite Wurzel (root/branch Definition), in diesem Falle ist es root => '/data/supplier' mit branch => ['/'].

Hier ist das Resultat:

  Cust: Name = smith   Street = high street  City = boston
  Cust: Name = jones   Street = maple street City = new york
  Cust: Name = stewart Street = ring road    City = dallas

  Supp: Name = ggg
  Supp: Name = hhh
  Supp: Name = iii
  Supp: Name = jjj

slurp_xml funktioniert E<auml>hnlich wie L<XML::Simple>, insofern als dass alle benE<ouml>tigten Informationen
in einem Rutsch in einer Speicherstruktur abgelegt werden. Der Unterschied jedoch ist dass slurp_xml uns erlaubt
spezifische Daten zu selektieren bevor das Einlesen beginnt. Dieses hat zur Folge dass die sich ergebende
Speicherstruktur meistens kleiner ist, und damit auch weniger kompliziert.

=head1 AUTOR

Klaus Eichner, March 2009

=head1 COPYRIGHT UND LIZENZ

Dieses ist der original Text auf Englisch:

Copyright (C) 2009 by Klaus Eichner.

All rights reserved. This program is free software; you can redistribute
it and/or modify it under the terms of the artistic license,
see L<http://www.opensource.org/licenses/artistic-license-1.0.php>

=head1 VERWANDTE MODULE

Falls Sie vorhaben XML auch ausgeben zu wollen, dann schlage ich vor das Modul XML::Writer zu
benutzen. Dieses Modul bietet ein einfach zu handhabendes Interface zur Ausgabe von XML-Dateien.
(Falls sie non-mixed content XML ausgeben, wE<uuml>rde ich empfehlen die Optionen DATA_MODE=>1 und
DATA_INDENT=>2 zu setzen, das erlaubt die korrekte Formatierung und EinrE<uuml>ckung in Ihrer XML
Ausgabe-Datei).

=head1 REFERENZEN

L<XML::TokeParser>,
L<XML::Simple>,
L<XML::Parser>,
L<XML::Parser::Expat>,
L<XML::TiePYX>,
L<XML::Writer>.

=cut
