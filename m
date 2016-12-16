MIME-Version: 1.0
In-Reply-To: <f5ca3f0f-dd01-e82e-b339-68f5791e0928@...1435...>
References: <20161216163218.25449-1-jm@...1926...>
	<34dd18d1-a2fb-7e89-7a19-43603f0491ba@...1926...>
	<f5ca3f0f-dd01-e82e-b339-68f5791e0928@...1435...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 16 Dec 2016 22:18:00 +0500
Message-ID: <CAFHpkQEqybC9SEihZshuh5EzOZYbRMyceX8gGG75Yq4ipf2g-Q@...278...>
Content-Type: multipart/alternative; boundary=001a114b7e0c8b30ae0543c9c07c
Subject: Re: [Openvpn-devel] What about adding -Werror=implicit
 -Werror=format -Werror=format-security ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114b7e0c8b30ae0543c9c07c
Content-Type: text/plain; charset=UTF-8

2016-12-16 22:06 GMT+05:00 Steffan Karger <steffan.karger@...1435...>:

> On 16-12-16 17:42, Julien Muchembled wrote:
> > To avoid issues like https://community.openvpn.net/openvpn/ticket/792
> to happen again, I wanted to also submit a patch that adds a few -Werror=
> flags. However, I wonder what would be your preferred way to only add flags
> that are supported by the compiler.
>


is it supported for clang ?


> >
> > One solution is with
> >   https://www.gnu.org/software/autoconf-archive/ax_check_
> compile_flag.html
> > which means:
> > - copy ax_check_compile_flag.m4 from the autoconf archive to the openvpn
> repository
> > - include it in configure.ac
> > - and for example:
> >
> > AX_CHECK_COMPILE_FLAG([ -Werror=implicit ], [
> >     CFLAGS_EXTRA="$CFLAGS_EXTRA -Werror=implicit"
> > ])
>
> Yes, please!
>
> You can put the macro in m4/
>
> -Steffan
>
>
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--001a114b7e0c8b30ae0543c9c07c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-12-16 22:06 GMT+05:00 Steffan Karger <span dir=3D"ltr">&lt;<a href=
=3D"mailto:steffan.karger@...1435..." target=3D"_blank">steffan.karger@...1386...=
435...</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">O=
n 16-12-16 17:42, Julien Muchembled wrote:<br>
&gt; To avoid issues like <a href=3D"https://community.openvpn.net/openvpn/=
ticket/792" rel=3D"noreferrer" target=3D"_blank">https://community.openvpn.=
net/<wbr>openvpn/ticket/792</a> to happen again, I wanted to also submit a =
patch that adds a few -Werror=3D flags. However, I wonder what would be you=
r preferred way to only add flags that are supported by the compiler.<br></=
span></blockquote><div><br><br></div><div>is it supported for clang ?<br></=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">
&gt;<br>
&gt; One solution is with<br>
&gt;=C2=A0 =C2=A0<a href=3D"https://www.gnu.org/software/autoconf-archive/a=
x_check_compile_flag.html" rel=3D"noreferrer" target=3D"_blank">https://www=
.gnu.org/software/<wbr>autoconf-archive/ax_check_<wbr>compile_flag.html</a>=
<br>
&gt; which means:<br>
&gt; - copy ax_check_compile_flag.m4 from the autoconf archive to the openv=
pn repository<br>
&gt; - include it in <a href=3D"http://configure.ac" rel=3D"noreferrer" tar=
get=3D"_blank">configure.ac</a><br>
&gt; - and for example:<br>
&gt;<br>
&gt; AX_CHECK_COMPILE_FLAG([ -Werror=3Dimplicit ], [<br>
&gt;=C2=A0 =C2=A0 =C2=A0CFLAGS_EXTRA=3D&quot;$CFLAGS_EXTRA -Werror=3Dimplic=
it&quot;<br>
&gt; ])<br>
<br>
</span>Yes, please!<br>
<br>
You can put the macro in m4/<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
-Steffan<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, SlashDot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</div></div></blockquote></div><br></div></div>

--001a114b7e0c8b30ae0543c9c07c--

