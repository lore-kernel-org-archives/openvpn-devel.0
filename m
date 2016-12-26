MIME-Version: 1.0
In-Reply-To: <1482779743-9548-1-git-send-email-steffan@...1856...>
References: <1482779743-9548-1-git-send-email-steffan@...1856...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 26 Dec 2016 15:36:29 -0500
Message-ID: <CAKuzo_g2ykjoTS60ft6gsjAqb3aqX-RBA-tkDY0PYk4tnovCLA@...278...>
Content-Type: multipart/alternative; boundary=001a114349c2ee8cae054495b139
Subject: Re: [Openvpn-devel] [PATCH] Textual fixes for Changes.rst
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

--001a114349c2ee8cae054495b139
Content-Type: text/plain; charset=UTF-8

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

--001a114349c2ee8cae054495b139
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br><br></div>Not a thorough proof read, but some =
comments:<br><div><div><div class=3D"gmail_extra"><br><div class=3D"gmail_q=
uote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">=C2=A0
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
ipts and ``--plugin``<br></blockquote><div><br></div><div>This option could=
 be in the client config or pushed from the server, so<br></div><div>&quot;=
This may be pushed to clients ....&quot;=C2=A0 would be better?<br></div><d=
iv><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
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
Windows is not<br></blockquote><div><br></div><div>if ... not --&gt; unless=
 (?)<br></div><div>services -&gt; service<br>=C2=A0<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">
+=C2=A0 =C2=A0 being used.=C2=A0 If the interactive services is used, this =
service will execute<br></blockquote><div><br></div><div>services -&gt; ser=
vice=C2=A0 <br></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
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
+=C2=A0 header combinations fail.=C2=A0</blockquote><div><br></div><div>Mov=
e &quot;fail&quot; up:<br><br></div><div>&quot;This may fail on some older =
compiler/libc header combinations.&quot;<br><br></div><div>Selva<br></div><=
/div></div></div></div></div>

--001a114349c2ee8cae054495b139--

