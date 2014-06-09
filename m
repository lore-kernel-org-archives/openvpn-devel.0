From: "luigi bassi" <luigi.bassi@...1916...>
Date: Mon, 9 Jun 2014 14:52:09 +0200
Message-ID: <001301cf83e1$a04bdbc0$e0e39340$@bassi@...1916...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0014_01CF83F2.63D4ABC0"
Content-Language: it
Subject: [Openvpn-devel] installation openvpn with pfsense
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_0014_01CF83F2.63D4ABC0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0015_01CF83F2.63D4ABC0"

------=_NextPart_001_0015_01CF83F2.63D4ABC0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi all,

I can not connect to a server with openvpn in pfsense. 
I redid the configuration at least 10 times in all possible ways. 
I did create a pfsense certificates and then copied to my client, but
there's no way to connect 
The error in the logs of client that I have is as follows:

 

 

Mon Jun 09 14:12:25 2014 OpenVPN 2.3.2 x86_64-w64-mingw32 [SSL (OpenSSL)]
[LZO] [PKCS11] [eurephia] [IPv6] built on Jun  5 2014

Enter Management Password:

Mon Jun 09 14:12:25 2014 MANAGEMENT: TCP Socket listening on
[AF_INET]127.0.0.1:25341

Mon Jun 09 14:12:25 2014 Need hold release from management interface,
waiting...

Mon Jun 09 14:12:26 2014 MANAGEMENT: Client connected from
[AF_INET]127.0.0.1:25341

Mon Jun 09 14:12:26 2014 MANAGEMENT: CMD 'state on'

Mon Jun 09 14:12:26 2014 MANAGEMENT: CMD 'log all on'

Mon Jun 09 14:12:26 2014 MANAGEMENT: CMD 'hold off'

Mon Jun 09 14:12:26 2014 MANAGEMENT: CMD 'hold release'

Mon Jun 09 14:12:26 2014 Control Channel Authentication: using
'pfSense-TCP-1194-pfsense.bottarini.local-tls.key' as a OpenVPN static key
file

Mon Jun 09 14:12:26 2014 Outgoing Control Channel Authentication: Using 160
bit message hash 'SHA1' for HMAC authentication

Mon Jun 09 14:12:26 2014 Incoming Control Channel Authentication: Using 160
bit message hash 'SHA1' for HMAC authentication

Mon Jun 09 14:12:26 2014 Socket Buffers: R=[253952->253952] S=[81920->81920]

Mon Jun 09 14:12:26 2014 MANAGEMENT: >STATE:1402315946,RESOLVE,,,

Mon Jun 09 14:12:27 2014 Attempting to establish TCP connection with
[AF_INET]79.1.144.26:1194

Mon Jun 09 14:12:27 2014 MANAGEMENT: >STATE:1402315947,TCP_CONNECT,,,

Mon Jun 09 14:12:48 2014 TCP: connect to [AF_INET]79.1.144.26:1194 failed,
will try again in 5 seconds: Connection timed out (WSAETIMEDOUT)

Mon Jun 09 14:12:53 2014 MANAGEMENT: >STATE:1402315973,RESOLVE,,,

Mon Jun 09 14:12:53 2014 MANAGEMENT: >STATE:1402315973,TCP_CONNECT,,,

Mon Jun 09 14:13:14 2014 TCP: connect to [AF_INET]79.1.144.26:1194 failed,

 

Please solve this problem is very urgent and important for me. 
Thanks in advance 
Sincerely.

 

 

I use on the client windows 7 64 bit

the version of openvpn is : see the picture

 

 

Luigi Bassi

Via Tomaso Nani, 40 - 23100 Sondrio (SO) 

P.IVA 00849450143 C.F. BSSLGU49C13L908C

Tel. 0342/514649 - Fax 0342/053260 - Mobile 335/6634681 

 

----------------------------------------------------------------------------
------------------------------------------------------

Ai sensi del D. Lgs. n.196/2003, si precisa che le informazioni contenute in
questo messaggio e negli eventuali allegati sono 

riservate e per uso esclusivo del destinatario. Persone diverse dallo stesso
non possono copiare o distribuire il messaggio a terzi.

This message may contain information which is confidential or privileged. If
you are not the intended recipient, please telephone

or email the sender and delete this message and any attachment from your
system, without retaining a copy.

 


