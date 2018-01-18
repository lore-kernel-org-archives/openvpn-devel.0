MIME-Version: 1.0
In-Reply-To: <CAFHpkQGe-aeaV2we=M_xB41W36dwAa8rRRzmt6rteVvAHuXFKA@...278...>
References: <CAFHpkQGe-aeaV2we=M_xB41W36dwAa8rRRzmt6rteVvAHuXFKA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 18 Jan 2018 12:11:53 -0500
Message-ID: <CAKuzo_i_J7+yFwv60gd3MinAOu7SdoUmvVMKsHZG-3Fep5EFmw@...278...>
Content-Type: multipart/alternative; boundary="001a114c908eaf0dd505631010fe"
Subject: Re: [Openvpn-devel] consider exe_path optional ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a114c908eaf0dd505631010fe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 3:49 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:

> Hello,
>
> changes https://github.com/OpenVPN/openvpn-gui/pull/197 actually make
> openvpn-gui less dependent on registry
>
>
> we sometimes see similar issue with interactive service:
>
> openvpnserv error: =D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=B5=D1=82=D1=81=D1=
=8F =D0=BD=D0=B0=D0=B9=D1=82=D0=B8 =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD=D0=
=BD=D1=8B=D0=B9 =D1=84=D0=B0=D0=B9=D0=BB. (0x2) Error querying
> registry value: HKLM\SOFTWARE\OpenVPN\exe_path
>
> (I've no idea why "exe_path" was deleted)
>
> @selvanair , what do you think if we'll try to guess exe_path by picking
> directory from where openvpnserv was started ? (it is a good guess to
> assume openvpn.exe is in the same directory)
>

Patch 86 (https://patchwork.openvpn.net/patch/86/) does this. The only
registry key that will be required would be HKLM\Software\OpenVPN whose
default value should point to the installation directory.

One of the security features of the service is that it starts only
"authorized" openvpn.exe executables -- so we need to have at least the
installed location set by the admin. Then we can safely guess the rest of
the parameters if not explicitly set. Eliminating all registry dependence
wouldn't be safe for the service.

That wouldn't fix issues faced by users who delete registry keys or use
non-standard installation methods. Generally those are power users who can
fix things on their own. If not, just ask them to re-install openvpn.

Selva

--001a114c908eaf0dd505631010fe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Jan 18, 2018 at 3:49 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <span dir=3D"ltr">&lt;<a href=3D"mailto:chipits=
ine@...277..." target=3D"_blank">chipitsine@...277...</a>&gt;</span> wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div=
><div><div><div><div><div>Hello,<br><br></div>changes <a href=3D"https://gi=
thub.com/OpenVPN/openvpn-gui/pull/197" target=3D"_blank">https://github.com=
/OpenVPN/<wbr>openvpn-gui/pull/197</a> actually make openvpn-gui less depen=
dent on registry<br><br><br></div>we sometimes see similar issue with inter=
active service:<br><br>openvpnserv error: =D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=
=D0=B5=D1=82=D1=81=D1=8F =D0=BD=D0=B0=D0=B9=D1=82=D0=B8 =D1=83=D0=BA=D0=B0=
=D0=B7=D0=B0=D0=BD=D0=BD=D1=8B=D0=B9 =D1=84=D0=B0=D0=B9=D0=BB. (0x2) Error =
querying registry value: HKLM\SOFTWARE\OpenVPN\exe_path<br><br></div>(I&#39=
;ve no idea why &quot;exe_path&quot; was deleted)<br><br></div>@selvanair ,=
 what do you think if we&#39;ll try to guess exe_path by picking directory =
from where openvpnserv was started ? (it is a good guess to assume openvpn.=
exe is in the same directory)<br></div></div></div></blockquote><div><br></=
div><div>Patch 86 (<a href=3D"https://patchwork.openvpn.net/patch/86/">http=
s://patchwork.openvpn.net/patch/86/</a>) does this. The only registry key t=
hat will be required would be HKLM\Software\OpenVPN whose default value sho=
uld point to the installation directory.=C2=A0</div><div><br></div><div>One=
 of the security features of the service is that it starts only &quot;autho=
rized&quot; openvpn.exe executables -- so we need to have at least the inst=
alled location set by the admin. Then we can safely guess the rest of the p=
arameters if not explicitly set. Eliminating all registry dependence wouldn=
&#39;t be safe for the service.=C2=A0</div><div><br></div><div>That wouldn&=
#39;t fix issues faced by users who delete registry keys or use non-standar=
d installation methods. Generally those are power users who can fix things =
on their own. If not, just ask them to re-install openvpn.</div><div><br></=
div><div>Selva</div></div></div></div>

--001a114c908eaf0dd505631010fe--

