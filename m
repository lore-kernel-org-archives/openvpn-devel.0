MIME-Version: 1.0
In-Reply-To: <56560812.4050008@...2070...>
References: <20151125082651.GT24952@...1296...>
	<1448477731-21421-1-git-send-email-iam@...2070...>
	<56560812.4050008@...2070...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 26 Nov 2015 12:20:58 -0500
Message-ID: <CAKuzo_j+asj4qBeZEPMcOH5coqy2PmXpLzBQQ5Vd6j8jJ2njbQ@...278...>
Content-Type: multipart/alternative; boundary=001a114b2a5287ccde052574cd15
Subject: Re: [Openvpn-devel] [PATCH v5-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <iam@...2070...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114b2a5287ccde052574cd15
Content-Type: text/plain; charset=UTF-8

Hi,

I did some tests on the patch for 2.3 [*]. Build for vista+ needed some
hacking of configure.ac (but that's not relevant for this patch).

For XP+, it builds out of the box. When the resulting exe is run on windows
7 with --block-outside-dns, it prints the following warning

"NOTE: block-outside-dns option works only on Windows"

Apart from the confusing warning, I had expected the process to exit with
unknown option error.

+#if _WIN32_WINNT >= 0x0600
> +      options->block_outside_dns = true;
> +#else
> +      msg (M_WARN, "NOTE: block-outside-dns option works only on
> Windows");


This has to be something like  "... not supported in this version or build"
or some such..

In fact, that #else clause short-circuits the default error handling of
unknown/unsupported options. It may be best to omit it altogether and let
the final if-block handle the unknown option. Or at least use msglevel_fc
in place of M_WARN so that it will exit if appropriate to do so.

+#endif


Selva

[*] v5 2.3 patch with the missing include <initguid.h> manually added.

--001a114b2a5287ccde052574cd15
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">Hi,<=
/div><br></div><div class=3D"gmail_extra">I did some tests on the patch for=
 2.3 [*]. Build for vista+ needed some hacking of <a href=3D"http://configu=
re.ac" target=3D"_blank">configure.ac</a> (but that&#39;s not relevant for =
this patch).</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_=
extra">For XP+, it builds out of the box. When the resulting exe is run on =
windows 7 with --block-outside-dns, it prints the following warning</div><d=
iv class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">&quot;NOTE: b=
lock-outside-dns option works only on Windows&quot;</div><div class=3D"gmai=
l_extra"><br></div><div class=3D"gmail_extra">Apart from the confusing warn=
ing, I had expected the process to exit with unknown option error.</div><di=
v class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px=
;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1e=
x">+#if _WIN32_WINNT &gt;=3D 0x0600<br>+ =C2=A0 =C2=A0 =C2=A0options-&gt;bl=
ock_outside_dns =3D true;<br>+#else<br>+ =C2=A0 =C2=A0 =C2=A0msg (M_WARN, &=
quot;NOTE: block-outside-dns option works only on Windows&quot;);</blockquo=
te><div>=C2=A0</div><div class=3D"gmail_extra">This has to be something lik=
e =C2=A0&quot;... not supported in this version or build&quot; or some such=
..<br></div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"=
>In fact, that #else clause short-circuits the default error handling of un=
known/unsupported options. It may be best to omit it altogether and let the=
 final if-block handle the unknown option. Or at least use msglevel_fc in p=
lace of M_WARN so that it will exit if appropriate to do so.</div><div clas=
s=3D"gmail_extra"><br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,20=
4);border-left-style:solid;padding-left:1ex">+#endif=C2=A0</blockquote></di=
v><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva</di=
v><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">[*] v5 2.=
3 patch with the missing include &lt;initguid.h&gt; manually added.</div></=
div>

--001a114b2a5287ccde052574cd15--

