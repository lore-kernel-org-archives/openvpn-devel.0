MIME-Version: 1.0
In-Reply-To: <20160306134402.GW24952@...1296...>
References: <20160225125008.GD24952@...1296...>
	<1456457091-3872-1-git-send-email-selva.nair@...277...>
	<20160306134402.GW24952@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 6 Mar 2016 09:20:48 -0500
Message-ID: <CAKuzo_jvCxAs8zrNABX02BENdsk+hk=KpwzXB8NA1J_8av-bQA@...278...>
Content-Type: multipart/alternative; boundary=089e01538c3c3113ba052d620f41
Subject: Re: [Openvpn-devel] [PATCH v2 1/2] Refactor and move the
 block-outside-dns code to a new file (block_dns.[ch])
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

--089e01538c3c3113ba052d620f41
Content-Type: text/plain; charset=UTF-8

On Sun, Mar 6, 2016 at 8:44 AM, Gert Doering <gert@...1296...> wrote:

> Trying to compile this on mingw 32bit, block_dns.c blows up for me
> unless I add two more header files to get definitions for ADDRESS_FAMILY
> and SOCKADDR_INET (which are referenced by iphlpapi.c)
>
> --- a/src/openvpn/block_dns.c
> +++ b/src/openvpn/block_dns.c
> @@ -29,6 +29,8 @@
>  #include <fwpmu.h>
>  #include <initguid.h>
>  #include <fwpmtypes.h>
> +#include <winsock2.h>
> +#include <ws2ipdef.h>
>  #include <iphlpapi.h>
>  #include "block_dns.h"
>
> ... with these changes, both openvpn.exe and openvpnserv.exe compile
> and link nicely.
>

It must have been my sloppiness. I copied the relevant snippets from
win32.c and only the headers needed to compile cleanly. Did not check the
docs thoroughly..


>
> MS documentation says one should include <winsock2.h>, but that is not
> sufficient for me.
>
> So, question 1: is this a mingw issue, or just a 32bit windows requirement
> and you only tested on 64bit?
>

Strange thing is that it compiles and links without error (even with -Wall)
using mingw I have here (uses gcc 4.6.3).


>
> question 2: shall I just add these two header files and take note in
> the ACK-and-merge e-mail, or do you want to re-send a v3?
>

Please add the headers and the note. Thanks.

Selva

--089e01538c3c3113ba052d620f41
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sun, Mar 6, 2016 at 8:44 AM, Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div id=3D":1bd" class=3D"a3s" s=
tyle=3D"overflow:hidden">Trying to compile this on mingw 32bit, block_dns.c=
 blows up for me<br>
unless I add two more header files to get definitions for ADDRESS_FAMILY<br>
and SOCKADDR_INET (which are referenced by iphlpapi.c)<br>
<br>
--- a/src/openvpn/block_dns.c<br>
+++ b/src/openvpn/block_dns.c<br>
@@ -29,6 +29,8 @@<br>
=C2=A0#include &lt;fwpmu.h&gt;<br>
=C2=A0#include &lt;initguid.h&gt;<br>
=C2=A0#include &lt;fwpmtypes.h&gt;<br>
+#include &lt;winsock2.h&gt;<br>
+#include &lt;ws2ipdef.h&gt;<br>
=C2=A0#include &lt;iphlpapi.h&gt;<br>
=C2=A0#include &quot;block_dns.h&quot;<br>
<br>
... with these changes, both openvpn.exe and openvpnserv.exe compile<br>
and link nicely.<br></div></blockquote><div><br></div><div>It must have bee=
n my sloppiness. I copied the relevant snippets from win32.c and only the h=
eaders needed to compile cleanly. Did not check the docs thoroughly..<br>=
=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":1bd" class=3D"a3=
s" style=3D"overflow:hidden">
<br>
MS documentation says one should include &lt;winsock2.h&gt;, but that is no=
t<br>
sufficient for me.<br>
<br>
So, question 1: is this a mingw issue, or just a 32bit windows requirement<=
br>
and you only tested on 64bit?<br></div></blockquote><div><br></div><div>Str=
ange thing is that it compiles and links without error (even with -Wall) us=
ing mingw I have here (uses gcc 4.6.3).<br></div><div>=C2=A0<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex"><div id=3D":1bd" class=3D"a3s" style=3D"overflow:=
hidden">
<br>
question 2: shall I just add these two header files and take note in<br>
the ACK-and-merge e-mail, or do you want to re-send a v3?</div></blockquote=
></div><br></div><div class=3D"gmail_extra">Please add the headers and the =
note. Thanks.<br><br></div><div class=3D"gmail_extra">Selva<br></div><div c=
lass=3D"gmail_extra"><br></div></div>

--089e01538c3c3113ba052d620f41--

