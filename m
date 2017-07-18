Date: Tue, 18 Jul 2017 08:46:49 -0700
From: Gregory Sloop <gregs@...1934...>
Reply-To: Greg Sloop <gregs@...1934...>
Message-ID: <82384304.20170718084649@...1934...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----------01802B17C3F6AFF19"
Subject: [Openvpn-devel] iOS key decrypts
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

------------01802B17C3F6AFF19
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

So, I'm not sure if this [the dev list] is the place to post this - though =
I suspect the well of knowledge here vs the regular list will be more appro=
priate to answer.

It's been a long time since I needed to roll out openvpn to an iOS device a=
nd the last time I did it, I did it via separate PKCS12 and config files. [=
IIRC, PKCS12 is 3DES encrypted - not very secure.]

The last time, I also had a modestly secure way of getting the PKCS12 files=
 to the clients. But in iOS, unified confg files can't be pulled from a web=
site - essentially you either email the config, or transfer it via itunes.

So, I'm trying to do a unified config file with the ca, certs and keys embe=
dded. However, it appears that current versions of iOS can't handle AES-256=
 encrypted keys. [At least that's my best guess from the errors I get - usi=
ng my weak google-foo etc. "OpenVPN error polarssl error parsing config pri=
vate key : PK - Bad input parameters to function."]

So all that dross above to ask:
Does anyone know definitively what key encryptions/decryptions the iOS clie=
nt will properly handle? [And if there's any difference using unfied vs non=
-unified setups.]


TIA

-Greg=

------------01802B17C3F6AFF19
Content-Type: text/html; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

<html><head><title>iOS key decrypts</title>
</head>
<body>
<span style=3D" font-family:'Courier New'; font-size: 9pt;">So, I'm not sur=
e if this [the dev list] is the place to post this - though I suspect the w=
ell of knowledge here vs the regular list will be more appropriate to answe=
r.<br>
<br>
It's been a long time since I needed to roll out openvpn to an iOS device a=
nd the last time I did it, I did it via separate PKCS12 and config files. [=
IIRC, PKCS12 is 3DES encrypted - not very secure.]<br>
<br>
The last time, I also had a modestly secure way of getting the PKCS12 files=
 to the clients. But in iOS, unified confg files can't be pulled from a web=
site - essentially you either email the config, or transfer it via itunes.<=
br>
<br>
So, I'm trying to do a unified config file with the ca, certs and keys embe=
dded. However, it appears that current versions of iOS can't handle AES-256=
 encrypted keys. [At least that's my best guess from the errors I get - usi=
ng my weak google-foo etc. "OpenVPN error polarssl error parsing config pri=
vate key : PK - Bad input parameters to function."]<br>
<br>
So all that dross above to ask:<br>
Does anyone know definitively what key encryptions/decryptions the iOS clie=
nt will properly handle? [And if there's any difference using unfied vs non=
-unified setups.]<br>
<br>
</span><a style=3D" font-family:'arial';" href=3D"mailto:gregs@...1934...">=
</a><br>
<span style=3D" font-family:'Courier New'; font-size: 9pt;">TIA<br>
<br>
-Greg</body></html>=

------------01802B17C3F6AFF19--


