MIME-Version: 1.0
References: <20200330125719.766763-1-wardragon78@...277...>
In-Reply-To: <20200330125719.766763-1-wardragon78@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 30 Mar 2020 16:58:16 -0400
Message-ID: <CAKuzo_gCZ_GMf6m88xnR-BeDh9umtj+CVemrKA+d-phKnDJwBA@...278...>
Content-Type: multipart/alternative; boundary="000000000000bc146505a218b6fd"
Subject: Re: [Openvpn-devel] [PATCH] [PATCH v5] Insert client connection
 data into PAM environment
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Paolo Cerrito <wardragon78@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000bc146505a218b6fd
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, Mar 30, 2020 at 8:59 AM Paolo Cerrito <wardragon78@...277...> wrote:

> 1) so remote was set to the maxlenght of ipv6 address defined into
> arpa/inet.h  + 1 for string terminator
>
> 2) I refactored the call to get_env to take first ipv6 address, then
>    only if it is NULL, i make a call for ipv4
> ---
>  src/plugins/auth-pam/auth-pam.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/src/plugins/auth-pam/auth-pam.c
> b/src/plugins/auth-pam/auth-pam.c
> index ae0d495a..cd91a33c 100644
> --- a/src/plugins/auth-pam/auth-pam.c
> +++ b/src/plugins/auth-pam/auth-pam.c
> @@ -48,7 +48,7 @@
>  #include <signal.h>
>  #include <syslog.h>
>  #include "utils.h"
> -
> +#include <arpa/inet.h>

 #include <openvpn-plugin.h>
>
>  #define DEBUG(verb) ((verb) >= 4)
> @@ -115,7 +115,7 @@ struct user_pass {
>      char password[128];
>      char common_name[128];
>      char response[128];
> -    char remote[46]; //46 as ipv6 form n:n:n:n:n:n:d.d.d.d and +
> terminator \0
> +    char remote[INET6_ADDRSTRLEN+1]; //INET6_ADDRSTRLEN  is the lenght of
> ipv6 + terminator \0
>

INET6_ADDRSTRLEN = 46 already includes space for nul termination

More importantly, you have to provide a single updated patch
preferably with version indicated in the subject and sent out with
--in-reply-to <msgid> referring to the previous version.

Submitting incremental pieces of fixup commits doesn't help. And please
wait for review before making changes unless correcting a critical error.

Thanks,

Selva

--000000000000bc146505a218b6fd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Mon, Mar 30, 2020 at 8:59 AM Paolo Cerrito &lt;=
<a href=3D"mailto:wardragon78@...277...">wardragon78@...277...</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">1) so remote =
was set to the maxlenght of ipv6 address defined into<br>
arpa/inet.h=C2=A0 + 1 for string terminator<br>
<br>
2) I refactored the call to get_env to take first ipv6 address, then<br>
=C2=A0 =C2=A0only if it is NULL, i make a call for ipv4<br>
---<br>
=C2=A0src/plugins/auth-pam/auth-pam.c | 8 +++++---<br>
=C2=A01 file changed, 5 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pa=
m.c<br>
index ae0d495a..cd91a33c 100644<br>
--- a/src/plugins/auth-pam/auth-pam.c<br>
+++ b/src/plugins/auth-pam/auth-pam.c<br>
@@ -48,7 +48,7 @@<br>
=C2=A0#include &lt;signal.h&gt;<br>
=C2=A0#include &lt;syslog.h&gt;<br>
=C2=A0#include &quot;utils.h&quot;<br>
-<br>
+#include &lt;arpa/inet.h&gt;=C2=A0</blockquote><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
=C2=A0#include &lt;openvpn-plugin.h&gt;<br>
<br>
=C2=A0#define DEBUG(verb) ((verb) &gt;=3D 4)<br>
@@ -115,7 +115,7 @@ struct user_pass {<br>
=C2=A0 =C2=A0 =C2=A0char password[128];<br>
=C2=A0 =C2=A0 =C2=A0char common_name[128];<br>
=C2=A0 =C2=A0 =C2=A0char response[128];<br>
-=C2=A0 =C2=A0 char remote[46]; //46 as ipv6 form n:n:n:n:n:n:d.d.d.d and +=
 terminator \0<br>
+=C2=A0 =C2=A0 char remote[INET6_ADDRSTRLEN+1]; //INET6_ADDRSTRLEN=C2=A0 is=
 the lenght of ipv6 + terminator \0<br></blockquote><div><br></div><div>INE=
T6_ADDRSTRLEN =3D 46 already includes space for nul termination=C2=A0</div>=
<div><br></div><div>More importantly, you have to provide a single updated =
patch=C2=A0</div><div>preferably=C2=A0with version indicated in the subject=
 and sent out with</div><div>--in-reply-to &lt;msgid&gt; referring to the p=
revious version.</div><div><br></div><div>Submitting incremental pieces of =
fixup commits doesn&#39;t help. And please</div><div>wait for review before=
 making changes unless correcting a critical error.</div><div><br></div><di=
v>Thanks,</div><div><br></div><div>Selva</div></div></div>

--000000000000bc146505a218b6fd--

