References: <CAA6T4PSwwiX5Z6NAdxTEuNV1uhTdvdpU_Tb561U7s=-JZpr3=g@...278...>
	<512E53CA.5070004@...515...>
Mime-Version: 1.0 (1.0)
In-Reply-To: <512E53CA.5070004@...515...>
Content-Type: multipart/alternative;
	boundary=Apple-Mail-BF5F5B21-0C79-48D5-93DB-631E6F787A16
Content-Transfer-Encoding: 7bit
Message-Id: <C6F9EFA1-38D0-44AB-9015-5FFE2B8EBAB8@...277...>
From: Sagi Gidali <gidalis@...277...>
Date: Thu, 28 Feb 2013 12:33:58 +0200
Subject: Re: [Openvpn-devel] Problem with compiling openvpn-gui on ubuntu
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?utf-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--Apple-Mail-BF5F5B21-0C79-48D5-93DB-631E6F787A16
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

That's what I did and it worked great ! Thanks a lot !! :)

Sagi

On 27 =D7=91=D7=A4=D7=91=D7=A8 2013, at 20:43, Samuli Sepp=C3=A4nen <samuli=
@...515...> wrote:

> Hi,
>=20
> You can use openvpn-build to build openvpn and it's dependencies, includi=
ng the OpenVPN-GUI - that should just work. Once the build is finished, you=
 can probably hack the openvpn-build scripts to only build the GUI.
>=20
> Best regards,
> --=20
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>=20
> irc freenode net: mattock
>=20
> [1]
> openvpn-build/generic/build
> openvpn-build/windows-nsis/build-complete
>=20
>=20
>> Hi All,
>>=20
>> I've installed all required programs as written in 1.
>>=20
>> apt-get install git-core mingw-w64 gcc-4.6-arm-linux-gnueabi man2html do=
s2unix nsis unzip
>>=20
>> Then, I've executed the command ./configure --prefix=3D/usr/local/i586-m=
ingw32 --host=3Di586-mingw32msvc inside OpenVPN-Gui source folder.
>>=20
>> It completed successfully, then when I execute the command make i get th=
e following error:
>>=20
>> main.c:26:21: fatal error: windows.h: No such file or directory
>> compilation terminated.
>> make[1]: *** [main.o] Error 1
>>=20
>> What I'm doing wrong?
>>=20
>> Thanks,
>> Sagi
>>=20
>> [1] https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuild=
system
>=20
>=20

--Apple-Mail-BF5F5B21-0C79-48D5-93DB-631E6F787A16
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=
=3Dutf-8"></head><body dir=3D"auto"><div><div style=3D"text-align: left;dir=
ection: ltr; "><span style=3D"-webkit-text-size-adjust: auto;">That's what =
I did and it worked great ! Thanks a lot !! :)</span></div><div style=3D"te=
xt-align: left;direction: ltr; "><span style=3D"-webkit-text-size-adjust: a=
uto;"><br></span></div><div style=3D"text-align: left;direction: ltr; "><sp=
an style=3D"-webkit-text-size-adjust: auto;">Sagi</span></div><br><span sty=
le=3D"-webkit-text-size-adjust: auto;">On 27 =D7=91=D7=A4=D7=91=D7=A8 2013,=
 at 20:43, Samuli Sepp=C3=A4nen &lt;<a href=3D"mailto:samuli@...515...">sam=
uli@...515...</a>&gt; wrote:</span><br><br></div><blockquote type=3D"cite" =
style=3D"-webkit-text-size-adjust: auto; "><div>
=20=20
    <meta content=3D"text/html; charset=3DISO-8859-15" http-equiv=3D"Conten=
t-Type">
=20=20
=20=20
    <div class=3D"moz-cite-prefix">Hi,<br>
      <br>
      You can use openvpn-build to build openvpn and it's dependencies,
      including the OpenVPN-GUI - that should just work. Once the build
      is finished, you can probably hack the openvpn-build scripts to
      only build the GUI.<br>
      <br>
      Best regards,<br>
      <pre class=3D"moz-signature" cols=3D"72">--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock</pre>
      <br>
      [1]<br>
      openvpn-build/generic/build<br>
      openvpn-build/windows-nsis/build-complete<br>
      <br>
      <br>
    </div>
    <blockquote cite=3D"mid:CAA6T4PSwwiX5Z6NAdxTEuNV1uhTdvdpU_Tb561U7s=3D-J=
Zpr3=3Dg@...278..." type=3D"cite">
      <div dir=3D"ltr">
        <div style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-si=
ze:12.800000190734863px">Hi
          All,</div>
        <div style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-si=
ze:12.800000190734863px"><br>
        </div>
        <div style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-si=
ze:12.800000190734863px">I've
          installed all required programs as written in 1.</div>
        <div style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-si=
ze:12.800000190734863px"><br>
        </div>
        <div style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-si=
ze:12.800000190734863px"><span style=3D"background-color:rgb(247,247,247);f=
ont-size:13px">apt-get
            install git-core mingw-w64 gcc-4.6-arm-linux-gnueabi
            man2html dos2unix nsis unzip</span></div>
        <div style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-si=
ze:12.800000190734863px"><br>
        </div>
        <div style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-si=
ze:12.800000190734863px">Then,
          I've executed the command&nbsp;./configure
          --prefix=3D/usr/local/i586-mingw32 --host=3Di586-mingw32msvc
          inside OpenVPN-Gui source folder.</div>
        <div style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-si=
ze:12.800000190734863px"><br>
        </div>
        <div style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-si=
ze:12.800000190734863px">It
          completed successfully, then when I execute the command make i
          get the following error:</div>
        <div style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-si=
ze:12.800000190734863px"><br>
        </div>
        <div style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-si=
ze:12.800000190734863px">
          <div>main.c:26:21: fatal error: windows.h: No such file or
            directory</div>
          <div>compilation terminated.</div>
          <div>make[1]: *** [main.o] Error 1</div>
        </div>
        <div style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-si=
ze:12.800000190734863px"><br>
        </div>
        <div style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-si=
ze:12.800000190734863px">What
          I'm doing wrong?</div>
        <div style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-si=
ze:12.800000190734863px"><br>
        </div>
        <div style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-si=
ze:12.800000190734863px">Thanks,</div>
        <div style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-si=
ze:12.800000190734863px">Sagi</div>
        <div style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-si=
ze:12.800000190734863px"><br>
        </div>
        <div style=3D"color:rgb(0,0,0);font-family:arial,sans-serif;font-si=
ze:12.800000190734863px">[1]&nbsp;<a moz-do-not-send=3D"true" href=3D"https=
://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsystem" targ=
et=3D"_blank">https://community.openvpn.net/openvpn/wiki/BuildingUsingGener=
icBuildsystem</a><br>
        </div>
      </div>
    </blockquote>
    <br>
    <br>
=20=20

</div></blockquote></body></html>=

--Apple-Mail-BF5F5B21-0C79-48D5-93DB-631E6F787A16--

