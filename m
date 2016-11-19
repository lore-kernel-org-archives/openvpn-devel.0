MIME-Version: 1.0
In-Reply-To: <CAFHpkQGqwWTjggCFP0eAScxq35F3usD38zRNQDb++V+HpmzNuw@...278...>
References: <CAFHpkQGqwWTjggCFP0eAScxq35F3usD38zRNQDb++V+HpmzNuw@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 19 Nov 2016 11:35:11 -0500
Message-ID: <CAKuzo_ijgy386DWzsKP=Qb1=X6uPd8X6chmi02wmA-KQODy2gQ@...278...>
Content-Type: multipart/alternative; boundary=001a1147bc42e16da60541aa02b7
Subject: Re: [Openvpn-devel] openvpn-gui disconnect on suspend ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1147bc42e16da60541aa02b7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 19, 2016 at 11:06 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:

> I see that option in Changes.rst, but I do not see any reference in code:
>
> [ilia@...23... openvpn-gui]$ grep -r disconnect_on_suspend .
> ./CHANGES.rst:Registry option "disconnect_on_suspend". Set to zero to
> disable the
> [ilia@...23... openvpn-gui]$
>
>
> https://github.com/OpenVPN/openvpn-build/blob/master/windows
> -nsis/openvpn.nsi#L329
>

You are right, we do not use the regkey HKLM\OpenVPN in general and the
value disconnect_on_suspend, in particular on the master branch. So the
line 329 in the openvpn.nsi should be removed.

Thanks,

Selva

--001a1147bc42e16da60541aa02b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Sat, Nov 19, 2016 at 11:06 AM, =
=D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:chipitsine@...277..." target=3D"_blank">ch=
ipitsine@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
<div>I see that option in Changes.rst, but I do not see any reference in co=
de:<br><br>[ilia@...23... openvpn-gui]$ grep -r disconnect_on_suspend .<br>=
./CHANGES.rst:Registry option &quot;disconnect_on_suspend&quot;. Set to zer=
o to disable the<br>[ilia@...23... openvpn-gui]$ <br><br><br><a href=3D"htt=
ps://github.com/OpenVPN/openvpn-build/blob/master/windows-nsis/openvpn.nsi#=
L329" target=3D"_blank">https://github.com/OpenVPN/ope<wbr>nvpn-build/blob/=
master/windows<wbr>-nsis/openvpn.nsi#L329</a></div></blockquote></div><br><=
/div><div class=3D"gmail_extra">You are right, we do not use the regkey HKL=
M\OpenVPN in general and the value disconnect_on_suspend, in particular on =
the master branch. So the line 329 in the openvpn.nsi should be removed.<br=
><br></div><div class=3D"gmail_extra">Thanks,<br><br></div><div class=3D"gm=
ail_extra">Selva<br></div></div>

--001a1147bc42e16da60541aa02b7--

