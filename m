MIME-Version: 1.0
In-Reply-To: <20160918121423.52139-1-gert@...1296...>
References: <20160917132024.12570-1-gert@...1296...>
	<20160918121423.52139-1-gert@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 18 Sep 2016 12:38:46 -0400
Message-ID: <CAKuzo_hOy8A23_Zeho86qsk=c5bYO1Nz5n1ZQPgdGcTCVmp-Qg@...278...>
Content-Type: multipart/alternative; boundary=94eb2c06afa08c67be053ccad584
Subject: Re: [Openvpn-devel] [PATCHv2] Fix win32 building with C99 mode
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

--94eb2c06afa08c67be053ccad584
Content-Type: text/plain; charset=UTF-8

Hi,

On Sun, Sep 18, 2016 at 8:14 AM, Gert Doering <gert@...1296...> wrote:

> In -std=c99 mode, WIN32 is not defined to be "1" anymore, but just
> "#define WIN32" - so the "#if WIN32" breaks, needs to be "#ifdef WIN32"
>
> v2: also fix block_dns.c (include config.h + compat.h)  (Selva Nair)
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/block_dns.c     | 11 +++++++++++
>  src/openvpn/misc.c          |  2 +-
>  src/openvpnserv/Makefile.am |  2 +-
>  3 files changed, 13 insertions(+), 2 deletions(-)
>

The patch looks good, fixes windows cross-compile and appears to work fine
(as per a quick run on Win 7). Thanks.

ACK from me.

Selva

--94eb2c06afa08c67be053ccad584
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Sun, Sep 18, 2016 at 8:14 AM, Ge=
rt Doering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=
=3D"_blank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><span>In -std=3Dc99 mode, WIN32 is not defined to be &quot;1&quot;=
 anymore, but just<br>
&quot;#define WIN32&quot; - so the &quot;#if WIN32&quot; breaks, needs to b=
e &quot;#ifdef WIN32&quot;<br>
<br>
</span>v2: also fix block_dns.c (include config.h + compat.h)=C2=A0 (Selva =
Nair)<br>
<span><br>
Signed-off-by: Gert Doering &lt;<a href=3D"mailto:gert@...1296..." target=
=3D"_blank">gert@...1296...</a>&gt;<br>
---<br>
</span>=C2=A0src/openvpn/block_dns.c=C2=A0 =C2=A0 =C2=A0| 11 +++++++++++<br>
=C2=A0src/openvpn/misc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0src/openvpnserv/Makefile.am |=C2=A0 2 +-<br>
=C2=A03 files changed, 13 insertions(+), 2 deletions(-)<br></blockquote></d=
iv><br></div><div class=3D"gmail_extra">The patch looks good, fixes windows=
 cross-compile and appears to work fine (as per a quick run on Win 7). Than=
ks.<br><br></div><div class=3D"gmail_extra">ACK from me.<br><br></div><div =
class=3D"gmail_extra">Selva<br></div></div>

--94eb2c06afa08c67be053ccad584--

