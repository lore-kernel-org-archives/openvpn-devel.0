From: "Richard Francis" <rfransix@...164...>
Date: Fri, 7 Oct 2011 14:55:37 -0500
Message-ID: <056601cc852b$1637b7e0$42a727a0$@net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0567_01CC8501.2D61AFE0"
Content-Language: en-us
Subject: [Openvpn-devel] Fatal Error on XP
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

------=_NextPart_000_0567_01CC8501.2D61AFE0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Hi, anyone can help? Greatly appreciative of your expertise.

 

Fri Oct 07 14:41:38 2011 us=958000 Current Parameter Settings:

Fri Oct 07 14:41:38 2011 us=958000 config = 'VPN.ovpn'

Fri Oct 07 14:41:38 2011 us=958000 mode = 0

Fri Oct 07 14:41:38 2011 us=958000 show_ciphers = DISABLED

Fri Oct 07 14:41:38 2011 us=958000 show_digests = DISABLED

Fri Oct 07 14:41:38 2011 us=958000 show_engines = DISABLED

Fri Oct 07 14:41:38 2011 us=958000 genkey = DISABLED

Fri Oct 07 14:41:38 2011 us=958000 key_pass_file = '[UNDEF]'

Fri Oct 07 14:41:38 2011 us=958000 show_tls_ciphers = DISABLED

Fri Oct 07 14:41:38 2011 us=958000 Connection profiles [default]:

Fri Oct 07 14:41:38 2011 us=958000 proto = tcp-client

Fri Oct 07 14:41:38 2011 us=958000 local = '[UNDEF]'

Fri Oct 07 14:41:38 2011 us=958000 local_port = 0

Fri Oct 07 14:41:38 2011 us=958000 remote = 'vpn.certify.com'

Fri Oct 07 14:41:38 2011 us=958000 remote_port = 443

Fri Oct 07 14:41:38 2011 us=958000 remote_float = DISABLED

Fri Oct 07 14:41:38 2011 us=958000 bind_defined = DISABLED

Fri Oct 07 14:41:38 2011 us=958000 bind_local = DISABLED

Fri Oct 07 14:41:38 2011 us=958000 connect_retry_seconds = 5

Fri Oct 07 14:41:38 2011 us=958000 connect_timeout = 10

Fri Oct 07 14:41:38 2011 us=958000 NOTE: --mute triggered...

Fri Oct 07 14:41:38 2011 us=958000 252 variation(s) on previous 20
message(s) suppressed by --mute

Fri Oct 07 14:41:38 2011 us=958000 OpenVPN 2.1.3 i686-pc-mingw32 [SSL]
[LZO2] [PKCS11] built on Aug 20 2010

Fri Oct 07 14:41:38 2011 us=978000 WARNING: No server certificate
verification method has been enabled. See http://openvpn.net/howto.html#mitm
for more info.

Fri Oct 07 14:41:38 2011 us=978000 NOTE: OpenVPN 2.1 requires
'--script-security 2' or higher to call user-defined scripts or executables

Fri Oct 07 14:41:39 2011 us=508000 LZO compression initialized

Fri Oct 07 14:41:39 2011 us=528000 Control Channel MTU parms [ L:1576 D:140
EF:40 EB:0 ET:0 EL:0 ]

Fri Oct 07 14:41:39 2011 us=538000 Socket Buffers: R=[8192->8192]
S=[8192->8192]

Fri Oct 07 14:41:39 2011 us=819000 Data Channel MTU parms [ L:1576 D:1450
EF:44 EB:135 ET:32 EL:0 AF:3/1 ]

Fri Oct 07 14:41:39 2011 us=819000 Local Options String: 'V4,dev-type
tap,link-mtu 1576,tun-mtu 1532,proto TCPv4_CLIENT,comp-lzo,cipher
BF-CBC,auth SHA1,keysize 128,key-method 2,tls-client'

