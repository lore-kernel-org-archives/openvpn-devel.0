MIME-Version: 1.0
In-Reply-To: <1456434007-5361-1-git-send-email-fish.thss@...277...>
References: <20160225120415.GB24952@...1296...>
	<1456434007-5361-1-git-send-email-fish.thss@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 25 Feb 2016 17:59:02 -0500
Message-ID: <CAKuzo_i5PNj4uXfeYTyEZss3vzRhU-77u0CiBvTY6Jox4P9quw@...278...>
Content-Type: multipart/alternative; boundary=001a113d54f81f4dae052ca02280
Subject: Re: [Openvpn-devel] [PATCH v4] Make openvpnserv compilable under
 Visual Studio.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Fish <fish.thss@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113d54f81f4dae052ca02280
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu, Feb 25, 2016 at 4:00 PM, Fish <fish.thss@...277...> wrote:

> +#ifndef _WIN32_H
> +#define _WIN32_H
> +
> +#if defined(_MSC_VER)
> +#define snwprintf _snwprintf
> +#endif
> +
> +#endif
>

We could've just used _snwprintf directly in the sources and avoided a new
header file. mingw has both. Well, may be someone would care to write an
openvpn_snwprintf wrapper like the openvpn_sntprintf..

     const WCHAR *msg1 = L"You have specified a config file location (%s
> relative to %s)"
> -                        " that requires admin approval. This error may be
> avoided"
> -                        " by adding your account to the \"%s\" group";
> +                        L" that requires admin approval. This error may
> be avoided"
> +                        L" by adding your account to the \"%s\" group";


Good to know MS has its own standards :-)

By the way, I'm going to submit the rebased patch for block-outside-dns
through iservice later tonight. But no idea what is required to make it
compile with Visual Studio.

Selva

--001a113d54f81f4dae052ca02280
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Thu, Feb 25, 2016 at 4:00 PM, Fish <=
span dir=3D"ltr">&lt;<a href=3D"mailto:fish.thss@...277..." target=3D"_blan=
k">fish.thss@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div style=
=3D"overflow:hidden">+#ifndef _WIN32_H<br>
+#define _WIN32_H<br>
+<br>
+#if defined(_MSC_VER)<br>
+#define snwprintf _snwprintf<br>
+#endif<br>
+<br>
+#endif</div></blockquote></div><br>We could&#39;ve just used _snwprintf di=
rectly in the sources and avoided a new header file. mingw has both. Well, =
may be someone would care to write an openvpn_snwprintf wrapper like the op=
envpn_sntprintf..</div><div class=3D"gmail_extra"><br></div><div class=3D"g=
mail_extra"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-s=
tyle:solid;padding-left:1ex">=C2=A0 =C2=A0 =C2=A0const WCHAR *msg1 =3D L&qu=
ot;You have specified a config file location (%s relative to %s)&quot;<br>-=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot; that requires admin approval. This error may be avoided&qu=
ot;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot; by adding your account to the \&quot;%s\&quot; grou=
p&quot;;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0L&quot; that requires admin approval. This error ma=
y be avoided&quot;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0L&quot; by adding your account to the \&q=
uot;%s\&quot; group&quot;;</blockquote><div><br></div><div>Good to know MS =
has its own standards :-)=C2=A0</div><div><br></div><div>By the way, I&#39;=
m going to submit the rebased patch for block-outside-dns through iservice =
later tonight. But no idea what is required to make it compile with Visual =
Studio.</div><div><br></div></div><div class=3D"gmail_extra">Selva</div></d=
iv>

--001a113d54f81f4dae052ca02280--

