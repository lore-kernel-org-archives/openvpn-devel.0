Message-ID: <20060711142754.71699.qmail@...697...>
Date: Tue, 11 Jul 2006 07:27:54 -0700 (PDT)
From: feramus coban <feramuslinux@...109...>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-122587314-1152628074=:65617"
Content-Transfer-Encoding: 8bit
Subject: [Openvpn-devel] Openvpn acces limit for user
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0-122587314-1152628074=:65617
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi All
  =20
  this is the problem,
  =20
  i have winxp pro server. i use it for openvpn as a server.
  i have a lot of client in alot of networks.=20
  =20
  example of my network
  =20
                  Type  Adres Of machine  Virtual =DDp    server  www.serve=
r.com  10.0.0.1    serverclient1  www.server.com  10.0.0.4    serverclient2=
  www.server.com  10.0.0.6    serverclient3  www.server.com  10.0.0.8    se=
rverclient4  www.server.com  10.0.0.10    net2client1  www.net2client1.com =
 10.0.0.12    net2client2  www.net2client2.com  10.0.0.14    net2client3  w=
ww.net2client3.com  10.0.0.16    net2client4  www.net2client4.com  10.0.0.1=
8    net3client1  www.net3client1.com  10.0.0.20    net3client2  www.net3cl=
ient2.com  10.0.0.22    net3client3  www.net3client3.com  10.0.0.24    net3=
client4  www.net3client4.com  10.0.0.26    net4client1  www.net4client1.com=
  10.0.0.28    net4client2  www.net4client2.com  10.0.0.30    net4client3  =
www.net4client3.com  10.0.0.32    net4client4  www.net4client4.com  10.0.0.=
34
  =20
  i use client-to-client parameter in all .ovpn file.
  =20
  i use an accounting software on terminal services.=20
  all user can acces server. But at now i want only some client can access =
server. for example only serverclient* user. and serverclient* clients can =
acces to all other clients. and net4client4 can acces all other clients to.=
=20
  =20
  i do not want to use 3 th part firewall for dropping package (iptables et=
c..)
  is it possible with openvpn
  =20
  this is my server conf file=20
  ****************************************
  port 84
proto udp
dev tun
ca ca.crt
certvpnserver1.crt
key vpnserver1.key=20
  dh dh1024.pem
server 10.0.0. 255.255.255.0=20
ifconfig-pool-persist ipp.txt
push "route 10.0.0.0 255.255.255.0"=20
route 10.0.0.0 255.255.255.0=20
  client-to-client
  keepalive 10 120
max-clients 100
persist-key
persist-tun
status openvpn-status.log
verb 4
tls-auth ta.key 0
comp-lzo

  =20
  client .ovpn file
  ****************************
  client
dev tun
proto udp
remote www.server.com 84
resolv-retry infinite
nobind
persist-key
persist-tun
ca ca.crt
cert VPNCLIENT3.crt
key VPNCLIENT3.key =20
tls-auth ta.key 1
verb 3
comp-lzo

 	=09
---------------------------------
Want to be your own boss? Learn how on  Yahoo! Small Business.=20
--0-122587314-1152628074=:65617
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<DIV>Hi All</DIV>  <DIV>&nbsp;</DIV>  <DIV>this is the problem,</DIV>  <DIV=
>&nbsp;</DIV>  <DIV>i have winxp pro server. i use it for openvpn as a serv=
er.</DIV>  <DIV>i have a lot of client in alot of networks.&nbsp;</DIV>  <D=
IV>&nbsp;</DIV>  <DIV>example of my network</DIV>  <DIV>&nbsp;</DIV>  <DIV>=
  <TABLE style=3D"WIDTH: 270pt; BORDER-COLLAPSE: collapse" cellSpacing=3D0 =