Fri Oct 07 14:41:39 2011 us=819000 Expected Remote Options String:
'V4,dev-type tap,link-mtu 1576,tun-mtu 1532,proto
TCPv4_SERVER,comp-lzo,cipher BF-CBC,auth SHA1,keysize 128,key-method
2,tls-server'

Fri Oct 07 14:41:39 2011 us=819000 Local Options hash (VER=V4): '31fdf004'

Fri Oct 07 14:41:39 2011 us=819000 Expected Remote Options hash (VER=V4):
'3e6d1056'

Fri Oct 07 14:41:39 2011 us=819000 Attempting to establish TCP connection
with 1.1.1.1:443

Fri Oct 07 14:41:39 2011 us=909000 TCP connection established with
1.1.1.1:443

Fri Oct 07 14:41:39 2011 us=909000 TCPv4_CLIENT link local: [undef]

Fri Oct 07 14:41:39 2011 us=909000 TCPv4_CLIENT link remote: 1.1.1.1:443

Fri Oct 07 14:41:39 2011 us=979000 TLS: Initial packet from 1.1.1.1:443,
sid=48fe7a7z 189d19pc

Fri Oct 07 14:41:41 2011 us=401000 VERIFY ERROR: depth=1, error=self signed
certificate in certificate chain:
/C=US/ST=NewYork/L=minerals/O=certify.com/OU=R_D/CN=certify/emailAddress=cer
tify@...1513...

Fri Oct 07 14:41:41 2011 us=401000 TLS_ERROR: BIO read tls_read_plaintext
error: error:14090086:SSL routines:SSL3_GET_SERVER_CERTIFICATE:certificate
verify failed

Fri Oct 07 14:41:41 2011 us=401000 TLS Error: TLS object -> incoming
plaintext read error

Fri Oct 07 14:41:41 2011 us=401000 TLS Error: TLS handshake failed

Fri Oct 07 14:41:41 2011 us=401000 Fatal TLS error (check_tls_errors_co),
restarting

Fri Oct 07 14:41:41 2011 us=401000 TCP/UDP: Closing socket

Fri Oct 07 14:41:41 2011 us=411000 SIGUSR1[soft,tls-error] received, process
restarting

Fri Oct 07 14:41:41 2011 us=411000 Restart pause, 5 second(s)

 

 

Richard Francis

 <http://www.pelicancomputers.us> http://www.pelicancomputers.us

1.847.256.0639

 


------=_NextPart_000_0567_01CC8501.2D61AFE0
Content-Type: text/html; charset="US-ASCII"
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
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue vli=
nk=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal>Hi, anyone can h=
elp? Greatly appreciative of your expertise.<o:p></o:p></p><p class=3DMsoNo=
rmal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal><span style=3D'font-size:7.5=
pt;font-family:"Tahoma","sans-serif";color:black'>Fri Oct 07 14:41:38 2011 =
us=3D958000 Current Parameter Settings:</span><span style=3D'font-size:10.0=
pt;font-family:"Tahoma","sans-serif";color:black'><o:p></o:p></span></p><p =
class=3DMsoNormal><span style=3D'font-size:7.5pt;font-family:"Tahoma","sans=
-serif";color:black'>Fri Oct 07 14:41:38 2011 us=3D958000 config =3D 'VPN.o=
vpn'</span><span style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif=
";color:black'><o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'fo=
nt-size:7.5pt;font-family:"Tahoma","sans-serif";color:black'>Fri Oct 07 14:=
41:38 2011 us=3D958000 mode =3D 0</span><span style=3D'font-size:10.0pt;fon=
t-family:"Tahoma","sans-serif";color:black'><o:p></o:p></span></p><p class=
=3DMsoNormal><span style=3D'font-size:7.5pt;font-family:"Tahoma","sans-seri=
f";color:black'>Fri Oct 07 14:41:38 2011 us=3D958000 show_ciphers =3D DISAB=
LED</span><span style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"=
;color:black'><o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'fon=
t-size:7.5pt;font-family:"Tahoma","sans-serif";color:black'>Fri Oct 07 14:4=
1:38 2011 us=3D958000 show_digests =3D DISABLED</span><span style=3D'font-s=
ize:10.0pt;font-family:"Tahoma","sans-serif";color:black'><o:p></o:p></span=
></p><p class=3DMsoNormal><span style=3D'font-size:7.5pt;font-family:"Tahom=
a","sans-serif";color:black'>Fri Oct 07 14:41:38 2011 us=3D958000 show_engi=
nes =3D DISABLED</span><span style=3D'font-size:10.0pt;font-family:"Tahoma"=
,"sans-serif";color:black'><o:p></o:p></span></p><p class=3DMsoNormal><span=
 style=3D'font-size:7.5pt;font-family:"Tahoma","sans-serif";color:black'>Fr=
