MIME-Version: 1.0
In-Reply-To: <0f2ce121-9076-810b-373c-fcc3357a2981@...2080...>
References: <20170807132301.22759-1-chipitsine@...277...>
 <20170807132301.22759-3-chipitsine@...277...>
 <a2e7511e-2416-cfbc-4b0f-5ffcf8f15e17@...2080...>
 <CAFHpkQHkXWR512UXjQiTFf78fOJE+9_xo6fpYvhm8xRS8y3Aqg@...278...>
 <0f2ce121-9076-810b-373c-fcc3357a2981@...2080...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 9 Aug 2017 10:55:38 +0500
Message-ID: <CAFHpkQFdg7Q-4ep9usyZ_6FyJGdWM0VYhRzghnMN5aerivWA9A@...278...>
Content-Type: multipart/alternative; boundary="f403045f502cbfd0fe05564bba10"
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

--f403045f502cbfd0fe05564bba10
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-08-08 23:44 GMT+05:00 David Sommerseth <
openvpn@...2080...>:

> On 07/08/17 20:25, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> [...]
> >     > +"${top_builddir}/src/openvpn/openvpn" --help >/dev/null
> >     > +
> >     > +if [ $? -ne 1 ]
> >     > +then
> >     > +   exit_code=3D1
> >     > +fi
> >
> >     This check is odd.  Where the --help option is parsed, it calls
> usage(),
> >     usage_small().  And those functions will always call:
> >
> > Sometimes it segfaults.
>
> That's no real argument, see below.
>


the one and only thing I wish to check here is whether functions reaches
"exit 1" or crashes before.


>
> >        openvpn_exit(OPENVPN_EXIT_STATUS_USAGE);
> >
> >     And OPENVPN_EXIT_STATUS_USAGE is defined as:
> >
> >     error.h:#define OPENVPN_EXIT_STATUS_USAGE                   1
> >
> >     I would rather recommend you to grep for some information you expect
> to
> >     be listed in --help and check if that was found instead.
> >
> >
> > I tried to implement it with cmocka. However, I gave up
>
> I didn't say this should be implemented in C and CMocka ... hence the
> example below.  And that check below would implicitly account for SEGV
> scenarios as well.
>

> >     For example:
> >
> >     $ ./openvpn --help | grep -- ^-- | wc -l
> >     238
>
> But to do the spoon feeding:
>
> optcount=3D"$(${top_builddir}/src/openvpn/openvpn --help | grep -E -- ^--=
 |
> wc -l)"
> if [ $outcount -lt 220 ];
> then
>         exit_code=3D1
> fi
>
>
if you suggest "that's a better check", please describe your idea.
it is not clear for me why your approach is better


>
> --
> kind regards,
>
> David Sommerseth
> OpenVPN Technologies, Inc
>
>
>

--f403045f502cbfd0fe05564bba10
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-08-08 23:44 GMT+05:00 David Sommerseth <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2080...</a>&g=
t;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">On 07/08/17 20:25, =D0=98=D0=
=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD wrote:<br>
[...]<br>
<span class=3D"">&gt;=C2=A0 =C2=A0 =C2=A0&gt; +&quot;${top_builddir}/src/op=
envpn/<wbr>openvpn&quot; --help &gt;/dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +if [ $? -ne 1 ]<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +then<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0exit_code=3D1<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +fi<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0This check is odd.=C2=A0 Where the --help option is=
 parsed, it calls usage(),<br>
&gt;=C2=A0 =C2=A0 =C2=A0usage_small().=C2=A0 And those functions will alway=
s call:<br>
&gt;<br>
&gt; Sometimes it segfaults.<br>
<br>
</span>That&#39;s no real argument, see below.<br></blockquote><div><br><br=
></div><div>the one and only thing I wish to check here is whether function=
s reaches &quot;exit 1&quot; or crashes before.<br></div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
<span class=3D""><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 openvpn_exit(OPENVPN_EXIT_<wbr>STATUS_USAGE=
);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0And OPENVPN_EXIT_STATUS_USAGE is defined as:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0error.h:#define OPENVPN_EXIT_STATUS_USAGE=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0I would rather recommend you to grep for some infor=
mation you expect to<br>
&gt;=C2=A0 =C2=A0 =C2=A0be listed in --help and check if that was found ins=
tead.<br>
&gt;<br>
&gt;<br>
&gt; I tried to implement it with cmocka. However, I gave up<br>
<br>
</span>I didn&#39;t say this should be implemented in C and CMocka ... henc=
e the<br>
example below.=C2=A0 And that check below would implicitly account for SEGV=
<br>
scenarios as well. <br></blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<span class=3D""><br>
&gt;=C2=A0 =C2=A0 =C2=A0For example:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0$ ./openvpn --help | grep -- ^-- | wc -l<br>
&gt;=C2=A0 =C2=A0 =C2=A0238<br>
<br>
</span>But to do the spoon feeding:<br>
<br>
optcount=3D&quot;$(${top_builddir}/<wbr>src/openvpn/openvpn --help | grep -=
E -- ^-- | wc -l)&quot;<br>
if [ $outcount -lt 220 ];<br>
then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit_code=3D1<br>
fi<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br></div></div></blockquote><div><=
br></div><div>if you suggest &quot;that&#39;s a better check&quot;, please =
describe your idea.<br></div><div>it is not clear for me why your approach =
is better<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div cla=
ss=3D"HOEnZb"><div class=3D"h5">
<br>
--<br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN Technologies, Inc<br>
<br>
<br>
</div></div></blockquote></div><br></div></div>

--f403045f502cbfd0fe05564bba10--