cellPadding=3D0 width=3D359 border=3D0 x:str>  <COLGROUP>  <COL style=3D"WI=
DTH: 100pt; mso-width-source: userset; mso-width-alt: 5674" width=3D133>  <=
COL style=3D"WIDTH: 128pt; mso-width-source: userset; mso-width-alt: 7253" =
width=3D170>  <COL style=3D"WIDTH: 42pt" width=3D56>  <TBODY>  <TR style=3D=
"HEIGHT: 12.75pt" height=3D17>  <TD style=3D"BORDER-RIGHT: #d4d0c8; BORDER-=
TOP: #d4d0c8; BORDER-LEFT: #d4d0c8; WIDTH: 100pt; BORDER-BOTTOM: #d4d0c8; H=
EIGHT: 12.75pt; BACKGROUND-COLOR: transparent" width=3D133 height=3D17><FON=
T face=3D"Arial Narrow" size=3D2>Type</FONT></TD>  <TD style=3D"BORDER-RIGH=
T: #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEFT:
 #d4d0c8; WIDTH: 128pt; BORDER-BOTTOM: #d4d0c8; BACKGROUND-COLOR: transpare=
nt" width=3D170><FONT face=3D"Arial Narrow" size=3D2>Adres Of machine</FONT=
></TD>  <TD style=3D"BORDER-RIGHT: #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEF=
T: #d4d0c8; WIDTH: 42pt; BORDER-BOTTOM: #d4d0c8; BACKGROUND-COLOR: transpar=
ent" width=3D56><FONT face=3D"Arial Narrow" size=3D2>Virtual =DDp</FONT></T=
D></TR>  <TR style=3D"HEIGHT: 12.75pt" height=3D17>  <TD style=3D"BORDER-RI=
GHT: #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEFT: #d4d0c8; BORDER-BOTTOM: #d4=
d0c8; HEIGHT: 12.75pt; BACKGROUND-COLOR: transparent" height=3D17><FONT fac=
e=3D"Arial Narrow" size=3D2>server</FONT></TD>  <TD style=3D"BORDER-RIGHT: =
#d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEFT: #d4d0c8; BORDER-BOTTOM: #d4d0c8;=
 BACKGROUND-COLOR: transparent" x:fmla=3D'=3D"www."&amp;A2&amp;".com"'><FON=
T face=3D"Arial Narrow" size=3D2>www.server.com</FONT></TD>  <TD style=3D"B=
ORDER-RIGHT: #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEFT: #d4d0c8; BORDER-BOT=
TOM: #d4d0c8; BACKGROUND-COLOR: transparent"><FONT
 face=3D"Arial Narrow" size=3D2>10.0.0.1</FONT></TD></TR>  <TR style=3D"HEI=
GHT: 12.75pt" height=3D17>  <TD style=3D"BORDER-RIGHT: #d4d0c8; BORDER-TOP:=
 #d4d0c8; BORDER-LEFT: #d4d0c8; BORDER-BOTTOM: #d4d0c8; HEIGHT: 12.75pt; BA=
CKGROUND-COLOR: transparent" height=3D17><FONT face=3D"Arial Narrow" size=
=3D2>serverclient1</FONT></TD>  <TD style=3D"BORDER-RIGHT: #d4d0c8; BORDER-=
TOP: #d4d0c8; BORDER-LEFT: #d4d0c8; BORDER-BOTTOM: #d4d0c8; BACKGROUND-COLO=
R: transparent" x:fmla=3D"=3DB2"><FONT face=3D"Arial Narrow" size=3D2>www.s=
erver.com</FONT></TD>  <TD style=3D"BORDER-RIGHT: #d4d0c8; BORDER-TOP: #d4d=
0c8; BORDER-LEFT: #d4d0c8; BORDER-BOTTOM: #d4d0c8; BACKGROUND-COLOR: transp=
arent"><FONT face=3D"Arial Narrow" size=3D2>10.0.0.4</FONT></TD></TR>  <TR =
style=3D"HEIGHT: 12.75pt" height=3D17>  <TD style=3D"BORDER-RIGHT: #d4d0c8;=
 BORDER-TOP: #d4d0c8; BORDER-LEFT: #d4d0c8; BORDER-BOTTOM: #d4d0c8; HEIGHT:=
 12.75pt; BACKGROUND-COLOR: transparent" height=3D17><FONT face=3D"Arial Na=