i Oct 07 14:41:38 2011 us=3D958000 genkey =3D DISABLED</span><span style=3D=
'font-size:10.0pt;font-family:"Tahoma","sans-serif";color:black'><o:p></o:p=
></span></p><p class=3DMsoNormal><span style=3D'font-size:7.5pt;font-family=
:"Tahoma","sans-serif";color:black'>Fri Oct 07 14:41:38 2011 us=3D958000 ke=
y_pass_file =3D '[UNDEF]'</span><span style=3D'font-size:10.0pt;font-family=
:"Tahoma","sans-serif";color:black'><o:p></o:p></span></p><p class=3DMsoNor=
mal><span style=3D'font-size:7.5pt;font-family:"Tahoma","sans-serif";color:=
black'>Fri Oct 07 14:41:38 2011 us=3D958000 show_tls_ciphers =3D DISABLED</=
span><span style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif";colo=
r:black'><o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'font-siz=
e:7.5pt;font-family:"Tahoma","sans-serif";color:black'>Fri Oct 07 14:41:38 =
2011 us=3D958000 Connection profiles [default]:</span><span style=3D'font-s=
ize:10.0pt;font-family:"Tahoma","sans-serif";color:black'><o:p></o:p></span=
></p><p class=3DMsoNormal><span style=3D'font-size:7.5pt;font-family:"Tahom=
a","sans-serif";color:black'>Fri Oct 07 14:41:38 2011 us=3D958000 proto =3D=
 tcp-client</span><span style=3D'font-size:10.0pt;font-family:"Tahoma","san=
s-serif";color:black'><o:p></o:p></span></p><p class=3DMsoNormal><span styl=
e=3D'font-size:7.5pt;font-family:"Tahoma","sans-serif";color:black'>Fri Oct=
 07 14:41:38 2011 us=3D958000 local =3D '[UNDEF]'</span><span style=3D'font=
-size:10.0pt;font-family:"Tahoma","sans-serif";color:black'><o:p></o:p></sp=
an></p><p class=3DMsoNormal><span style=3D'font-size:7.5pt;font-family:"Tah=
oma","sans-serif";color:black'>Fri Oct 07 14:41:38 2011 us=3D958000 local_p=
ort =3D 0</span><span style=3D'font-size:10.0pt;font-family:"Tahoma","sans-=
serif";color:black'><o:p></o:p></span></p><p class=3DMsoNormal><span style=
=3D'font-size:7.5pt;font-family:"Tahoma","sans-serif";color:black'>Fri Oct =
07 14:41:38 2011 us=3D958000 remote =3D 'vpn.certify.com'</span><span style=
=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif";color:black'><o:p></=
o:p></span></p><p class=3DMsoNormal><span style=3D'font-size:7.5pt;font-fam=
ily:"Tahoma","sans-serif";color:black'>Fri Oct 07 14:41:38 2011 us=3D958000=
 remote_port =3D 443</span><span style=3D'font-size:10.0pt;font-family:"Tah=
