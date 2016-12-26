MIME-Version: 1.0
In-Reply-To: <CAKuzo_g2ykjoTS60ft6gsjAqb3aqX-RBA-tkDY0PYk4tnovCLA@...278...>
References: <1482779743-9548-1-git-send-email-steffan@...1856...>
	<CAKuzo_g2ykjoTS60ft6gsjAqb3aqX-RBA-tkDY0PYk4tnovCLA@...278...>
From: Steffan Karger <steffan@...1856...>
Date: Mon, 26 Dec 2016 21:48:17 +0100
Message-ID: <CAA1AbxLszGL=ckmo4yMKyp56oZAppKffFDNhEG6CNH6Xve=AUw@...278...>
Content-Type: multipart/alternative; boundary=001a113cf144fd5b17054495da4c
Subject: Re: [Openvpn-devel] [PATCH] Textual fixes for Changes.rst
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a113cf144fd5b17054495da4c
Content-Type: text/plain; charset=UTF-8

Hi,

On 26 Dec 2016 9:36 p.m., "Selva Nair" <selva.nair@...277...> wrote:

Hi,

Not a thorough proof read, but some comments:

  Support for providing IPv6 DNS servers
> -     A new DHCP sub-options ``DNS6`` is added alongside with the already
> existing
> -     ``DNS`` sub-option.  This is used to provide DNS resolvers available
> over
> -     IPv6.  This will be pushed to clients and `` --up`` scripts and
> ``--plugin``
> -     can act upon it through the ``foreign_option_<n>`` environment
> variables.
> +    A new DHCP sub-option ``DNS6`` is added alongside with the already
> existing
> +    ``DNS`` sub-option.  This is used to provide DNS resolvers available
> over
> +    IPv6.  This will be pushed to clients and `` --up`` scripts and
> ``--plugin``
>

This option could be in the client config or pushed from the server, so
"This may be pushed to clients ...."  would be better?

+    can act upon it through the ``foreign_option_<n>`` environment
> variables.
>
> -     Support for the Windows client picking up this new sub-option is
> added,
> -     however IPv6 DNS resolvers needs to be configured via ``netsh``
> which requires
> -     administrator privileges if the new interactive services on Windows
> is not
> -     being used.  If the interactive services is used, this service will
> execute
> -     ``netsh`` in the background with the proper privileges.
> +    Support for the Windows client picking up this new sub-option is
> added,
> +    however IPv6 DNS resolvers need to be configured via ``netsh`` which
> requires
> +    administrator privileges if the new interactive services on Windows
> is not
>

if ... not --> unless (?)
services -> service


> +    being used.  If the interactive services is used, this service will
> execute
>

services -> service


>
>
> -- With OpenVPN v2.4, the project have moved over to depend on and
> actively use
> +- With OpenVPN v2.4, the project has moved over to depend on and actively
> use
>    the official C99 standard (-std=c99).  This may on some older
> compiler/libc
> -  headers combinations fail.  On most of these situations it is
> recommended to
> +  header combinations fail.


Move "fail" up:

"This may fail on some older compiler/libc header combinations."

Selva


The first one is something I cannot judge immediately, but with all other
changes I fully agree.

I won't be near a PC for the coming 12 hours. Feel free to resend the patch
with any changes you think are good, or amend when applying.

-Steffan

--001a113cf144fd5b17054495da4c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi,<div class=3D"gmail_extra"><br><div class=3D"gmai=
l_quote">On 26 Dec 2016 9:36 p.m., &quot;Selva Nair&quot; &lt;<a href=3D"ma=
ilto:selva.nair@...277...">selva.nair@...277...</a>&gt; wrote:<br type=3D"a=
ttribution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div>Hi,<br><br></div=
>Not a thorough proof read, but some comments:<br><div><div><div class=3D"g=
mail_extra"><br><div class=3D"gmail_quote"><div class=3D"quoted-text"><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">=C2=A0
Support for providing IPv6 DNS servers<br>
-=C2=A0 =C2=A0 =C2=A0A new DHCP sub-options ``DNS6`` is added alongside wit=
h the already existing<br>
-=C2=A0 =C2=A0 =C2=A0``DNS`` sub-option.=C2=A0 This is used to provide DNS =
resolvers available over<br>
-=C2=A0 =C2=A0 =C2=A0IPv6.=C2=A0 This will be pushed to clients and `` --up=
`` scripts and ``--plugin``<br>
-=C2=A0 =C2=A0 =C2=A0can act upon it through the ``foreign_option_&lt;n&gt;=
`` environment variables.<br>
+=C2=A0 =C2=A0 A new DHCP sub-option ``DNS6`` is added alongside with the a=
lready existing<br>
+=C2=A0 =C2=A0 ``DNS`` sub-option.=C2=A0 This is used to provide DNS resolv=
ers available over<br>
+=C2=A0 =C2=A0 IPv6.=C2=A0 This will be pushed to clients and `` --up`` scr=
ipts and ``--plugin``<br></blockquote><div><br></div></div><div>This option=
 could be in the client config or pushed from the server, so<br></div><div>=
