MIME-Version: 1.0
In-Reply-To: <SN1PR08MB13917513FA918C484146CA13B9050@...2065...>
References: <564AFAF5.4030004@...515...>
	<CAKuzo_ga8AhYyRHDTktndfXFeP9Yzfw-SBGx4J6ZkBcEGg9tcw@...278...>
	<SN1PR08MB1391C6F144144362BB6BA1B9B9050@...2065...>
	<1584543.znVl45ZabU@...1526...>
	<SN1PR08MB1391EA7CA6193754DBB6DAEEB9050@...2065...>
	<CAKuzo_iewE=FPgN=CzRiBKvhJnABZhF2Yy0sr8Nzaaa0COnUew@...278...>
	<SN1PR08MB13917513FA918C484146CA13B9050@...2065...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 25 Nov 2015 16:23:29 -0500
Message-ID: <CAKuzo_hKjbxMu4U9rFYXUAfnV=FYR991JXS3CUqTefDx0L0=cA@...278...>
Content-Type: multipart/alternative; boundary=001a11443d9ef9052905256412ad
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

--001a11443d9ef9052905256412ad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 25, 2015 at 4:14 PM, Morris, Russell <rmorris@...1315...>
wrote:

> Yep, that works better =E2=80=A6 J. Thanks!
>
>
So did it compile?


>
>
> Any pointers on fixing the OpenSSL =E2=80=9Climitation=E2=80=9D?
>

Its not a limitation. You just need cross-compiled  openssl library and
include files to build with CHANGE_PASSWORD enabled.

The build process of the whole package (openvpn + gui) using openvpn-build
does compile openssl starting from upstream sources. If you have that build
environment setup, you can point to those while configuring the GUI and
remove the DISABLE_CHANGE_PASSWORD option.

Regards,

Selva

--001a11443d9ef9052905256412ad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Wed, Nov 25, 2015 at 4:14 PM, Morris=
, Russell <span dir=3D"ltr">&lt;<a href=3D"mailto:rmorris@...1315..." targe=
t=3D"_blank">rmorris@...1315...</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif;color:#1f497d">Yep, that works better =
=E2=80=A6
</span><span style=3D"font-size:11.0pt;font-family:Wingdings;color:#1f497d"=
>J</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sa=
ns-serif;color:#1f497d">. Thanks!<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d"><u></u></span></p></blockquote><div><=
br></div><div>So did it compile?</div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex"><p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-fami=
ly:&quot;Calibri&quot;,sans-serif;color:#1f497d">=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d">Any pointers on fixing the OpenSSL =
=E2=80=9Climitation=E2=80=9D?</span></p></blockquote></div><br>Its not a li=
mitation. You just need cross-compiled =C2=A0openssl library and include fi=
les to build with CHANGE_PASSWORD enabled.</div><div class=3D"gmail_extra">=
<br></div><div class=3D"gmail_extra">The build process of the whole package=
 (openvpn + gui) using openvpn-build does compile openssl starting from ups=
tream sources. If you have that build environment setup, you can point to t=
hose while configuring the GUI and remove the DISABLE_CHANGE_PASSWORD optio=
n.</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Reg=
ards,</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">=
Selva</div></div>

--001a11443d9ef9052905256412ad--