oma","sans-serif";color:black'><o:p></o:p></span></p><p class=3DMsoNormal><=
span style=3D'font-size:7.5pt;font-family:"Tahoma","sans-serif";color:black=
'>Fri Oct 07 14:41:38 2011 us=3D958000 remote_float =3D DISABLED</span><spa=
n style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif";color:black'>=
<o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'font-size:7.5pt;f=
ont-family:"Tahoma","sans-serif";color:black'>Fri Oct 07 14:41:38 2011 us=
=3D958000 bind_defined =3D DISABLED</span><span style=3D'font-size:10.0pt;f=
ont-family:"Tahoma","sans-serif";color:black'><o:p></o:p></span></p><p clas=
s=3DMsoNormal><span style=3D'font-size:7.5pt;font-family:"Tahoma","sans-ser=
if";color:black'>Fri Oct 07 14:41:38 2011 us=3D958000 bind_local =3D DISABL=
ED</span><span style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif";=
color:black'><o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'font=
-size:7.5pt;font-family:"Tahoma","sans-serif";color:black'>Fri Oct 07 14:41=
:38 2011 us=3D958000 connect_retry_seconds =3D 5</span><span style=3D'font-=
size:10.0pt;font-family:"Tahoma","sans-serif";color:black'><o:p></o:p></spa=
n></p><p class=3DMsoNormal><span style=3D'font-size:7.5pt;font-family:"Taho=
ma","sans-serif";color:black'>Fri Oct 07 14:41:38 2011 us=3D958000 connect_=
timeout =3D 10</span><span style=3D'font-size:10.0pt;font-family:"Tahoma","=
sans-serif";color:black'><o:p></o:p></span></p><p class=3DMsoNormal><span s=
tyle=3D'font-size:7.5pt;font-family:"Tahoma","sans-serif";color:black'>Fri =
Oct 07 14:41:38 2011 us=3D958000 NOTE: --mute triggered...</span><span styl=
e=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif";color:black'><o:p><=
/o:p></span></p><p class=3DMsoNormal><span style=3D'font-size:7.5pt;font-fa=
mily:"Tahoma","sans-serif";color:black'>Fri Oct 07 14:41:38 2011 us=3D95800=
0 252 variation(s) on previous 20 message(s) suppressed by --mute</span><sp=
an style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif";color:black'=
><o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'font-size:7.5pt;=
font-family:"Tahoma","sans-serif";color:black'>Fri Oct 07 14:41:38 2011 us=
=3D958000 OpenVPN 2.1.3 i686-pc-mingw32 [SSL] [LZO2] [PKCS11] built on Aug =
20 2010</span><span style=3D'font-size:10.0pt;font-family:"Tahoma","sans-se=
rif";color:black'><o:p></o:p></span></p><p class=3DMsoNormal><span style=3D=
'font-size:7.5pt;font-family:"Tahoma","sans-serif";color:black'>Fri Oct 07 =
14:41:38 2011 us=3D978000 WARNING: No server certificate verification metho=
d has been enabled. See http://openvpn.net/howto.html#mitm for more info.</=
span><span style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif";colo=
r:black'><o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'font-siz=
e:7.5pt;font-family:"Tahoma","sans-serif";color:black'>Fri Oct 07 14:41:38 =
2011 us=3D978000 NOTE: OpenVPN 2.1 requires '--script-security 2' or higher=
 to call user-defined scripts or executables</span><span style=3D'font-size=
