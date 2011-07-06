Message-ID: <4E14B584.9040905@...515...>
Date: Wed, 06 Jul 2011 12:20:36 -0700
From: =?windows-1252?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1CED409804E2164C8104F9E623B08B901269D8E391@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B901269D8E391@...1436...>
Content-Type: multipart/alternative;
	boundary="------------060903030707050504050301"
Subject: Re: [Openvpn-devel] PolarSSL patches
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Adriaan de Jong <dejong@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------060903030707050504050301
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Adriaan,

I tried building your tree on Debian 5 (amd64) VM and got this error:

#make plugins
/usr/bin/make -C plugin/auth-pam/
make[1]: Entering directory
`/home/buildslave/andj-openvpn-ssl-refactoring-4970f14/plugin/auth-pam'
gcc -O2 -Wall -DDLOPEN_PAM=3D0 -fPIC -c -I../.. auth-pam.c
In file included from auth-pam.c:49:
../../openvpn-plugin.h:283: error: expected specifier-qualifier-list
before =91x509_cert_t=92
make[1]: *** [auth-pam.o] Error 1
make[1]: Leaving directory
`/home/buildslave/andj-openvpn-ssl-refactoring-4970f14/plugin/auth-pam'
make: *** [build-stamp] Error 2

The same VM has been used to successfully build the official release
packages.

Samuli


> Hi everyone,
>
>=20=20
>
> During last week=92s meeting we decided to temporarily create a github
> tree for OpenVPN. It can be found at
> https://github.com/andj/openvpn-ssl-refactoring . The version found
> there is now ready for testing, and will (hopefully) be included in
> the 2.3 alpha versions.
>
>=20=20
>
> Could interested parties please have a look and provide me with
> feedback (through IRC/e-mail?).
>
>=20=20
>
> Thanks!
>
>=20=20
>
> Adriaan de Jong
>
>=20=20
>
> PS. Note that due to limitations in PolarSSL, it is still missing a
> number of features:
>
>=20=20
>
>  * PKCS#12 file support
>
>  * --capath support - Loading certificate authorities from a directory
>
>  * Windows CryptoAPI support
>
>  * Management external key support
>
>  * X.509 alternative username fields (must be "CN")
>
>=20=20
>
> Plugin/Script features:
>
>=20=20
>
>  * X.509 Serial number is in hex, not decimal as with OpenSSL
>
>  * X.509 subject line has a different format than the OpenSSL subject line
>
>  * X.509 certificate export does not work
>
>  * X.509 certificate tracking
>
>=20=20
>
> *Fox-IT*    /...for a more secure society/
>
> I www.fox-it.com <http://www.fox-it.com/>
>
>=20=20
>


--------------060903030707050504050301
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body text=3D"#000000" bgcolor=3D"#ffffff">
    Hi Adriaan,<br>
    <br>
    I tried building your tree on Debian 5 (amd64) VM and got this
    error:<br>
    <br>
    #make plugins<br>
    /usr/bin/make -C plugin/auth-pam/<br>
    make[1]: Entering directory
    `/home/buildslave/andj-openvpn-ssl-refactoring-4970f14/plugin/auth-pam'=
<br>
    gcc -O2 -Wall -DDLOPEN_PAM=3D0 -fPIC -c -I../.. auth-pam.c<br>
    In file included from auth-pam.c:49:<br>
    ../../openvpn-plugin.h:283: error: expected specifier-qualifier-list
    before =91x509_cert_t=92<br>
    make[1]: *** [auth-pam.o] Error 1<br>
    make[1]: Leaving directory
    `/home/buildslave/andj-openvpn-ssl-refactoring-4970f14/plugin/auth-pam'=
<br>
    make: *** [build-stamp] Error 2<br>
    <br>
    The same VM has been used to successfully build the official release
    packages.<br>
    <br>
    Samuli<br>
    <br>
    <br>
    <blockquote
      cite=3D"mid:1CED409804E2164C8104F9E623B08B901269D8E391@...1436..."
      type=3D"cite">
      <meta http-equiv=3D"Content-Type" content=3D"text/html;
        charset=3Dwindows-1252">
      <meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Verdana;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
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
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Courier New";}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
      <div class=3D"WordSection1">
        <p class=3D"MsoNormal">Hi everyone,<o:p></o:p></p>
        <p class=3D"MsoNormal"><o:p>=A0</o:p></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-GB">During last week=92s
            meeting we decided to temporarily create a github tree for
            OpenVPN. It can be found at <a moz-do-not-send=3D"true"
              href=3D"https://github.com/andj/openvpn-ssl-refactoring">http=
