MIME-Version: 1.0
References: <20230208001819.244694-1-arne@...1227...>
 <20230208001819.244694-5-arne@...1227...>
 <CAKuzo_gxab-8tZtpYdR31AKvb=8Q2f931KxdjSY5h11JYtLtOw@...278...>
In-Reply-To: <CAKuzo_gxab-8tZtpYdR31AKvb=8Q2f931KxdjSY5h11JYtLtOw@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 9 Feb 2023 17:23:42 -0500
Message-ID: <CAKuzo_h0eqNe2DU3aXysy8SNLQAT5DAp7i0b-EB8m-bYcmEEXg@...278...>
Content-Type: multipart/alternative; boundary="0000000000004375a205f44bd688"
Subject: [Openvpn-devel] Fwd: [PATCH 4/5] Add missing stdint.h includes in
 unit tests files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000004375a205f44bd688
Content-Type: text/plain; charset="UTF-8"

CC: list

---------- Forwarded message ---------
From: Selva Nair <selva.nair@...277...>
Date: Wed, Feb 8, 2023 at 11:34 PM
Subject: Re: [Openvpn-devel] [PATCH 4/5] Add missing stdint.h includes in
unit tests files
To: Arne Schwabe <arne@...1227...>


Hi,

On Tue, Feb 7, 2023 at 7:19 PM Arne Schwabe <arne@...1227...> wrote:

> My mingw compiler/headers (mingw-w64 10.0.0 on macOS) seem to be more
> pendantic than the one that comes with Ubuntu 22.04 (github actions) or
> any of the other platforms including msvc/normal windows header.
>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  tests/unit_tests/example_test/test.c  | 1 +
>  tests/unit_tests/example_test/test2.c | 1 +
>  tests/unit_tests/openvpn/mock_msg.c   | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/tests/unit_tests/example_test/test.c
> b/tests/unit_tests/example_test/test.c
> index ea31b884d..c174025cc 100644
> --- a/tests/unit_tests/example_test/test.c
> +++ b/tests/unit_tests/example_test/test.c
> @@ -4,6 +4,7 @@
>  #include <stdarg.h>
>  #include <string.h>
>  #include <setjmp.h>
> +#include <stdint.h>
>  #include <cmocka.h>
>
>  static int
> diff --git a/tests/unit_tests/example_test/test2.c
> b/tests/unit_tests/example_test/test2.c
> index 5a186d5d7..bb54633c8 100644
> --- a/tests/unit_tests/example_test/test2.c
> +++ b/tests/unit_tests/example_test/test2.c
> @@ -4,6 +4,7 @@
>  #include <stdarg.h>
>  #include <string.h>
>  #include <setjmp.h>
> +#include <stdint.h>
>  #include <cmocka.h>
>
>
> diff --git a/tests/unit_tests/openvpn/mock_msg.c
> b/tests/unit_tests/openvpn/mock_msg.c
> index 3ede98c00..3fa9a166f 100644
> --- a/tests/unit_tests/openvpn/mock_msg.c
> +++ b/tests/unit_tests/openvpn/mock_msg.c
> @@ -32,6 +32,7 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <setjmp.h>
> +#include <stdint.h>
>  #include <cmocka.h>


Actually it may not be your setup: mingw on Linux also requires this if
using cmocka-master branch. cmocka-1.1.5 works without this include for me.
That would explain why we haven't seen this error yet in native builds.

Anyway, cmocka docs also tell us to always include <stdint.h>.

Acked-by: Selva Nair <selva.nair@...277...>

--0000000000004375a205f44bd688
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">CC: list<br><br><div class=3D"gmail_quote"><div dir=3D"ltr=
" class=3D"gmail_attr">---------- Forwarded message ---------<br>From: <str=
ong class=3D"gmail_sendername" dir=3D"auto">Selva Nair</strong> <span dir=
=3D"auto">&lt;<a href=3D"mailto:selva.nair@...277...">selva.nair@...277...<=
/a>&gt;</span><br>Date: Wed, Feb 8, 2023 at 11:34 PM<br>Subject: Re: [Openv=
pn-devel] [PATCH 4/5] Add missing stdint.h includes in unit tests files<br>=
To: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227...">arne@...1227...</a>=
&gt;<br></div><br><br><div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 7, 2023 at 7:19 =
PM Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=3D"_blank">ar=
ne@...1227...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">My mingw compiler/headers (mingw-w64 10.0.0 on macOS) seem to =
be more<br>
pendantic than the one that comes with Ubuntu 22.04 (github actions) or<br>
any of the other platforms including msvc/normal windows header.<br>
<br>
Signed-off-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=
=3D"_blank">arne@...1227...</a>&gt;<br>
---<br>
=C2=A0tests/unit_tests/example_test/test.c=C2=A0 | 1 +<br>
=C2=A0tests/unit_tests/example_test/test2.c | 1 +<br>
=C2=A0tests/unit_tests/openvpn/mock_msg.c=C2=A0 =C2=A0| 1 +<br>
=C2=A03 files changed, 3 insertions(+)<br>
<br>
diff --git a/tests/unit_tests/example_test/test.c b/tests/unit_tests/exampl=
e_test/test.c<br>
index ea31b884d..c174025cc 100644<br>
--- a/tests/unit_tests/example_test/test.c<br>
+++ b/tests/unit_tests/example_test/test.c<br>
@@ -4,6 +4,7 @@<br>
=C2=A0#include &lt;stdarg.h&gt;<br>
=C2=A0#include &lt;string.h&gt;<br>
=C2=A0#include &lt;setjmp.h&gt;<br>
+#include &lt;stdint.h&gt;<br>
=C2=A0#include &lt;cmocka.h&gt;<br>
<br>
=C2=A0static int<br>
diff --git a/tests/unit_tests/example_test/test2.c b/tests/unit_tests/examp=
le_test/test2.c<br>
index 5a186d5d7..bb54633c8 100644<br>
--- a/tests/unit_tests/example_test/test2.c<br>
+++ b/tests/unit_tests/example_test/test2.c<br>
@@ -4,6 +4,7 @@<br>
=C2=A0#include &lt;stdarg.h&gt;<br>
=C2=A0#include &lt;string.h&gt;<br>
=C2=A0#include &lt;setjmp.h&gt;<br>
+#include &lt;stdint.h&gt;<br>
=C2=A0#include &lt;cmocka.h&gt;<br>
<br>
<br>
diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn=
/mock_msg.c<br>
index 3ede98c00..3fa9a166f 100644<br>
--- a/tests/unit_tests/openvpn/mock_msg.c<br>
+++ b/tests/unit_tests/openvpn/mock_msg.c<br>
@@ -32,6 +32,7 @@<br>
=C2=A0#include &lt;stdio.h&gt;<br>
=C2=A0#include &lt;stdlib.h&gt;<br>
=C2=A0#include &lt;setjmp.h&gt;<br>
+#include &lt;stdint.h&gt;<br>
=C2=A0#include &lt;cmocka.h&gt;</blockquote><div><br></div><div>Actually it=
 may not be your setup: mingw on Linux also requires this if using cmocka-m=
aster branch. cmocka-1.1.5 works without=C2=A0this include for me. That wou=
ld=C2=A0explain why we haven&#39;t seen this error yet in native builds.=C2=
=A0</div><div><br></div><div>Anyway, cmocka docs also tell us to always inc=
lude &lt;stdint.h&gt;.</div><div><br></div><div>Acked-by: Selva Nair &lt;<a=
 href=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...1663...=
.</a>&gt;</div></div></div>
</div></div>

--0000000000004375a205f44bd688--