rrow" size=3D2>serverclient2</FONT></TD>  <TD
 style=3D"BORDER-RIGHT: #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEFT: #d4d0c8;=
 BORDER-BOTTOM: #d4d0c8; BACKGROUND-COLOR: transparent" x:fmla=3D"=3DB3"><F=
ONT face=3D"Arial Narrow" size=3D2>www.server.com</FONT></TD>  <TD style=3D=
"BORDER-RIGHT: #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEFT: #d4d0c8; BORDER-B=
OTTOM: #d4d0c8; BACKGROUND-COLOR: transparent"><FONT face=3D"Arial Narrow" =
size=3D2>10.0.0.6</FONT></TD></TR>  <TR style=3D"HEIGHT: 12.75pt" height=3D=
17>  <TD style=3D"BORDER-RIGHT: #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEFT: =
#d4d0c8; BORDER-BOTTOM: #d4d0c8; HEIGHT: 12.75pt; BACKGROUND-COLOR: transpa=
rent" height=3D17><FONT face=3D"Arial Narrow" size=3D2>serverclient3</FONT>=
</TD>  <TD style=3D"BORDER-RIGHT: #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEFT=
: #d4d0c8; BORDER-BOTTOM: #d4d0c8; BACKGROUND-COLOR: transparent" x:fmla=3D=
"=3DB4"><FONT face=3D"Arial Narrow" size=3D2>www.server.com</FONT></TD>  <T=
D style=3D"BORDER-RIGHT: #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEFT: #d4d0c8=
; BORDER-BOTTOM: #d4d0c8; BACKGROUND-COLOR:
 transparent"><FONT face=3D"Arial Narrow" size=3D2>10.0.0.8</FONT></TD></TR=
>  <TR style=3D"HEIGHT: 12.75pt" height=3D17>  <TD style=3D"BORDER-RIGHT: #=
d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEFT: #d4d0c8; BORDER-BOTTOM: #d4d0c8; =
HEIGHT: 12.75pt; BACKGROUND-COLOR: transparent" height=3D17><FONT face=3D"A=
rial Narrow" size=3D2>serverclient4</FONT></TD>  <TD style=3D"BORDER-RIGHT:=
 #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEFT: #d4d0c8; BORDER-BOTTOM: #d4d0c8=
; BACKGROUND-COLOR: transparent" x:fmla=3D"=3DB5"><FONT face=3D"Arial Narro=
w" size=3D2>www.server.com</FONT></TD>  <TD style=3D"BORDER-RIGHT: #d4d0c8;=
 BORDER-TOP: #d4d0c8; BORDER-LEFT: #d4d0c8; BORDER-BOTTOM: #d4d0c8; BACKGRO=
UND-COLOR: transparent"><FONT face=3D"Arial Narrow" size=3D2>10.0.0.10</FON=
T></TD></TR>  <TR style=3D"HEIGHT: 12.75pt" height=3D17>  <TD style=3D"BORD=
ER-RIGHT: #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEFT: #d4d0c8; BORDER-BOTTOM=
: #d4d0c8; HEIGHT: 12.75pt; BACKGROUND-COLOR: transparent" height=3D17><FON=
T face=3D"Arial Narrow" size=3D2>net2client1</FONT></TD>=20
 <TD style=3D"BORDER-RIGHT: #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEFT: #d4d=
0c8; BORDER-BOTTOM: #d4d0c8; BACKGROUND-COLOR: transparent" x:fmla=3D'=3D"w=
ww."&amp;A7&amp;".com"'><FONT face=3D"Arial Narrow" size=3D2>www.net2client=
1.com</FONT></TD>  <TD style=3D"BORDER-RIGHT: #d4d0c8; BORDER-TOP: #d4d0c8;=
 BORDER-LEFT: #d4d0c8; BORDER-BOTTOM: #d4d0c8; BACKGROUND-COLOR: transparen=