s://github.com/andj/openvpn-ssl-refactoring</a>
            . The version found there is now ready for testing, and will
            (hopefully) be included in the 2.3 alpha versions.<o:p></o:p></=
span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>=A0</o:p></span></=
p>
        <p class=3D"MsoNormal"><span lang=3D"EN-GB">Could interested parties
            please have a look and provide me with feedback (through
            IRC/e-mail?). <o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>=A0</o:p></span></=
p>
        <p class=3D"MsoNormal"><span lang=3D"EN-GB">Thanks!<o:p></o:p></spa=
n></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>=A0</o:p></span></=
p>
        <p class=3D"MsoNormal"><span lang=3D"EN-GB">Adriaan de Jong<o:p></o=
:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>=A0</o:p></span></=
p>
        <p class=3D"MsoNormal"><span lang=3D"EN-GB">PS. Note that due to
            limitations in PolarSSL, it is still missing a number of
            features:<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span style=3D"font-size: 10pt;" lang=3D"EN-=
GB"><o:p>=A0</o:p></span></p>
        <p class=3D"MsoNormal"><span style=3D"font-size: 10pt;" lang=3D"EN-=
GB">=A0*
            PKCS#12 file support<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span style=3D"font-size: 10pt;" lang=3D"EN-=
GB">=A0*
            --capath support - Loading certificate authorities from a
            directory<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span style=3D"font-size: 10pt;" lang=3D"EN-=
GB">=A0*
            Windows CryptoAPI support<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span style=3D"font-size: 10pt;" lang=3D"EN-=
GB">=A0*
            Management external key support<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span style=3D"font-size: 10pt;" lang=3D"EN-=
GB">=A0*
            X.509 alternative username fields (must be "CN")<o:p></o:p></sp=
an></p>
        <p class=3D"MsoNormal"><span style=3D"font-size: 10pt;" lang=3D"EN-=
GB"><o:p>=A0</o:p></span></p>
        <p class=3D"MsoNormal"><span style=3D"font-size: 10pt;" lang=3D"EN-=
GB">Plugin/Script
            features:<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span style=3D"font-size: 10pt;" lang=3D"EN-=
GB"><o:p>=A0</o:p></span></p>
        <p class=3D"MsoNormal"><span style=3D"font-size: 10pt;" lang=3D"EN-=
GB">=A0*
            X.509 Serial number is in hex, not decimal as with OpenSSL<o:p>=
</o:p></span></p>
        <p class=3D"MsoNormal"><span style=3D"font-size: 10pt;" lang=3D"EN-=
GB">=A0*
            X.509 subject line has a different format than the OpenSSL
            subject line<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span style=3D"font-size: 10pt;" lang=3D"EN-=
GB">=A0*
            X.509 certificate export does not work<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span style=3D"font-size: 10pt;" lang=3D"EN-=
GB">=A0*
            X.509 certificate tracking<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>=A0</o:p></span></=
p>
        <p class=3D"MsoNormal"><b><span style=3D"font-size: 9pt;
              font-family: &quot;Verdana&quot;,&quot;sans-serif&quot;;
              color: navy;" lang=3D"EN-US">Fox-IT</span></b><span
            style=3D"font-size: 9pt; font-family:
            &quot;Verdana&quot;,&quot;sans-serif&quot;; color: navy;"
            lang=3D"EN-US">=A0=A0=A0=A0<i>...for a more secure society</i> =
<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span style=3D"font-size: 8pt; font-family:
            &quot;Verdana&quot;,&quot;sans-serif&quot;; color: rgb(31,
            73, 125);" lang=3D"EN-US">I <a moz-do-not-send=3D"true"
              href=3D"http://www.fox-it.com/"><span style=3D"color: blue;">=
www.fox-it.com</span></a><br>
            <br>
          </span><span style=3D"color: rgb(31, 73, 125);" lang=3D"EN-US"><o=
:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>=A0</o:p></span></=
p>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------060903030707050504050301--

