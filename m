MIME-Version: 1.0
In-Reply-To: <d4f5b393-ee52-9a84-ed96-e8b5e16f47f4@...2080...>
References: <20170807132301.22759-1-chipitsine@...277...>
 <20170807132301.22759-3-chipitsine@...277...>
 <a2e7511e-2416-cfbc-4b0f-5ffcf8f15e17@...2080...>
 <CAFHpkQHkXWR512UXjQiTFf78fOJE+9_xo6fpYvhm8xRS8y3Aqg@...278...>
 <0f2ce121-9076-810b-373c-fcc3357a2981@...2080...>
 <CAFHpkQFdg7Q-4ep9usyZ_6FyJGdWM0VYhRzghnMN5aerivWA9A@...278...>
 <d4f5b393-ee52-9a84-ed96-e8b5e16f47f4@...2080...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 9 Aug 2017 15:28:51 +0500
Message-ID: <CAFHpkQFFPVGOFr=F-5zTFUqgEjfEv1xyLEs95j5KihyyC6AKmA@...278...>
Content-Type: multipart/alternative; boundary="001a114982c6db8ebd05564f8bc1"
Subject: Re: [Openvpn-devel] [PATCH 3/3] add a test to "openvpn --help"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114982c6db8ebd05564f8bc1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-08-09 14:31 GMT+05:00 David Sommerseth <
openvpn@...2080...>:

> On 09/08/17 07:55, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> [...]
> >     >     For example:
> >     >
> >     >     $ ./openvpn --help | grep -- ^-- | wc -l
> >     >     238
> >
> >     But to do the spoon feeding:
> >
> >     optcount=3D"$(${top_builddir}/src/openvpn/openvpn --help | grep -E =
--
> >     ^-- | wc -l)"
> >     if [ $outcount -lt 220 ];
> >     then
> >             exit_code=3D1
> >     fi
> >
> >
> > if you suggest "that's a better check", please describe your idea.
> > it is not clear for me why your approach is better
>
>
> The approach I suggest above covers:
>
> a)  The program is able to execute and usage() works
>
> b)  There is no unexpected bigger changes in usage(), the
>     number of options are within a reasonable threshold.
>     Granted, only minimum options is checked in the example above;
>     extending with an upper limit is easy and quick (for example
>     add '-o -gt 245')
>
> c) If the program segfaults, optcount =3D> 0 which ensures this test
>    fails.
>
> With your check only testing if the exit code is not 1, you only have an
> indication if the program segfaults or not.  You don't know if usage()
> provides nothing but garbage and then exiting with 1.  Checking that a
> certain amount of outputted lines starting with '--' gives an indication
> that usage() most likely have a reasonable output.
>
> It would also be possible to build further on this check I suggest, to
> also check for mandatory options (--dev, --dev-type, --remote, --listen,
> --port, --proto, etc, etc).  It is also possible to have a copy of the
> expected "openvpn --help | grep -E -- ^--" output and do a diff -
> probably filter out some less important/deprecated options).   While
> these are a nice checks too, it is not as crucial as ensuring we have at
> least an reasonable expected amount of options.
>


I'm afraid that that approach introduce implicit things (while my is pretty
explicit).
Value seems questionable for me.


>
>
> --
> kind regards,
>
> David Sommerseth
> OpenVPN Technologies, Inc
>
>
>

--001a114982c6db8ebd05564f8bc1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-08-09 14:31 GMT+05:00 David Sommerseth <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2080...</a>&g=
t;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">On 09/08/17 07:55, =D0=98=D0=
=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD wrote:<br>
[...]<br>
<span class=3D"">&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0For exampl=
e:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0$ ./openvpn --help | grep -=
- ^-- | wc -l<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0238<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0But to do the spoon feeding:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0optcount=3D&quot;$(${top_builddir}/<wbr>src/openvpn=
/openvpn --help | grep -E --<br>
&gt;=C2=A0 =C2=A0 =C2=A0^-- | wc -l)&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0if [ $outcount -lt 220 ];<br>
&gt;=C2=A0 =C2=A0 =C2=A0then<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit_code=3D1<br>
&gt;=C2=A0 =C2=A0 =C2=A0fi<br>
&gt;<br>
&gt;<br>
&gt; if you suggest &quot;that&#39;s a better check&quot;, please describe =
your idea.<br>
&gt; it is not clear for me why your approach is better<br>
<br>
<br>
</span>The approach I suggest above covers:<br>
<br>
a)=C2=A0 The program is able to execute and usage() works<br>
<br>
b)=C2=A0 There is no unexpected bigger changes in usage(), the<br>
=C2=A0 =C2=A0 number of options are within a reasonable threshold.<br>
=C2=A0 =C2=A0 Granted, only minimum options is checked in the example above=
;<br>
=C2=A0 =C2=A0 extending with an upper limit is easy and quick (for example<=
br>
=C2=A0 =C2=A0 add &#39;-o -gt 245&#39;)<br>
<br>
c) If the program segfaults, optcount =3D&gt; 0 which ensures this test<br>
=C2=A0 =C2=A0fails.<br>
<br>
With your check only testing if the exit code is not 1, you only have an<br>
indication if the program segfaults or not.=C2=A0 You don&#39;t know if usa=
ge()<br>
provides nothing but garbage and then exiting with 1.=C2=A0 Checking that a=
<br>
certain amount of outputted lines starting with &#39;--&#39; gives an indic=
ation<br>
that usage() most likely have a reasonable output.<br>
<br>
It would also be possible to build further on this check I suggest, to<br>
also check for mandatory options (--dev, --dev-type, --remote, --listen,<br>
--port, --proto, etc, etc).=C2=A0 It is also possible to have a copy of the=
<br>
expected &quot;openvpn --help | grep -E -- ^--&quot; output and do a diff -=
<br>
probably filter out some less important/deprecated options).=C2=A0 =C2=A0Wh=
ile<br>
these are a nice checks too, it is not as crucial as ensuring we have at<br>
least an reasonable expected amount of options.<br></blockquote><div><br><b=
r></div><div>I&#39;m afraid that that approach introduce implicit things (w=
hile my is pretty explicit).<br></div><div>Value seems questionable for me.=
<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
--<br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN Technologies, Inc<br>
<br>
<br>
</div></div></blockquote></div><br></div></div>

--001a114982c6db8ebd05564f8bc1--