t"><FONT face=3D"Arial Narrow" size=3D2>10.0.0.12</FONT></TD></TR>  <TR sty=
le=3D"HEIGHT: 12.75pt" height=3D17>  <TD style=3D"BORDER-RIGHT: #d4d0c8; BO=
RDER-TOP: #d4d0c8; BORDER-LEFT: #d4d0c8; BORDER-BOTTOM: #d4d0c8; HEIGHT: 12=
.75pt; BACKGROUND-COLOR: transparent" height=3D17><FONT face=3D"Arial Narro=
w" size=3D2>net2client2</FONT></TD>  <TD style=3D"BORDER-RIGHT: #d4d0c8; BO=
RDER-TOP: #d4d0c8; BORDER-LEFT: #d4d0c8; BORDER-BOTTOM: #d4d0c8; BACKGROUND=
-COLOR: transparent" x:fmla=3D'=3D"www."&amp;A8&amp;".com"'><FONT face=3D"A=
rial Narrow" size=3D2>www.net2client2.com</FONT></TD>  <TD style=3D"BORDER-=
RIGHT: #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEFT:
 #d4d0c8; BORDER-BOTTOM: #d4d0c8; BACKGROUND-COLOR: transparent"><FONT face=
=3D"Arial Narrow" size=3D2>10.0.0.14</FONT></TD></TR>  <TR style=3D"HEIGHT:=
 12.75pt" height=3D17>  <TD style=3D"BORDER-RIGHT: #d4d0c8; BORDER-TOP: #d4=
d0c8; BORDER-LEFT: #d4d0c8; BORDER-BOTTOM: #d4d0c8; HEIGHT: 12.75pt; BACKGR=
OUND-COLOR: transparent" height=3D17><FONT face=3D"Arial Narrow" size=3D2>n=
et2client3</FONT></TD>  <TD style=3D"BORDER-RIGHT: #d4d0c8; BORDER-TOP: #d4=
d0c8; BORDER-LEFT: #d4d0c8; BORDER-BOTTOM: #d4d0c8; BACKGROUND-COLOR: trans=
parent" x:fmla=3D'=3D"www."&amp;A9&amp;".com"'><FONT face=3D"Arial Narrow" =
size=3D2>www.net2client3.com</FONT></TD>  <TD style=3D"BORDER-RIGHT: #d4d0c=
8; BORDER-TOP: #d4d0c8; BORDER-LEFT: #d4d0c8; BORDER-BOTTOM: #d4d0c8; BACKG=
ROUND-COLOR: transparent"><FONT face=3D"Arial Narrow" size=3D2>10.0.0.16</F=
ONT></TD></TR>  <TR style=3D"HEIGHT: 12.75pt" height=3D17>  <TD style=3D"BO=
RDER-RIGHT: #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEFT: #d4d0c8; BORDER-BOTT=
OM: #d4d0c8; HEIGHT: 12.75pt; BACKGROUND-COLOR:
 transparent" height=3D17><FONT face=3D"Arial Narrow" size=3D2>net2client4<=
