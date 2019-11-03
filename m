MIME-Version: 1.0
References: <1571396438-22066-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1571396438-22066-1-git-send-email-lstipakov@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Sun, 3 Nov 2019 12:48:16 +0200
Message-ID: <CAGyAFMXrwiOo2EwuNrR2_7reOThwpHBGW6Tzk8yYvJmdbb4t7w@...278...>
Content-Type: multipart/alternative; boundary="0000000000007790f405966ef06b"
Subject: Re: [Openvpn-devel] [PATCH] travis: add Visual Studio build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000007790f405966ef06b
Content-Type: text/plain; charset="UTF-8"

Hi,

Please note, that in order this to work, following patches have to be
> merged:
>
>  - https://github.com/OpenVPN/openvpn-build/pull/157
>  - https://patchwork.openvpn.net/patch/867/


Since all prerequisites have been merged, this patch is good to go.

Here is a link to a travis build, which has this patch applied on top of
latest master (commit 27784432):

https://travis-ci.org/lstipakov/openvpn/builds/606692112

Everything is green, including newly added Visual Studio build.

-- 
-Lev

--0000000000007790f405966ef06b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div></div><div class=3D"gma=
il_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Please note, th=
at in order this to work, following patches have to be merged:<br>
<br>
=C2=A0- <a href=3D"https://github.com/OpenVPN/openvpn-build/pull/157" rel=
=3D"noreferrer" target=3D"_blank">https://github.com/OpenVPN/openvpn-build/=
pull/157</a><br>
=C2=A0- <a href=3D"https://patchwork.openvpn.net/patch/867/" rel=3D"norefer=
rer" target=3D"_blank">https://patchwork.openvpn.net/patch/867/</a></blockq=
uote><div><br></div><div>Since all prerequisites have been merged, this pat=
ch is good to go.</div><div><br></div><div>Here is a link to a travis build=
, which has this patch applied on top of latest master (commit 27784432):</=
div><div><br></div><div><a href=3D"https://travis-ci.org/lstipakov/openvpn/=
builds/606692112">https://travis-ci.org/lstipakov/openvpn/builds/606692112<=
/a>=C2=A0=C2=A0<br></div><div><br></div><div>Everything is green, including=
 newly added Visual Studio build.=C2=A0</div><div>=C2=A0</div></div>-- <br>=
<div dir=3D"ltr" class=3D"gmail_signature">-Lev</div></div>

--0000000000007790f405966ef06b--