:10.0pt;font-family:"Tahoma","sans-serif";color:black'><o:p></o:p></span></=
p><p class=3DMsoNormal><span style=3D'font-size:7.5pt;font-family:"Tahoma",=
"sans-serif";color:black'>Fri Oct 07 14:41:39 2011 us=3D508000 LZO compress=
ion initialized</span><span style=3D'font-size:10.0pt;font-family:"Tahoma",=
"sans-serif";color:black'><o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:7.5pt;font-family:"Tahoma","sans-serif";color:black'>Fri=
 Oct 07 14:41:39 2011 us=3D528000 Control Channel MTU parms [ L:1576 D:140 =
EF:40 EB:0 ET:0 EL:0 ]</span><span style=3D'font-size:10.0pt;font-family:"T=
ahoma","sans-serif";color:black'><o:p></o:p></span></p><p class=3DMsoNormal=
><span style=3D'font-size:7.5pt;font-family:"Tahoma","sans-serif";color:bla=
ck'>Fri Oct 07 14:41:39 2011 us=3D538000 Socket Buffers: R=3D[8192-&gt;8192=
] S=3D[8192-&gt;8192]</span><span style=3D'font-size:10.0pt;font-family:"Ta=
homa","sans-serif";color:black'><o:p></o:p></span></p><p class=3DMsoNormal>=
<span style=3D'font-size:7.5pt;font-family:"Tahoma","sans-serif";color:blac=
k'>Fri Oct 07 14:41:39 2011 us=3D819000 Data Channel MTU parms [ L:1576 D:1=
450 EF:44 EB:135 ET:32 EL:0 AF:3/1 ]</span><span style=3D'font-size:10.0pt;=
font-family:"Tahoma","sans-serif";color:black'><o:p></o:p></span></p><p cla=
ss=3DMsoNormal><span style=3D'font-size:7.5pt;font-family:"Tahoma","sans-se=
rif";color:black'>Fri Oct 07 14:41:39 2011 us=3D819000 Local Options String=
: 'V4,dev-type tap,link-mtu 1576,tun-mtu 1532,proto TCPv4_CLIENT,comp-lzo,c=
ipher BF-CBC,auth SHA1,keysize 128,key-method 2,tls-client'</span><span sty=
le=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif";color:black'><o:p>=
</o:p></span></p><p class=3DMsoNormal><span style=3D'font-size:7.5pt;font-f=
amily:"Tahoma","sans-serif";color:black'>Fri Oct 07 14:41:39 2011 us=3D8190=
00 Expected Remote Options String: 'V4,dev-type tap,link-mtu 1576,tun-mtu 1=
532,proto TCPv4_SERVER,comp-lzo,cipher BF-CBC,auth SHA1,keysize 128,key-met=
hod 2,tls-server'</span><span style=3D'font-size:10.0pt;font-family:"Tahoma=
","sans-serif";color:black'><o:p></o:p></span></p><p class=3DMsoNormal><spa=
n style=3D'font-size:7.5pt;font-family:"Tahoma","sans-serif";color:black'>F=
ri Oct 07 14:41:39 2011 us=3D819000 Local Options hash (VER=3DV4): '31fdf00=
4'</span><span style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif";=
color:black'><o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'font=
-size:7.5pt;font-family:"Tahoma","sans-serif";color:black'>Fri Oct 07 14:41=
:39 2011 us=3D819000 Expected Remote Options hash (VER=3DV4): '3e6d1056'</s=
pan><span style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif";color=
:black'><o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'font-size=
:7.5pt;font-family:"Tahoma","sans-serif";color:black'>Fri Oct 07 14:41:39 2=
011 us=3D819000 Attempting to establish TCP connection with 1.1.1.1:443</sp=
an><span style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif";color:=
black'><o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'font-size:=
7.5pt;font-family:"Tahoma","sans-serif";color:black'>Fri Oct 07 14:41:39 20=
11 us=3D909000 TCP connection established with 1.1.1.1:443</span><span styl=
e=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif";color:black'><o:p><=
/o:p></span></p><p class=3DMsoNormal><span style=3D'font-size:7.5pt;font-fa=
mily:"Tahoma","sans-serif";color:black'>Fri Oct 07 14:41:39 2011 us=3D90900=
0 TCPv4_CLIENT link local: [undef]</span><span style=3D'font-size:10.0pt;fo=
nt-family:"Tahoma","sans-serif";color:black'><o:p></o:p></span></p><p class=
=3DMsoNormal><span style=3D'font-size:7.5pt;font-family:"Tahoma","sans-seri=
f";color:black'>Fri Oct 07 14:41:39 2011 us=3D909000 TCPv4_CLIENT link remo=
te: 1.1.1.1:443</span><span style=3D'font-size:10.0pt;font-family:"Tahoma",=
"sans-serif";color:black'><o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:7.5pt;font-family:"Tahoma","sans-serif";color:black'>Fri=
 Oct 07 14:41:39 2011 us=3D979000 TLS: Initial packet from 1.1.1.1:443, sid=
