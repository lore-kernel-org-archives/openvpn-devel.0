Message-ID: <BAY128-W1C8597326B508CE3443CDFD2D0@...512...>
Content-Type: multipart/alternative;
	boundary="_5a0a0d96-18b6-4dbe-b3f5-c78bfdd9346e_"
From: Hisham Aziz <shammer_@...160...>
Date: Thu, 31 May 2007 16:19:47 -0400
MIME-Version: 1.0
Subject: [Openvpn-devel] OPENVPN with OPENLDAP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--_5a0a0d96-18b6-4dbe-b3f5-c78bfdd9346e_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi...Im just starting out with Openvpn, recently figured out how to create =
a tunnel connection between two machines. Now im wondering if i can use ope=
nvpn to connect and authenticate with an LDAP and query it to find certain =
objects with certain attribute using some sort of script. Basically Im aski=
ng here is in a typical client.conf file for a OpenVpn client where would I=
 need to execute such a script to query the LDAP database and also what kin=
d of script is best suited ( Perl, Python , SH, .bat ).SO the questions are=
 how do i do this and where in the file do i do this?Here is my client.ovpn=
 file. Obv it has to be changed, i was using this for making a simple serve=
r/client tunnel with another machine using certs and keys on my etoken smar=
tcards.**************************************************pullclientdev tunp=
roto udpremote 128.100.103.211port 1194resolv-retry infinitenobindpersist-k=
eypersist-tunverb 3ca "C:\\temp\\ca.crt"pkcs11-providers "C:\\PKI\\WC\\NSIS=
\\eTpkcs11.dll"pkcs11-slot-type labelpkcs11-slot "eToken"pkcs11-id-type idp=
kcs11-id 06*************************************************Thanks
_________________________________________________________________
Discover the new Windows Vista
http://search.msn.com/results.aspx?q=3Dwindows+vista&mkt=3Den-US&form=3DQBR=
E=

--_5a0a0d96-18b6-4dbe-b3f5-c78bfdd9346e_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
P
{
margin:0px;
padding:0px
}
body
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body>
Hi...<br><br>Im just starting out with Openvpn, recently figured out how to=
 create a tunnel connection between two machines. Now im wondering if i can=
 use openvpn to connect and authenticate with an LDAP and query it to find =
certain objects with certain attribute using some sort of script. Basically=
 Im asking here is in a typical client.conf file for a OpenVpn client where=
 would I need to execute such a script to query the LDAP database and also =
what kind of script is best suited ( Perl, Python , SH, .bat ).<br><br>SO t=
he questions are how do i do this and where in the file do i do this?<br>He=
re is my client.ovpn file. Obv it has to be changed, i was using this for m=
aking a simple server/client tunnel with another machine using certs and ke=
ys on my etoken smartcards.<br><br>****************************************=
**********<br>pull<br>client<br><br>dev tun<br>proto udp<br>remote 128.100.=
103.211<br><br>port 1194<br>resolv-retry infinite<br>nobind<br><br>persist-=
key<br>persist-tun<br>verb 3<br><br>ca "C:\\temp\\ca.crt"<br><br>pkcs11-pro=
viders "C:\\PKI\\WC\\NSIS\\eTpkcs11.dll"<br>pkcs11-slot-type label<br>pkcs1=
1-slot "eToken"<br><br>pkcs11-id-type id<br>pkcs11-id 06<br>***************=
**********************************<br><br><br>Thanks<br><br><br><br /><hr /=
>Discover the new Windows Vista <a href=3D'http://search.msn.com/results.as=
px?q=3Dwindows+vista&mkt=3Den-US&form=3DQBRE' target=3D'_new'>Learn more!</=
a></body>
</html>=

--_5a0a0d96-18b6-4dbe-b3f5-c78bfdd9346e_--