&quot;This may be pushed to clients ....&quot;=C2=A0 would be better?<br></=
div><div class=3D"quoted-text"><div><br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
+=C2=A0 =C2=A0 can act upon it through the ``foreign_option_&lt;n&gt;`` env=
ironment variables.<br>
<br>
-=C2=A0 =C2=A0 =C2=A0Support for the Windows client picking up this new sub=
-option is added,<br>
-=C2=A0 =C2=A0 =C2=A0however IPv6 DNS resolvers needs to be configured via =
``netsh`` which requires<br>
-=C2=A0 =C2=A0 =C2=A0administrator privileges if the new interactive servic=
es on Windows is not<br>
-=C2=A0 =C2=A0 =C2=A0being used.=C2=A0 If the interactive services is used,=
 this service will execute<br>
-=C2=A0 =C2=A0 =C2=A0``netsh`` in the background with the proper privileges=
.<br>
+=C2=A0 =C2=A0 Support for the Windows client picking up this new sub-optio=
n is added,<br>
+=C2=A0 =C2=A0 however IPv6 DNS resolvers need to be configured via ``netsh=
`` which requires<br>
+=C2=A0 =C2=A0 administrator privileges if the new interactive services on =
Windows is not<br></blockquote><div><br></div></div><div>if ... not --&gt; =
unless (?)<br></div><div>services -&gt; service<br>=C2=A0<br></div><div cla=
ss=3D"quoted-text"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
+=C2=A0 =C2=A0 being used.=C2=A0 If the interactive services is used, this =
service will execute<br></blockquote><div><br></div></div><div>services -&g=
t; service=C2=A0 <br></div><div class=3D"quoted-text"><div>=C2=A0<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
<br>
-- With OpenVPN v2.4, the project have moved over to depend on and actively=
 use<br>
+- With OpenVPN v2.4, the project has moved over to depend on and actively =
use<br>
=C2=A0 =C2=A0the official C99 standard (-std=3Dc99).=C2=A0 This may on some=
 older compiler/libc<br>
-=C2=A0 headers combinations fail.=C2=A0 On most of these situations it is =
recommended to<br>
+=C2=A0 header combinations fail.=C2=A0</blockquote><div><br></div></div><d=
iv>Move &quot;fail&quot; up:<br><br></div><div>&quot;This may fail on some =
older compiler/libc header combinations.&quot;<font color=3D"#888888"><br><=
br></font></div><font color=3D"#888888"><div>Selva<br></div></font></div></=
div></div></div></div></blockquote></div></div></div><div dir=3D"auto"><spa=
n style=3D"font-family:sans-serif"><br></span></div><div dir=3D"auto"><span=
 style=3D"font-family:sans-serif">The first one is something I cannot judge=
 immediately, but with all other changes I fully agree.</span></div><div di=
r=3D"auto"><span style=3D"font-family:sans-serif"><br></span></div><div dir=
=3D"auto"><span style=3D"font-family:sans-serif">I won&#39;t be near a PC f=
or the coming 12 hours. Feel free to resend the patch with any changes you =
think are good, or amend when applying.=C2=A0</span><br></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto"><div class=3D"gmail_extra"><div class=3D"g=
mail_quote"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div><div><div class=
=3D"gmail_extra"><div class=3D"gmail_quote"><font color=3D"#888888"><div></=
div></font></div></div></div></div></div>
</blockquote></div>-Steffan</div></div></div>

--001a113cf144fd5b17054495da4c--