=3D48fe7a7z 189d19pc</span><span style=3D'font-size:10.0pt;font-family:"Tah=
oma","sans-serif";color:black'><o:p></o:p></span></p><p class=3DMsoNormal><=
span style=3D'font-size:7.5pt;font-family:"Tahoma","sans-serif";color:black=
'>Fri Oct 07 14:41:41 2011 us=3D401000 VERIFY ERROR: depth=3D1, error=3Dsel=
f signed certificate in certificate chain: /C=3DUS/ST=3DNewYork/L=3Dmineral=
s/O=3Dcertify.com/OU=3DR_D/CN=3Dcertify/emailAddress=3Dcertify@...1513...</=
span><span style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif";colo=
r:black'><o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'font-siz=
e:7.5pt;font-family:"Tahoma","sans-serif";color:black'>Fri Oct 07 14:41:41 =
2011 us=3D401000 TLS_ERROR: BIO read tls_read_plaintext error: error:140900=
86:SSL routines:SSL3_GET_SERVER_CERTIFICATE:certificate verify failed</span=
><span style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif";color:bl=
ack'><o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'font-size:7.=
5pt;font-family:"Tahoma","sans-serif";color:black'>Fri Oct 07 14:41:41 2011=
 us=3D401000 TLS Error: TLS object -&gt; incoming plaintext read error</spa=
n><span style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif";color:b=
lack'><o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'font-size:7=
.5pt;font-family:"Tahoma","sans-serif";color:black'>Fri Oct 07 14:41:41 201=
1 us=3D401000 TLS Error: TLS handshake failed</span><span style=3D'font-siz=
e:10.0pt;font-family:"Tahoma","sans-serif";color:black'><o:p></o:p></span><=
/p><p class=3DMsoNormal><span style=3D'font-size:7.5pt;font-family:"Tahoma"=
,"sans-serif";color:black'>Fri Oct 07 14:41:41 2011 us=3D401000 Fatal TLS e=
rror (check_tls_errors_co), restarting</span><span style=3D'font-size:10.0p=
t;font-family:"Tahoma","sans-serif";color:black'><o:p></o:p></span></p><p c=
lass=3DMsoNormal><span style=3D'font-size:7.5pt;font-family:"Tahoma","sans-=
serif";color:black'>Fri Oct 07 14:41:41 2011 us=3D401000 TCP/UDP: Closing s=
ocket</span><span style=3D'font-size:10.0pt;font-family:"Tahoma","sans-seri=
f";color:black'><o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'f=
ont-size:7.5pt;font-family:"Tahoma","sans-serif";color:black'>Fri Oct 07 14=
:41:41 2011 us=3D411000 SIGUSR1[soft,tls-error] received, process restartin=
g</span><span style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif";c=
olor:black'><o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'font-=
size:7.5pt;font-family:"Tahoma","sans-serif";color:black'>Fri Oct 07 14:41:=
41 2011 us=3D411000 Restart pause, 5 second(s)<o:p></o:p></span></p><p clas=
s=3DMsoNormal><span style=3D'font-size:7.5pt;font-family:"Tahoma","sans-ser=
if";color:black'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span sty=
le=3D'font-size:7.5pt;font-family:"Tahoma","sans-serif";color:black'><o:p>&=
nbsp;</o:p></span></p><p class=3DMsoNormal> <o:p></o:p></p><p class=3DMsoNo=
rmal><span style=3D'color:#1F497D'>Richard Francis<o:p></o:p></span></p><p =
class=3DMsoNormal><span style=3D'color:#1F497D'><a href=3D"http://www.pelic=
ancomputers.us"><span style=3D'color:blue'>http://www.pelicancomputers.us</=
span></a><o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'color:#1=
F497D'>1.847.256.0639</span><span style=3D'color:#1F497D'><o:p></o:p></span=
></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>=

------=_NextPart_000_0567_01CC8501.2D61AFE0--


