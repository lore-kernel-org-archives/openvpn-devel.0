MIME-Version: 1.0
In-Reply-To: <20171012103448.7632-1-simon@...2293...>
References: <20171012103448.7632-1-simon@...2293...>
From: Selva <selva.nair@...277...>
Date: Thu, 12 Oct 2017 11:50:04 -0400
Message-ID: <CAKuzo_i9_Luh2pjqgae8h2zkM5sh7dqRD+G_oCPdk6Bi29jhkA@...278...>
Content-Type: multipart/alternative; boundary="f403043ae604a8ddeb055b5b7f0a"
Subject: Re: [Openvpn-devel] [PATCH] Fix local #include to use quoted form
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--f403043ae604a8ddeb055b5b7f0a
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Oct 12, 2017 at 6:34 AM, Simon Rozman <simon@...2293...> wrote:

> .h include files from the same folder or addressed relatively to the
> same folder should be #included using quoted form in MSVC. The angled
> form is reserved for include files from folders specified using /I
> path.
>
> Using angled form, MSVC fails to locate local #include file, unless
> current folder is added to the include search path: /I .
> ---
>  src/openvpnserv/common.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
> index 0c9098f..e77d7ab 100644
> --- a/src/openvpnserv/common.c
> +++ b/src/openvpnserv/common.c
> @@ -21,8 +21,9 @@
>   *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>   */
>
> -#include <service.h>
> -#include <validate.h>
> +#include "service.h"
> +#include "validate.h"
> +
>  /*
>   * These are necessary due to certain buggy implementations of
> (v)snprintf,
>   * that don't guarantee null termination for size > 0.
>

In mingw builds it works either way as our Makefile includes -I ./ as the
first search path.
But conventionally quoted path is the right thing to use here.

ACK.

Selva

--f403043ae604a8ddeb055b5b7f0a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Thu, Oct 12, 2017 at 6:34 AM, Simon Rozman <span dir=3D"ltr">&lt;=
<a href=3D"mailto:simon@...2293..." target=3D"_blank">simon@...2293...</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">.h include files from t=
he same folder or addressed relatively to the<br>
same folder should be #included using quoted form in MSVC. The angled<br>
form is reserved for include files from folders specified using /I<br>
path.<br>
<br>
Using angled form, MSVC fails to locate local #include file, unless<br>
current folder is added to the include search path: /I .<br>
---<br>
=C2=A0src/openvpnserv/common.c | 5 +++--<br>
=C2=A01 file changed, 3 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c<br>
index 0c9098f..e77d7ab 100644<br>
--- a/src/openvpnserv/common.c<br>
+++ b/src/openvpnserv/common.c<br>
@@ -21,8 +21,9 @@<br>
=C2=A0 *=C2=A0 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<=
br>
=C2=A0 */<br>
<br>
-#include &lt;service.h&gt;<br>
-#include &lt;validate.h&gt;<br>
+#include &quot;service.h&quot;<br>
+#include &quot;validate.h&quot;<br>
+<br>
=C2=A0/*<br>
=C2=A0 * These are necessary due to certain buggy implementations of (v)snp=
rintf,<br>
=C2=A0 * that don&#39;t guarantee null termination for size &gt; 0.<br></bl=
ockquote><div><br></div><div>In mingw builds it works either way as our Mak=
efile includes -I ./ as the first search path.</div><div>But conventionally=
 quoted path is the right thing to use here.</div><div><br></div><div>ACK.<=
/div><div><br></div><div>Selva</div></div></div></div>

--f403043ae604a8ddeb055b5b7f0a--