/FONT></TD>  <TD style=3D"BORDER-RIGHT: #d4d0c8; BORDER-TOP: #d4d0c8; BORDE=
R-LEFT: #d4d0c8; BORDER-BOTTOM: #d4d0c8; BACKGROUND-COLOR: transparent" x:f=
mla=3D'=3D"www."&amp;A10&amp;".com"'><FONT face=3D"Arial Narrow" size=3D2>w=
ww.net2client4.com</FONT></TD>  <TD style=3D"BORDER-RIGHT: #d4d0c8; BORDER-=
TOP: #d4d0c8; BORDER-LEFT: #d4d0c8; BORDER-BOTTOM: #d4d0c8; BACKGROUND-COLO=
R: transparent"><FONT face=3D"Arial Narrow" size=3D2>10.0.0.18</FONT></TD><=
/TR>  <TR style=3D"HEIGHT: 12.75pt" height=3D17>  <TD style=3D"BORDER-RIGHT=
: #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEFT: #d4d0c8; BORDER-BOTTOM: #d4d0c=
8; HEIGHT: 12.75pt; BACKGROUND-COLOR: transparent" height=3D17><FONT face=
=3D"Arial Narrow" size=3D2>net3client1</FONT></TD>  <TD style=3D"BORDER-RIG=
HT: #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEFT: #d4d0c8; BORDER-BOTTOM: #d4d=
0c8; BACKGROUND-COLOR: transparent" x:fmla=3D'=3D"www."&amp;A11&amp;".com"'=
><FONT face=3D"Arial Narrow"
 size=3D2>www.net3client1.com</FONT></TD>  <TD style=3D"BORDER-RIGHT: #d4d0=
c8; BORDER-TOP: #d4d0c8; BORDER-LEFT: #d4d0c8; BORDER-BOTTOM: #d4d0c8; BACK=
GROUND-COLOR: transparent"><FONT face=3D"Arial Narrow" size=3D2>10.0.0.20</=
FONT></TD></TR>  <TR style=3D"HEIGHT: 12.75pt" height=3D17>  <TD style=3D"B=
ORDER-RIGHT: #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEFT: #d4d0c8; BORDER-BOT=
TOM: #d4d0c8; HEIGHT: 12.75pt; BACKGROUND-COLOR: transparent" height=3D17><=
FONT face=3D"Arial Narrow" size=3D2>net3client2</FONT></TD>  <TD style=3D"B=
ORDER-RIGHT: #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEFT: #d4d0c8; BORDER-BOT=
TOM: #d4d0c8; BACKGROUND-COLOR: transparent" x:fmla=3D'=3D"www."&amp;A12&am=
p;".com"'><FONT face=3D"Arial Narrow" size=3D2>www.net3client2.com</FONT></=
TD>  <TD style=3D"BORDER-RIGHT: #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEFT: =
#d4d0c8; BORDER-BOTTOM: #d4d0c8; BACKGROUND-COLOR: transparent"><FONT face=
=3D"Arial Narrow" size=3D2>10.0.0.22</FONT></TD></TR>  <TR style=3D"HEIGHT:=
 12.75pt" height=3D17>  <TD style=3D"BORDER-RIGHT:
 #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEFT: #d4d0c8; BORDER-BOTTOM: #d4d0c8=
; HEIGHT: 12.75pt; BACKGROUND-COLOR: transparent" height=3D17><FONT face=3D=
"Arial Narrow" size=3D2>net3client3</FONT></TD>  <TD style=3D"BORDER-RIGHT:=
 #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEFT: #d4d0c8; BORDER-BOTTOM: #d4d0c8=
; BACKGROUND-COLOR: transparent" x:fmla=3D'=3D"www."&amp;A13&amp;".com"'><F=
ONT face=3D"Arial Narrow" size=3D2>www.net3client3.com</FONT></TD>  <TD sty=
le=3D"BORDER-RIGHT: #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEFT: #d4d0c8; BOR=
DER-BOTTOM: #d4d0c8; BACKGROUND-COLOR: transparent"><FONT face=3D"Arial Nar=
row" size=3D2>10.0.0.24</FONT></TD></TR>  <TR style=3D"HEIGHT: 12.75pt" hei=
ght=3D17>  <TD style=3D"BORDER-RIGHT: #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-=
LEFT: #d4d0c8; BORDER-BOTTOM: #d4d0c8; HEIGHT: 12.75pt; BACKGROUND-COLOR: t=
ransparent" height=3D17><FONT face=3D"Arial Narrow" size=3D2>net3client4</F=
ONT></TD>  <TD style=3D"BORDER-RIGHT: #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-=
LEFT: #d4d0c8; BORDER-BOTTOM: #d4d0c8;
 BACKGROUND-COLOR: transparent" x:fmla=3D'=3D"www."&amp;A14&amp;".com"'><FO=
