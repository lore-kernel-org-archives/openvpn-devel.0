MIME-Version: 1.0
In-Reply-To: <1479628060-32673-1-git-send-email-gert@...1296...>
References: <1479569756-23302-1-git-send-email-arne@...1227...>
	<1479628060-32673-1-git-send-email-gert@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 20 Nov 2016 03:00:03 -0500
Message-ID: <CAKuzo_iXpF4VGZCYzq21L4YXeVvuVCj5stcFiSPzZm+wXYN6+Q@...278...>
Content-Type: multipart/alternative; boundary=001a11408cb679659e0541b6ee14
Subject: Re: [Openvpn-devel] [PATCH] Remove remaining traces of
	compat-stdbool.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11408cb679659e0541b6ee14
Content-Type: text/plain; charset=UTF-8

On Sun, Nov 20, 2016 at 2:47 AM, Gert Doering <gert@...1296...> wrote:

> commit 35be7e0d5 removed most references to compat-stdbool.h but
> overlooked configure and "make dist"
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  configure.ac           | 2 +-
>  src/compat/Makefile.am | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
>

'make dist' is now happy and Windows build works. Thanks.

ACK.

Selva

--001a11408cb679659e0541b6ee14
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Sun, Nov 20, 2016 at 2:47 AM, Gert Doering <span dir=3D"ltr">&lt;<a =
href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">commit 35be7e0d5 removed mos=
t references to compat-stdbool.h but<br>
overlooked configure and &quot;make dist&quot;<br>
<br>
Signed-off-by: Gert Doering &lt;<a href=3D"mailto:gert@...1296...">gert@...493...=
1296...</a>&gt;<br>
---<br>
=C2=A0<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A0src/compat/Makefile.am | 1 -<br>
=C2=A02 files changed, 1 insertion(+), 2 deletions(-)<span class=3D"HOEnZb"=
><font color=3D"#888888"><br></font></span></blockquote><div><br></div><div=
>&#39;make dist&#39; is now happy and Windows build works. Thanks.<br><br><=
/div><div>ACK.<br><br></div><div>Selva <br></div></div><br></div></div>

--001a11408cb679659e0541b6ee14--

