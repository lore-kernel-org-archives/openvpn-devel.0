MIME-Version: 1.0
In-Reply-To: <20170225143632.GZ12961@...2182...>
References: <20170225020229.17287-1-davids@...515...>
	<CAFHpkQHRADXhPuPXMtyM0_yj76O9_4vnUCd1CFYKZhdk5M+iTA@...278...>
	<40e4d3cd-68a8-8f0e-ce1e-c9d56400da6b@...2080...>
	<CAFHpkQEOCkqj0yHAH0gqJgmjpfSL-0ZgGLBPoeFnwoViY-sKow@...278...>
	<20170225143632.GZ12961@...2182...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sat, 25 Feb 2017 20:28:39 +0500
Message-ID: <CAFHpkQFQn7udsMz5Ux6QfKRZveUpwP2GN6xt46ri+_fy3ixhqw@...278...>
Content-Type: multipart/alternative; boundary=001a11469c5436a32505495c803a
Subject: Re: [Openvpn-devel] [PATCH] cleanup: Remove faulty env processing
	functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11469c5436a32505495c803a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-02-25 19:36 GMT+05:00 Antonio Quartulli <a@...2181...>:

> On Sat, Feb 25, 2017 at 06:45:36PM +0500, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=
=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD wrote:
> > 2017-02-25 16:49 GMT+05:00 David Sommerseth <
> > openvpn@...2080...>:
> >
> > > On 25/02/17 10:42, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=
=D1=86=D0=B8=D0=BD wrote:
> > > > there are two another unused functions in misc.c
> > > >
> > > > [src/openvpn/misc.c:661]: (style) The function 'env_set_print' is
> never
> > > > used.
> > >
> > > This one is useful for debugging purposes, so I let this one stay.  I
> > > did consider an #if 0 around it, to make it more explicit.  But I
> > > thought we have enough of those.  It could make some compiler warnings
> > > go away though disabling it.
> > >
> >
> >
> > it is good idea to put "#if 0" around debug items (that are not used
> > generally)
>
> Not sure if there is something similar in the code right now, but wouldn't
> be
> better to have this kind of code surrounded by some "#ifdef DEBUG" that
> can be
> enabled upon configuration ?
>

this might be surrounded with "#ifdef ENABLE_DEBUG":

[src/openvpn/otime.c:104]: (style) The function 'tv_string_abs' is never
used.

(and several more "never used" functions as well)

but for "[src/openvpn/error.c:824]: (error) Null pointer dereference", I'm
afraid we should guard it with "#if 0", otherwise static analyzer will
continue complain


> Cheers,
>
>
> --
> Antonio Quartulli
>

--001a11469c5436a32505495c803a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-02-25 19:36 GMT+05:00 Antonio Quartulli <span dir=3D"ltr">&lt;<a t=
arget=3D"_blank" href=3D"mailto:a@...2181...">a@...2181...</a>&gt;</span>:<=
br><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(=
204,204,204);padding-left:1ex" class=3D"gmail_quote"><span class=3D"gmail-"=
>On Sat, Feb 25, 2017 at 06:45:36PM +0500, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=
=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD wrote:<br>
&gt; 2017-02-25 16:49 GMT+05:00 David Sommerseth &lt;<br>
&gt; <a href=3D"mailto:openvpn@...2080...">openvpn@...2252...<wbr>net</a>&g=
t;:<br>
&gt;<br>
&gt; &gt; On 25/02/17 10:42, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD wrote:<br>
&gt; &gt; &gt; there are two another unused functions in misc.c<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; [src/openvpn/misc.c:661]: (style) The function &#39;env_set_=
print&#39; is never<br>
&gt; &gt; &gt; used.<br>
&gt; &gt;<br>
&gt; &gt; This one is useful for debugging purposes, so I let this one stay=
.=C2=A0 I<br>
&gt; &gt; did consider an #if 0 around it, to make it more explicit.=C2=A0 =
But I<br>
&gt; &gt; thought we have enough of those.=C2=A0 It could make some compile=
r warnings<br>
&gt; &gt; go away though disabling it.<br>
&gt; &gt;<br>
&gt;<br>
&gt;<br>
&gt; it is good idea to put &quot;#if 0&quot; around debug items (that are =
not used<br>
&gt; generally)<br>
<br>
</span>Not sure if there is something similar in the code right now, but wo=
uldn&#39;t be<br>
better to have this kind of code surrounded by some &quot;#ifdef DEBUG&quot=
; that can be<br>
enabled upon configuration ?<br></blockquote><div><br></div><div>this might=
 be surrounded with &quot;#ifdef ENABLE_DEBUG&quot;:<br></div><div><br>[src=
/openvpn/otime.c:104]: (style) The function &#39;tv_string_abs&#39; is neve=
r used.<br>=C2=A0<br></div><div>(and several more &quot;never used&quot; fu=
nctions as well)<br></div><div><br></div><div>but for &quot;[src/openvpn/er=
ror.c:824]: (error) Null pointer dereference&quot;, I&#39;m afraid we shoul=
d guard it with &quot;#if 0&quot;, otherwise static analyzer will continue =
complain<br></div><div><br></div><blockquote style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex" class=3D"gmail=
_quote">
<br>
Cheers,<br>
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
Antonio Quartulli<br>
</font></span></blockquote></div><br></div></div>

--001a11469c5436a32505495c803a--

