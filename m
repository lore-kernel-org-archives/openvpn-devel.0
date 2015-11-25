MIME-Version: 1.0
In-Reply-To: <20151125075416.GR24952@...1296...>
References: <564BA6DB.4070703@...2070...>
	<564DE8B3.9030803@...2070...>
	<20151124083944.GY24952@...1296...>
	<5654A314.3080607@...2070...>
	<20151124201135.GM24952@...1296...>
	<CAKuzo_jdcOjunyVmpT8er3HqWG7yh6pr+i8Tn8kD3omj=G_Pqw@...278...>
	<565547AB.9030607@...2070...>
	<20151125075416.GR24952@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 25 Nov 2015 09:15:05 -0500
Message-ID: <CAKuzo_iUzeYSWWvbpyV5RY_FwoNMm=97cfo0-uzeMFQKki3sWg@...278...>
Content-Type: multipart/alternative; boundary=001a11453cf4ee3ed305255e16fb
Subject: Re: [Openvpn-devel] [PATCH v4-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a11453cf4ee3ed305255e16fb
Content-Type: text/plain; charset=UTF-8

Hi,

On Wed, Nov 25, 2015 at 2:54 AM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Wed, Nov 25, 2015 at 08:31:23AM +0300, ValdikSS wrote:
> > I need help with 2.3 build system. While the code itself would compile
> fine, it won't link because I can't figure out how to link libraries
> available in vista+
> > only for vista+ build and do not link it for XP.
>
> Cross-build using ubuntu 14.04 and mingw64, and run configure with
> "configure ... LIBS='-lwhatyouneed'" for the vista+ build.
>
> For 2.3, that should be good enough.
>

Aha, so original question about building for winxp is probably related to
the extra libs added to Makefile.am?  I think it should not be there in the
patch for 2.3 so that the code builds cleanly for XP+ with the current 2.3
build setup. Then build specially for vista+ as Gert wrote above.

Selva

--001a11453cf4ee3ed305255e16fb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Wed, Nov 25, 2015 at 2:54 AM, Ge=
rt Doering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=
=3D"_blank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><div id=3D":29m" class=3D"a3s" style=3D"overflow:hidden">Hi,<br>
<span class=3D""><br>
On Wed, Nov 25, 2015 at 08:31:23AM +0300, ValdikSS wrote:<br>
&gt; I need help with 2.3 build system. While the code itself would compile=
 fine, it won&#39;t link because I can&#39;t figure out how to link librari=
es available in vista+<br>
&gt; only for vista+ build and do not link it for XP.<br>
<br>
</span>Cross-build using ubuntu 14.04 and mingw64, and run configure with<b=
r>
&quot;configure ... LIBS=3D&#39;-lwhatyouneed&#39;&quot; for the vista+ bui=
ld.<br>
<br>
For 2.3, that should be good enough.</div></blockquote></div><br></div><div=
 class=3D"gmail_extra">Aha, so original question about building for winxp i=
s probably related to the extra libs added to Makefile.am?=C2=A0 I think it=
 should not be there in the patch for 2.3 so that the code builds cleanly f=
or XP+ with the current 2.3 build setup. Then build specially for vista+ as=
 Gert wrote above.<br><br></div><div class=3D"gmail_extra">Selva<br></div><=
/div>

--001a11453cf4ee3ed305255e16fb--

