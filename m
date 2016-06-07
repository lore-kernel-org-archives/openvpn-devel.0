MIME-Version: 1.0
In-Reply-To: <20160607141112.GX53051@...1296...>
References: <CAFHpkQF9s4JnDKHsomjo0ud72nwOXF7g_hLEiNreZ1ozTn4QLA@...278...>
	<20160607141112.GX53051@...1296...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 7 Jun 2016 21:01:01 +0500
Message-ID: <CAFHpkQF-0pScrXkfx_iOTRueQcC2_bDO6K6khx84sMtV0baJ_w@...278...>
Content-Type: multipart/alternative; boundary=001a114e35b0b428b90534b24b66
Subject: Re: [Openvpn-devel] potential segfault on strlen(NULL)
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

--001a114e35b0b428b90534b24b66
Content-Type: text/plain; charset=UTF-8

2016-06-07 19:11 GMT+05:00 Gert Doering <gert@...1296...>:

> Hi,
>
> On Tue, Jun 07, 2016 at 06:04:54PM +0500, ???????? ?????????????? wrote:
> > as I see, there's call to format_hex_ex with separator=NULL here:
>
> Interesting find.
>
> This code is funny - format_hex_ex() is called from various places with
> separator=NULL, and has been that way since at least 2005... it's part of
> the oldest commit we have in git.
>
> Now, that expression
>
>   struct buffer out = alloc_buf_gc (maxoutput ? maxoutput :
>                                     ((size * 2) + (size /
> (space_break_flags & F
> HE_SPACE_BREAK_MASK)) * (int) strlen (separator) + 2),
>                                     gc);
>
> will of course *only* call strlen(separator) if "maxoutput" is 0
> (C short-circuit evaluation of conditionals).  So if all callers respect
> that and *either* set "maxoutput > 0" *or* pass "separator != NULL", we're
> fine.
>
> The line 152 in ssl_openssl.c is passing in "len", which is not 0...
>
>          const char *key = format_hex_ex (ekm, size, len, 0, NULL, &gc);
>
> ... so there will not be a strlen() call.
>
>
> I wouldn't mind an ASSERT( maxoutput > 0 || separator != NULL ) call
> in format_hex_ex(), though.
>


ASSERT is more readable that ternary operator here. ok, I'll propose new
patch


>
> gert
>
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //
> www.muc.de/~gert/
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025
> gert@...1297...
>

--001a114e35b0b428b90534b24b66
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-06-07 19:11 GMT+05:00 Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On Tue, Jun 07, 2016 at 06:04:54PM +0500, ???????? ?????????????? wrote:<br>
&gt; as I see, there&#39;s call to format_hex_ex with separator=3DNULL here=
:<br>
<br>
</span>Interesting find.<br>
<br>
This code is funny - format_hex_ex() is called from various places with<br>
separator=3DNULL, and has been that way since at least 2005... it&#39;s par=
t of<br>
the oldest commit we have in git.<br>
<br>
Now, that expression<br>
<br>
=C2=A0 struct buffer out =3D alloc_buf_gc (maxoutput ? maxoutput :<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((size * 2) + (size / =
(space_break_flags &amp; F<br>
HE_SPACE_BREAK_MASK)) * (int) strlen (separator) + 2),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gc);<br>
<br>
will of course *only* call strlen(separator) if &quot;maxoutput&quot; is 0<=
br>
(C short-circuit evaluation of conditionals).=C2=A0 So if all callers respe=
ct<br>
that and *either* set &quot;maxoutput &gt; 0&quot; *or* pass &quot;separato=
r !=3D NULL&quot;, we&#39;re<br>
fine.<br>
<br>
The line 152 in ssl_openssl.c is passing in &quot;len&quot;, which is not 0=
...<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *key =3D format_hex_ex (ekm, s=
ize, len, 0, NULL, &amp;gc);<br>
<br>
... so there will not be a strlen() call.<br>
<br>
<br>
I wouldn&#39;t mind an ASSERT( maxoutput &gt; 0 || separator !=3D NULL ) ca=
ll<br>
in format_hex_ex(), though.<br></blockquote><div><br><br></div><div>ASSERT =
is more readable that ternary operator here. ok, I&#39;ll propose new patch=
<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
gert<br>
<br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//<a href=3D"=
http://www.muc.de/~gert/" rel=3D"noreferrer" target=3D"_blank">www.muc.de/~=
gert/</a><br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296...">gert@...1296...</a><br>
fax: +49-89-35655025=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:gert@...1297...">gert@...1826...=
7...</a><br>
</font></span></blockquote></div><br></div></div>

--001a114e35b0b428b90534b24b66--

