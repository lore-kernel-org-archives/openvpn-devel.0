MIME-Version: 1.0
In-Reply-To: <20170315152840.GR93896@...1296...>
References: <CAFHpkQGseLH-+NFRxgrF7KNdZ8Fc4A4HQGBOTEktwABW9ZALTw@...278...>
	<20170315152840.GR93896@...1296...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 15 Mar 2017 20:37:12 +0500
Message-ID: <CAFHpkQGKV3pAeTjabYbyP4LwwDqUa7Atuuqh0qyQ95DTdL39dA@...278...>
Content-Type: multipart/alternative; boundary=001a11469faaf04d69054ac6b755
Subject: Re: [Openvpn-devel] why "ifconfig" is required during build ?
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

--001a11469faaf04d69054ac6b755
Content-Type: text/plain; charset=UTF-8

2017-03-15 20:28 GMT+05:00 Gert Doering <gert@...1296...>:

> Hi,
>
> On Wed, Mar 15, 2017 at 08:15:08PM +0500, ???????? ?????????????? wrote:
> > I'm playing with AppVeyor, and I figured out that I have no idea why does
> > "ifconfig" is checked during build process:
> >
> > [ilia@...23... openvpn]$ grep ifconfig configure.ac
> > AC_PATH_PROGS([IFCONFIG], [ifconfig],,
> > [$PATH:/usr/local/sbin:/usr/sbin:/sbin])
> > AC_DEFINE_UNQUOTED([IFCONFIG_PATH], ["$IFCONFIG"], [Path to ifconfig
> tool])
> >         test -z "${IFCONFIG}" && AC_MSG_ERROR([ifconfig utility is
> required
> > but missing])
> > [ilia@...23... openvpn]$
> >
> >
> > well, it makes sense that it might be required for running openvpn. but
> why
> > to check it during build ?
>
> To find the path that we're going to call the binary with.  We do not
> rely on $PATH resolution at runtime.
>

well, what if I will not change current (i.e. default behaviour), but
instead I will add a possibility to specify ifconfig explicitly ?


>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //
> www.muc.de/~gert/ <http://www.muc.de/%7Egert/>
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025                        gert@...1816...
> muenchen.de
>

--001a11469faaf04d69054ac6b755
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-03-15 20:28 GMT+05:00 Gert Doering <span dir=3D"ltr">&lt;<a target=
=3D"_blank" href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt;</span>:=
<br><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb=
(204,204,204);padding-left:1ex" class=3D"gmail_quote">Hi,<br>
<span class=3D"gmail-"><br>
On Wed, Mar 15, 2017 at 08:15:08PM +0500, ???????? ?????????????? wrote:<br>
&gt; I&#39;m playing with AppVeyor, and I figured out that I have no idea w=
hy does<br>
&gt; &quot;ifconfig&quot; is checked during build process:<br>
&gt;<br>
&gt; [ilia@...23... openvpn]$ grep ifconfig <a target=3D"_blank" rel=3D"nor=
eferrer" href=3D"http://configure.ac">configure.ac</a><br>
&gt; AC_PATH_PROGS([IFCONFIG], [ifconfig],,<br>
&gt; [$PATH:/usr/local/sbin:/usr/<wbr>sbin:/sbin])<br>
&gt; AC_DEFINE_UNQUOTED([IFCONFIG_<wbr>PATH], [&quot;$IFCONFIG&quot;], [Pat=
h to ifconfig tool])<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test -z &quot;${IFCONFIG}&quot; &amp;=
&amp; AC_MSG_ERROR([ifconfig utility is required<br>
&gt; but missing])<br>
&gt; [ilia@...23... openvpn]$<br>
&gt;<br>
&gt;<br>
&gt; well, it makes sense that it might be required for running openvpn. bu=
t why<br>
&gt; to check it during build ?<br>
<br>
</span>To find the path that we&#39;re going to call the binary with.=C2=A0=
 We do not<br>
rely on $PATH resolution at runtime.<br></blockquote><div><br></div><div>we=
ll, what if I will not change current (i.e. default behaviour), but instead=
 I will add a possibility to specify ifconfig explicitly ?<br></div><div>=
=C2=A0</div><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote">
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br>
gert<br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//<a target=
=3D"_blank" rel=3D"noreferrer" href=3D"http://www.muc.de/%7Egert/">www.muc.=
de/~gert/</a><br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296...">gert@...1296...</a><br>
fax: +49-89-35655025=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:gert@...1297...">gert@...2165...=
6...<wbr>muenchen.de</a><br>
</font></span></blockquote></div><br></div></div>

--001a11469faaf04d69054ac6b755--