------=_NextPart_001_0015_01CF83F2.63D4ABC0
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Micros=
oft Word 12 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"Comic Sans MS";
	panose-1:3 15 7 2 3 3 2 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0mm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.StileMessaggioDiPostaElettronica17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.hps
	{mso-style-name:hps;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 20.0mm 20.0mm 20.0mm;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DIT link=3Dblue vlink=
=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal><span lang=3DEN-US=
 style=3D'font-size:12.0pt;font-family:"Arial","sans-serif"'>Hi all,<o:p></=
o:p></span></p><p class=3DMsoNormal><span lang=3DEN style=3D'font-size:12.0=
pt;font-family:"Arial","sans-serif"'>I can not connect to a server with ope=
nvpn in pfsense. <br>I redid the configuration at least 10 times in all pos=
sible ways. <br>I did create a pfsense certificates and then copied to my c=
lient, but there's no way to connect <br>The error in the logs of client th=
at I have is as follows:<o:p></o:p></span></p><p class=3DMsoNormal><span la=
ng=3DEN style=3D'font-size:12.0pt;font-family:"Arial","sans-serif"'><o:p>&n=
bsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-=
size:12.0pt;font-family:"Arial","sans-serif"'><o:p>&nbsp;</o:p></span></p><=
p class=3DMsoNormal><span lang=3DEN-US>Mon Jun 09 14:12:25 2014 OpenVPN 2.3=
.2 x86_64-w64-mingw32 [SSL (OpenSSL)] [LZO] [PKCS11] [eurephia] [IPv6] buil=
t on Jun&nbsp; 5 2014<o:p></o:p></span></p><p class=3DMsoNormal><span lang=
=3DEN-US>Enter Management Password:<o:p></o:p></span></p><p class=3DMsoNorm=
al><span lang=3DEN-US>Mon Jun 09 14:12:25 2014 MANAGEMENT: TCP Socket liste=
ning on [AF_INET]127.0.0.1:25341<o:p></o:p></span></p><p class=3DMsoNormal>=
<span lang=3DEN-US>Mon Jun 09 14:12:25 2014 Need hold release from manageme=
nt interface, waiting...<o:p></o:p></span></p><p class=3DMsoNormal><span la=
ng=3DEN-US>Mon Jun 09 14:12:26 2014 MANAGEMENT: Client connected from [AF_I=
NET]127.0.0.1:25341<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3D=
EN-US>Mon Jun 09 14:12:26 2014 MANAGEMENT: CMD 'state on'<o:p></o:p></span>=
</p><p class=3DMsoNormal><span lang=3DEN-US>Mon Jun 09 14:12:26 2014 MANAGE=
MENT: CMD 'log all on'<o:p></o:p></span></p><p class=3DMsoNormal><span lang=
=3DEN-US>Mon Jun 09 14:12:26 2014 MANAGEMENT: CMD 'hold off'<o:p></o:p></sp=
an></p><p class=3DMsoNormal><span lang=3DEN-US>Mon Jun 09 14:12:26 2014 MAN=
AGEMENT: CMD 'hold release'<o:p></o:p></span></p><p class=3DMsoNormal><span=
 lang=3DEN-US>Mon Jun 09 14:12:26 2014 Control Channel Authentication: usin=
g 'pfSense-TCP-1194-pfsense.bottarini.local-tls.key' as a OpenVPN static ke=
y file<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>Mon Jun=
 09 14:12:26 2014 Outgoing Control Channel Authentication: Using 160 bit me=
ssage hash 'SHA1' for HMAC authentication<o:p></o:p></span></p><p class=3DM=
soNormal><span lang=3DEN-US>Mon Jun 09 14:12:26 2014 Incoming Control Chann=
el Authentication: Using 160 bit message hash 'SHA1' for HMAC authenticatio=
n<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>Mon Jun 09 1=
4:12:26 2014 Socket Buffers: R=3D[253952-&gt;253952] S=3D[81920-&gt;81920]<=
o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>Mon Jun 09 14:=
12:26 2014 MANAGEMENT: &gt;STATE:1402315946,RESOLVE,,,<o:p></o:p></span></p=
><p class=3DMsoNormal><span lang=3DEN-US>Mon Jun 09 14:12:27 2014 Attemptin=
g to establish TCP connection with [AF_INET]79.1.144.26:1194<o:p></o:p></sp=
an></p><p class=3DMsoNormal><span lang=3DEN-US>Mon Jun 09 14:12:27 2014 MAN=
AGEMENT: &gt;STATE:1402315947,TCP_CONNECT,,,<o:p></o:p></span></p><p class=
=3DMsoNormal><span lang=3DEN-US>Mon Jun 09 14:12:48 2014 TCP: connect to [A=
F_INET]79.1.144.26:1194 failed, will try again in 5 seconds: Connection tim=
ed out (WSAETIMEDOUT)<o:p></o:p></span></p><p class=3DMsoNormal><span lang=
=3DEN-US>Mon Jun 09 14:12:53 2014 MANAGEMENT: &gt;STATE:1402315973,RESOLVE,=
,,<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>Mon Jun 09 =
14:12:53 2014 MANAGEMENT: &gt;STATE:1402315973,TCP_CONNECT,,,<o:p></o:p></s=
pan></p><p class=3DMsoNormal><span lang=3DEN-US>Mon Jun 09 14:13:14 2014 TC=
P: connect to [AF_INET]79.1.144.26:1194 failed,<o:p></o:p></span></p><p cla=
ss=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMs=
oNormal><span class=3Dhps><span lang=3DEN style=3D'font-family:"Arial","san=
s-serif"'>Please</span></span><span lang=3DEN style=3D'font-family:"Arial",=
"sans-serif"'> <span class=3Dhps>solve this</span> <span class=3Dhps>proble=
m</span> <span class=3Dhps>is</span> <span class=3Dhps>very</span> <span cl=
ass=3Dhps>urgent and important</span> <span class=3Dhps>for me</span>. <br>=
<span class=3Dhps>Thanks in advance</span> <br><span class=3Dhps>Sincerely<=
/span>.</span><span lang=3DEN-US style=3D'font-family:"Arial","sans-serif"'=
><o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;<=
/o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></=
span></p><p class=3DMsoNormal><span lang=3DEN-US>I use on the client window=
s 7 64 bit<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>the=
 version of openvpn is : see the picture<o:p></o:p></span></p><p class=3DMs=
oNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal=
><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><i><sp=
an style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif";color:black'=
>Luigi Bassi</span></i><span style=3D'font-size:9.5pt;font-family:"Tahoma",=
"sans-serif";color:black'><o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:8.0pt;font-family:"Comic Sans MS";color:black'>Via Tomas=
o Nani, 40 - 23100 Sondrio (SO)</span><span style=3D'font-size:9.5pt;font-f=
amily:"Tahoma","sans-serif";color:black'> <o:p></o:p></span></p><p class=3D=
MsoNormal><span style=3D'font-size:8.0pt;font-family:"Comic Sans MS";color:=
black'>P.IVA 00849450143 C.F. BSSLGU49C13L908C<o:p></o:p></span></p><p clas=
s=3DMsoNormal><span style=3D'font-size:8.0pt;font-family:"Comic Sans MS";co=
lor:black'>Tel. 0342/514649 - Fax 0342/053260 - Mobile 335/6634681 </span><=
span style=3D'font-size:9.5pt;font-family:"Tahoma","sans-serif";color:black=
'><o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'font-size:9.5pt=
;font-family:"Tahoma","sans-serif";color:black'><o:p>&nbsp;</o:p></span></p=
><p class=3DMsoNormal><span style=3D'font-size:9.5pt;font-family:"Tahoma","=
sans-serif";color:black'>--------------------------------------------------=
---------------------------------------------------------------------------=
-----<o:p></o:p></span></p><p class=3DMsoNormal><i><span style=3D'font-size=
:9.0pt'>Ai sensi del D. Lgs. n.196/2003, si precisa che le informazioni con=
tenute in questo messaggio e negli eventuali allegati sono <o:p></o:p></spa=
n></i></p><p class=3DMsoNormal><i><span style=3D'font-size:9.0pt'>riservate=
 e per uso esclusivo del destinatario. Persone diverse dallo stesso non pos=
sono copiare o distribuire il messaggio a terzi.<br><br></span></i><i><span=
 lang=3DEN-US style=3D'font-size:9.0pt'>This message may contain informatio=
n which is confidential or privileged. If you are not the intended recipien=
t, please telephone<o:p></o:p></span></i></p><p class=3DMsoNormal><i><span =
lang=3DEN-US style=3D'font-size:9.0pt'>or email the sender and delete this =
message and any attachment from your system, without retaining a copy.<o:p>=
</o:p></span></i></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o=
:p></span></p></div></body></html>=

------=_NextPart_001_0015_01CF83F2.63D4ABC0--

------=_NextPart_000_0014_01CF83F2.63D4ABC0
Content-Type: application/octet-stream;
	name="Cattura.PNG"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="Cattura.PNG"

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
AABJRU5ErkJggg==

------=_NextPart_000_0014_01CF83F2.63D4ABC0--


