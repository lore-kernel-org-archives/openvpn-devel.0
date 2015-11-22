MIME-Version: 1.0
In-Reply-To: <SN1PR08MB13913AC34E4A579F21ED0576B9180@...2065...>
References: <564AFAF5.4030004@...515...>
	<SN1PR08MB1391C054994551CB11B84DADB91D0@...2065...>
	<CAKuzo_gAHMwvboZnHoJ7+m9ebdkxjxJQufHMjF=fxqsRimyB8Q@...278...>
	<564EDA4B.9010708@...515...>
	<SN1PR08MB1391783FD7541D07688C88D0B91A0@...2065...>
	<CAKuzo_gJH63sBcxo1rV7Kwh6CPnfgVYhv90TJ777XJ8iE9BGtA@...278...>
	<SN1PR08MB13913AC34E4A579F21ED0576B9180@...2065...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 22 Nov 2015 14:22:07 -0500
Message-ID: <CAKuzo_ga8AhYyRHDTktndfXFeP9Yzfw-SBGx4J6ZkBcEGg9tcw@...278...>
Content-Type: multipart/alternative; boundary=047d7bfcefb067ff620525260739
Subject: Re: [Openvpn-devel] OpenVPN-GUI now on GitHub + other Windows team
	things
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Morris, Russell" <rmorris@...1315...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7bfcefb067ff620525260739
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 22, 2015 at 12:33 PM, Morris, Russell <rmorris@...1315...>
wrote:

> Hi,
>
>
>
> Went to get started on this, and I admit =E2=80=93 a lot of different and
> confusing information about the libraries and include files (and a lot of
> it contradicts it seems). Do you have a good source for the =E2=80=9Crigh=
t=E2=80=9D files
> to grab?
>
>
>
> Thanks!
>


To start with try without openssl.
(each command below is on one line -- gmail may break the lines)

$ git clone https://github.com/OpenVPN/openvpn-gui.git
$ cd openvpn-gui
$ autoreconf -i -v
$ ./configure --prefix=3D/ --host=3Dx86_64-w64-mingw32
--build=3Dx86_64-pc-linux-gnu --program-prefix=3D''
CFLAGS=3D-DDISABLE_CHANGE_PASSWORD OPENSSL_CRYPTO_LIBS=3D"-L./"

$ make

That will build will get openvpn-gui.exe. Copy it to windows as run as
administrator.

All this assumes you have a setup with git, mingw-w64, automake, libtool
installed.

Selva

--047d7bfcefb067ff620525260739
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sun, Nov 22, 2015 at 12:33 PM, Morris, Russell <span dir=3D"ltr">&lt;<a =
href=3D"mailto:rmorris@...1315..." target=3D"_blank">rmorris@...1315...</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><p =
class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:&quot;Calibri=
&quot;,sans-serif;color:rgb(31,73,125)">Hi,<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:&quot;Cali=
bri&quot;,sans-serif;color:rgb(31,73,125)"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:&quot;Cali=
bri&quot;,sans-serif;color:rgb(31,73,125)">Went to get started on this, and=
 I admit =E2=80=93 a lot of different and confusing information about the l=
ibraries and include files (and a lot of it contradicts it
 seems). Do you have a good source for the =E2=80=9Cright=E2=80=9D files to=
 grab?<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:&quot;Cali=
bri&quot;,sans-serif;color:rgb(31,73,125)"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:&quot;Cali=
bri&quot;,sans-serif;color:rgb(31,73,125)">Thanks!</span></p></blockquote><=
/div><br><br></div><div class=3D"gmail_extra">To start with try without ope=
nssl.<br></div><div class=3D"gmail_extra">(each command below is on one lin=
e -- gmail may break the lines)<br><br></div><div class=3D"gmail_extra">$ g=
it clone <a href=3D"https://github.com/OpenVPN/openvpn-gui.git">https://git=
hub.com/OpenVPN/openvpn-gui.git</a><br></div><div class=3D"gmail_extra">$ c=
d openvpn-gui<br></div><div class=3D"gmail_extra">$ autoreconf -i -v<br>$ <=
tt>./configure --prefix=3D/ --host=3Dx86_64-w64-mingw32 --build=3Dx86_64-pc=
-linux-gnu --program-prefix=3D&#39;&#39;=20
CFLAGS=3D-DDISABLE_CHANGE_PASSWORD OPENSSL_CRYPTO_LIBS=3D&quot;-L./&quot;<b=
r><br></tt></div><div class=3D"gmail_extra"><tt>$ make<br></tt></div><div c=
lass=3D"gmail_extra"><tt><br></tt></div><div class=3D"gmail_extra"><tt>That=
 will build will get openvpn-gui.exe. Copy it to windows as run as administ=
rator.<br></tt></div><div class=3D"gmail_extra"><tt><br></tt></div><div cla=
ss=3D"gmail_extra"><tt>All this assumes you have a setup with git, mingw-w6=
4, automake, libtool installed.<br></tt></div><div class=3D"gmail_extra"><t=
t><br>Selva <br></tt></div></div>

--047d7bfcefb067ff620525260739--

