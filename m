MIME-Version: 1.0
In-Reply-To: <1480371252-3880-1-git-send-email-steffan@...1856...>
References: <68d50540-ec71-5564-99a7-7bb24ae05d17@...1856...>
	<1480371252-3880-1-git-send-email-steffan@...1856...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 29 Nov 2016 10:29:41 -0500
Message-ID: <CAKuzo_jgdKPey99BH30z0vBqBH1e8h9sQULdETArv3rSZQ2obw@...278...>
Content-Type: multipart/alternative; boundary=94eb2c12542210557a05427243e0
Subject: Re: [Openvpn-devel] [PATCH v2] Introduce and use secure_memzero()
 to erase secrets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c12542210557a05427243e0
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon, Nov 28, 2016 at 5:14 PM, Steffan Karger <steffan@...1856...> wrote:

> As described in trac #751, and shortly after reported by Zhaomo Yang, of
> the University of California, San Diego, we use memset() (often through
> the CLEAR() macro) to erase secrets after use.  In some cases however, the
> compiler might optimize these calls away.
>
> This patch replaces these memset() calls on secrets by calls to a new
> secure_memzero() function, that will not be optimized away.
>
> Since we use CLEAR() a LOT of times, I'm not changing that to use
> secure_memzero() to prevent performance impact.  I did annotate the macro
> to point people at secure_memzero().
>
> This patch also replaces some CLEAR() or memset() calls with a zero-
> initialization using "= { 0 }" if that has the same effect, because that
> better captures the intend of that code.
>
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
> v2: replace more memset()/CLEAR() calls with secure_memzero()
>
>  src/openvpn/basic.h              |  2 +-
>  src/openvpn/buffer.c             |  8 ++++----
>  src/openvpn/buffer.h             | 43 ++++++++++++++++++++++++++++++
> ++++++++++
>  src/openvpn/console_builtin.c    |  2 +-
>  src/openvpn/crypto.c             | 17 ++++++----------
>  src/openvpn/manage.c             |  2 +-
>  src/openvpn/misc.c               |  4 ++--
>  src/openvpn/options.c            |  6 +++---
>  src/openvpn/ssl.c                | 32 +++++++++++++++---------------
>  src/openvpn/ssl_verify.c         |  4 ++--
>  src/openvpn/ssl_verify_mbedtls.c |  4 +---
>  11 files changed, 80 insertions(+), 44 deletions(-)


Took a second look at v2: sizes of data structs/buffers correctly passed to
secure_memset and no new warnings with gcc -Wall :)

ACK.

Selva

--94eb2c12542210557a05427243e0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Mon, Nov 28, 2016 at 5:14 PM, Steffa=
n Karger <span dir=3D"ltr">&lt;<a href=3D"mailto:steffan@...1856..." target=
=3D"_blank">steffan@...1856...</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><span>As described in trac #751, and shortly after reported b=
y Zhaomo Yang, of<br>
the University of California, San Diego, we use memset() (often through<br>
the CLEAR() macro) to erase secrets after use.=C2=A0 In some cases however,=
 the<br>
compiler might optimize these calls away.<br>
<br>
This patch replaces these memset() calls on secrets by calls to a new<br>
secure_memzero() function, that will not be optimized away.<br>
<br>
Since we use CLEAR() a LOT of times, I&#39;m not changing that to use<br>
secure_memzero() to prevent performance impact.=C2=A0 I did annotate the ma=
cro<br>
to point people at secure_memzero().<br>
<br>
This patch also replaces some CLEAR() or memset() calls with a zero-<br>
initialization using &quot;=3D { 0 }&quot; if that has the same effect, bec=
ause that<br>
better captures the intend of that code.<br>
<br>
Signed-off-by: Steffan Karger &lt;<a href=3D"mailto:steffan.karger@...2191...=
.." target=3D"_blank">steffan.karger@...1435...</a>&gt;<br>
</span>---<br>
v2: replace more memset()/CLEAR() calls with secure_memzero()<br>
<span><br>
=C2=A0src/openvpn/basic.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 2 +-<br>
=C2=A0src/openvpn/buffer.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 8 ++++----<br>
=C2=A0src/openvpn/buffer.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 43 ++++++++++++++++++++++++++++++<wbr>++++++++++<br>
</span>=C2=A0src/openvpn/console_builtin.<wbr>c=C2=A0 =C2=A0 |=C2=A0 2 +-<b=
r>
=C2=A0src/openvpn/crypto.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 17 ++++++----------<br>
=C2=A0src/openvpn/manage.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 2 +-<br>
=C2=A0src/openvpn/misc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 4 ++--<br>
=C2=A0src/openvpn/options.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 6 +++---<br>
=C2=A0src/openvpn/ssl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 32 +++++++++++++++---------------<br>
=C2=A0src/openvpn/ssl_verify.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 +=
+--<br>
=C2=A0src/openvpn/ssl_verify_mbedtl<wbr>s.c |=C2=A0 4 +---<br>
=C2=A011 files changed, 80 insertions(+), 44 deletions(-)</blockquote></div=
><br>Took a second look at v2: sizes of data structs/buffers correctly pass=
ed to secure_memset and no new warnings with gcc -Wall :)=C2=A0</div><div c=
lass=3D"gmail_extra"><br></div><div class=3D"gmail_extra">ACK.</div><div cl=
ass=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva</div></div>

--94eb2c12542210557a05427243e0--

