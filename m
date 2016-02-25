MIME-Version: 1.0
In-Reply-To: <1456412312-21936-1-git-send-email-gert@...1296...>
References: <20160225125742.GA21087@...1296...>
	<1456412312-21936-1-git-send-email-gert@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 25 Feb 2016 11:02:50 -0500
Message-ID: <CAKuzo_jaeFaMaH+BTQaVof5ADxsqnBDXo3MUp=-Yd9ffGT6uwg@...278...>
Content-Type: multipart/alternative; boundary=001a11369a06abc266052c9a5178
Subject: Re: [Openvpn-devel] [PATCH] Fix openserv/validate.o linking issues
	on mingw.
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

--001a11369a06abc266052c9a5178
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu, Feb 25, 2016 at 9:58 AM, Gert Doering <gert@...1296...> wrote:

> MinGW fails linking after f3c8a04d6021 if the right header files
> (<lm.h> and <shlwapi.h>) are not included.
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpnserv/validate.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
> index d7446de..b5809b3 100644
> --- a/src/openvpnserv/validate.c
> +++ b/src/openvpnserv/validate.c
> @@ -25,6 +25,8 @@
>  #include "validate.h"
>
>  #include <lmaccess.h>
> +#include <shlwapi.h>
> +#include <lm.h>
>
>  static const WCHAR *white_list[] =
>      {
> --
> 1.9.1
>

ACK

Thanks for cleaning up my sloppiness..

Selva

--001a11369a06abc266052c9a5178
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra">Hi,</div><div class=3D"gmai=
l_extra"><br><div class=3D"gmail_quote">On Thu, Feb 25, 2016 at 9:58 AM, Ge=
rt Doering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=
=3D"_blank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">MinGW fails linking after f3c8a04d6021 if the right header files<b=
r>
(&lt;lm.h&gt; and &lt;shlwapi.h&gt;) are not included.<br>
<br>
Signed-off-by: Gert Doering &lt;<a href=3D"mailto:gert@...1296..." target=
=3D"_blank">gert@...1296...</a>&gt;<br>
---<br>
=C2=A0src/openvpnserv/validate.c | 2 ++<br>
=C2=A01 file changed, 2 insertions(+)<br>
<br>
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c<br>
index d7446de..b5809b3 100644<br>
--- a/src/openvpnserv/validate.c<br>
+++ b/src/openvpnserv/validate.c<br>
@@ -25,6 +25,8 @@<br>
=C2=A0#include &quot;validate.h&quot;<br>
<br>
=C2=A0#include &lt;lmaccess.h&gt;<br>
+#include &lt;shlwapi.h&gt;<br>
+#include &lt;lm.h&gt;<br>
<br>
=C2=A0static const WCHAR *white_list[] =3D<br>
=C2=A0 =C2=A0 =C2=A0{<br>
--<br>
1.9.1<br></blockquote><div><br></div><div>ACK</div><div><br></div><div>Than=
ks for cleaning up my sloppiness..</div><div><br></div><div>Selva</div></di=
v></div></div>

--001a11369a06abc266052c9a5178--

