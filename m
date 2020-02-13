MIME-Version: 1.0
References: <20191117181243.28919-1-arne@...1227...>
 <20191117181243.28919-2-arne@...1227...>
In-Reply-To: <20191117181243.28919-2-arne@...1227...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 13 Feb 2020 13:45:45 +0200
Message-ID: <CAGyAFMX0MMWHC3GTpfoP1VOvvenNkzdrpZj_5N5RMNa8LphGYw@...278...>
Content-Type: multipart/alternative; boundary="000000000000d3357d059e73a1aa"
Subject: Re: [Openvpn-devel] [PATCH 2/4] Implement dynamic NCP negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000d3357d059e73a1aa
Content-Type: text/plain; charset="UTF-8"

Hi,

su 17. marrask. 2019 klo 20.13 Arne Schwabe (arne@...1227...) kirjoitti:

> +#include "ssl_ncp.h"

this file is missing from this patch.

> +    const char *token = strsep(&tmp_ciphers, ":");

This breaks on Windows.

Could you send v2 with strsep-compat and removed header (which is
introduced in v3) ?

-Lev

--000000000000d3357d059e73a1aa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>su 17. marrask. 2019 klo 20.13 Arne Schwabe (<a=
 href=3D"mailto:arne@...1227...">arne@...1227...</a>) kirjoitti:<br><br>&gt=
; +#include &quot;ssl_ncp.h&quot;<br><br>this file is missing from this pat=
ch.<br><br>&gt; + =C2=A0 =C2=A0const char *token =3D strsep(&amp;tmp_cipher=
s, &quot;:&quot;);<br><br>This breaks on Windows.<br><br>Could you send v2 =
with strsep-compat and removed header (which is introduced in v3) ?<br><br>=
-Lev<br></div>

--000000000000d3357d059e73a1aa--