NT face=3D"Arial Narrow" size=3D2>www.net3client4.com</FONT></TD>  <TD styl=
e=3D"BORDER-RIGHT: #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEFT: #d4d0c8; BORD=
ER-BOTTOM: #d4d0c8; BACKGROUND-COLOR: transparent"><FONT face=3D"Arial Narr=
ow" size=3D2>10.0.0.26</FONT></TD></TR>  <TR style=3D"HEIGHT: 12.75pt" heig=
ht=3D17>  <TD style=3D"BORDER-RIGHT: #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-L=
EFT: #d4d0c8; BORDER-BOTTOM: #d4d0c8; HEIGHT: 12.75pt; BACKGROUND-COLOR: tr=
ansparent" height=3D17><FONT face=3D"Arial Narrow" size=3D2>net4client1</FO=
NT></TD>  <TD style=3D"BORDER-RIGHT: #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-L=
EFT: #d4d0c8; BORDER-BOTTOM: #d4d0c8; BACKGROUND-COLOR: transparent" x:fmla=
=3D'=3D"www."&amp;A15&amp;".com"'><FONT face=3D"Arial Narrow" size=3D2>www.=
net4client1.com</FONT></TD>  <TD style=3D"BORDER-RIGHT: #d4d0c8; BORDER-TOP=
: #d4d0c8; BORDER-LEFT: #d4d0c8; BORDER-BOTTOM: #d4d0c8; BACKGROUND-COLOR: =
transparent"><FONT face=3D"Arial Narrow"
 size=3D2>10.0.0.28</FONT></TD></TR>  <TR style=3D"HEIGHT: 12.75pt" height=
=3D17>  <TD style=3D"BORDER-RIGHT: #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEF=
T: #d4d0c8; BORDER-BOTTOM: #d4d0c8; HEIGHT: 12.75pt; BACKGROUND-COLOR: tran=
sparent" height=3D17><FONT face=3D"Arial Narrow" size=3D2>net4client2</FONT=
></TD>  <TD style=3D"BORDER-RIGHT: #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEF=
T: #d4d0c8; BORDER-BOTTOM: #d4d0c8; BACKGROUND-COLOR: transparent" x:fmla=
=3D'=3D"www."&amp;A16&amp;".com"'><FONT face=3D"Arial Narrow" size=3D2>www.=
net4client2.com</FONT></TD>  <TD style=3D"BORDER-RIGHT: #d4d0c8; BORDER-TOP=
: #d4d0c8; BORDER-LEFT: #d4d0c8; BORDER-BOTTOM: #d4d0c8; BACKGROUND-COLOR: =
transparent"><FONT face=3D"Arial Narrow" size=3D2>10.0.0.30</FONT></TD></TR=
>  <TR style=3D"HEIGHT: 12.75pt" height=3D17>  <TD style=3D"BORDER-RIGHT: #=
d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEFT: #d4d0c8; BORDER-BOTTOM: #d4d0c8; =
HEIGHT: 12.75pt; BACKGROUND-COLOR: transparent" height=3D17><FONT face=3D"A=
rial Narrow" size=3D2>net4client3</FONT></TD>  <TD
 style=3D"BORDER-RIGHT: #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEFT: #d4d0c8;=
 BORDER-BOTTOM: #d4d0c8; BACKGROUND-COLOR: transparent" x:fmla=3D'=3D"www."=
&amp;A17&amp;".com"'><FONT face=3D"Arial Narrow" size=3D2>www.net4client3.c=
om</FONT></TD>  <TD style=3D"BORDER-RIGHT: #d4d0c8; BORDER-TOP: #d4d0c8; BO=
RDER-LEFT: #d4d0c8; BORDER-BOTTOM: #d4d0c8; BACKGROUND-COLOR: transparent">=
<FONT face=3D"Arial Narrow" size=3D2>10.0.0.32</FONT></TD></TR>  <TR style=
=3D"HEIGHT: 12.75pt" height=3D17>  <TD style=3D"BORDER-RIGHT: #d4d0c8; BORD=
ER-TOP: #d4d0c8; BORDER-LEFT: #d4d0c8; BORDER-BOTTOM: #d4d0c8; HEIGHT: 12.7=
5pt; BACKGROUND-COLOR: transparent" height=3D17><FONT face=3D"Arial Narrow"=
 size=3D2>net4client4</FONT></TD>  <TD style=3D"BORDER-RIGHT: #d4d0c8; BORD=
ER-TOP: #d4d0c8; BORDER-LEFT: #d4d0c8; BORDER-BOTTOM: #d4d0c8; BACKGROUND-C=
OLOR: transparent" x:fmla=3D'=3D"www."&amp;A18&amp;".com"'><FONT face=3D"Ar=
ial Narrow" size=3D2>www.net4client4.com</FONT></TD>  <TD style=3D"BORDER-R=
IGHT: #d4d0c8; BORDER-TOP: #d4d0c8; BORDER-LEFT:
 #d4d0c8; BORDER-BOTTOM: #d4d0c8; BACKGROUND-COLOR: transparent"><FONT face=
=3D"Arial Narrow" size=3D2>10.0.0.34</FONT></TD></TR></TBODY></TABLE></DIV>=
  <DIV>&nbsp;</DIV>  <DIV>i use client-to-client parameter in all .ovpn fil=
e.</DIV>  <DIV>&nbsp;</DIV>  <DIV>i use an accounting software on terminal =
services. </DIV>  <DIV>all user can acces server. But at now i want only so=
me client can access server. for example only serverclient* user. and serve=
rclient* clients can acces to all other clients. and net4client4 can acces =
all other clients to. </DIV>  <DIV>&nbsp;</DIV>  <DIV>i do not want to use =
3 th part firewall for dropping package (iptables etc..)</DIV>  <DIV>is it =
possible with openvpn</DIV>  <DIV>&nbsp;</DIV>  <DIV>this is my server conf=
 file </DIV>  <DIV>****************************************</DIV>  <DIV>por=
t 84<BR>proto udp<BR>dev tun<BR>ca ca.crt<BR>certvpnserver1.crt<BR>key vpns=
erver1.key </DIV>  <DIV>dh dh1024.pem<BR>server 10.0.0.
 255.255.255.0&nbsp;<BR>ifconfig-pool-persist ipp.txt<BR>push "route 10.0.0=
.0 255.255.255.0"&nbsp;<BR>route 10.0.0.0 255.255.255.0 </DIV>  <DIV>client=
-to-client</DIV>  <DIV>keepalive 10 120<BR>max-clients 100<BR>persist-key<B=
R>persist-tun<BR>status openvpn-status.log<BR>verb 4<BR>tls-auth ta.key 0<B=
R>comp-lzo<BR></DIV>  <DIV>&nbsp;</DIV>  <DIV>client .ovpn file</DIV>  <DIV=
>****************************</DIV>  <DIV>client<BR>dev tun<BR>proto udp<BR=
>remote <A href=3D"http://www.server.com/" target=3D_blank><FONT color=3D#0=
03399>www.server.com</FONT></A> 84<BR>resolv-retry infinite<BR>nobind<BR>pe=
rsist-key<BR>persist-tun<BR>ca ca.crt<BR>cert VPNCLIENT3.crt<BR>key VPNCLIE=
NT3.key&nbsp;&nbsp;<BR>tls-auth ta.key 1<BR>verb 3<BR>comp-lzo</DIV><p>&#32;
		<hr size=3D1>Want to be your own boss? Learn how on <a href=3D"http://us.=
rd.yahoo.com/evt=3D41244/*http://smallbusiness.yahoo.com/r-index"> Yahoo! S=
mall Business.</a>=20

--0-122587314-1152628074=:65617--

