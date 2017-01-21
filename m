MIME-Version: 1.0
In-Reply-To: <ac93d2de-d56a-0ff9-b97a-a590923f5cf8@...2080...>
References: <1484297432-14435-1-git-send-email-chipitsine@...277...>
	<7dc75a19-451e-effa-503a-ac5b75a23bab@...515...>
	<ac93d2de-d56a-0ff9-b97a-a590923f5cf8@...2080...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sat, 21 Jan 2017 13:47:38 +0500
Message-ID: <CAFHpkQEHRCveRiiBWscwLQ7U3UoJ+yY5_0Lx82UMc=f4ucwMbQ@...278...>
Content-Type: multipart/alternative; boundary=001a1148e7c299303e054696d18d
Subject: Re: [Openvpn-devel] [PATCH] add PR template in order to simplify
 new developers cooperate properly if they open PR. discussed here:
 https://sourceforge.net/p/openvpn/mailman/message/35601310/
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1148e7c299303e054696d18d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-01-21 0:24 GMT+05:00 David Sommerseth <
openvpn@...2080...>:

> On 13/01/17 10:05, Samuli Sepp=C3=A4nen wrote:
> > Il 13/01/2017 10:50, Ilya Shipitsin ha scritto:
> >> ---
> >>  .github/PULL_REQUEST_TEMPLATE.md | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>  create mode 100644 .github/PULL_REQUEST_TEMPLATE.md
> >>
> >> diff --git a/.github/PULL_REQUEST_TEMPLATE.md b/.github/PULL_REQUEST_
> TEMPLATE.md
> >> new file mode 100644
> >> index 0000000..d0cfd7f
> >> --- /dev/null
> >> +++ b/.github/PULL_REQUEST_TEMPLATE.md
> >> @@ -0,0 +1,8 @@
> >> +# Thank you for your contribution
> >> +
> >> +You are welcome to open PR, but they are used for discussion only. All
> >> +patches must eventually go to the openvpn-devel mailing list for
> review.
> >> +For details, see these Wiki articles:
> >> +
> >> +* https://community.openvpn.net/openvpn/wiki/Contributing
> >> +* https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation
> >>
> >
> > Based on testing in the travis-openssl-test repository the template
> > works as intended, so ACK on that part.
> >
> > Any comments on the text itself?
>
> How does this work with branches?  Do we need to say that new patches
> should go into the master branch primarily, unless it is fixing a bug or
> another issue which is only relevant for specific release branches?
>


we can put such information to

https://community.openvpn.net/openvpn/wiki/Contributing
https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation


I would leave PR template skinny


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

--001a1148e7c299303e054696d18d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-01-21 0:24 GMT+05:00 David Sommerseth <span dir=3D"ltr">&lt;<a tar=
get=3D"_blank" href=3D"mailto:openvpn@...2080...">openvpn@...2080...</a>&gt=
;</span>:<br><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote"><span class=
=3D"gmail-">On 13/01/17 10:05, Samuli Sepp=C3=A4nen wrote:<br>
&gt; Il 13/01/2017 10:50, Ilya Shipitsin ha scritto:<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 .github/PULL_REQUEST_TEMPLATE.<wbr>md | 8 ++++++++<br>
&gt;&gt;=C2=A0 1 file changed, 8 insertions(+)<br>
&gt;&gt;=C2=A0 create mode 100644 .github/PULL_REQUEST_TEMPLATE.<wbr>md<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/.github/PULL_REQUEST_<wbr>TEMPLATE.md b/.github/PULL_=
REQUEST_<wbr>TEMPLATE.md<br>
&gt;&gt; new file mode 100644<br>
&gt;&gt; index 0000000..d0cfd7f<br>
&gt;&gt; --- /dev/null<br>
&gt;&gt; +++ b/.github/PULL_REQUEST_<wbr>TEMPLATE.md<br>
&gt;&gt; @@ -0,0 +1,8 @@<br>
&gt;&gt; +# Thank you for your contribution<br>
&gt;&gt; +<br>
&gt;&gt; +You are welcome to open PR, but they are used for discussion only=
. All<br>
&gt;&gt; +patches must eventually go to the openvpn-devel mailing list for =
review.<br>
&gt;&gt; +For details, see these Wiki articles:<br>
&gt;&gt; +<br>
&gt;&gt; +* <a target=3D"_blank" rel=3D"noreferrer" href=3D"https://communi=
ty.openvpn.net/openvpn/wiki/Contributing">https://community.openvpn.net/<wb=
r>openvpn/wiki/Contributing</a><br>
&gt;&gt; +* <a target=3D"_blank" rel=3D"noreferrer" href=3D"https://communi=
ty.openvpn.net/openvpn/wiki/DeveloperDocumentation">https://community.openv=
pn.net/<wbr>openvpn/wiki/<wbr>DeveloperDocumentation</a><br>
&gt;&gt;<br>
&gt;<br>
&gt; Based on testing in the travis-openssl-test repository the template<br>
&gt; works as intended, so ACK on that part.<br>
&gt;<br>
&gt; Any comments on the text itself?<br>
<br>
</span>How does this work with branches?=C2=A0 Do we need to say that new p=
atches<br>
should go into the master branch primarily, unless it is fixing a bug or<br>
another issue which is only relevant for specific release branches?<br></bl=
ockquote><div><br><br></div><div>we can put such information to<br><br><spa=
n class=3D"gmail-im"><a target=3D"_blank" rel=3D"noreferrer" href=3D"https:=
//community.openvpn.net/openvpn/wiki/Contributing">https://community.openvp=
n.net/<wbr>openvpn/wiki/Contributing</a><br><a target=3D"_blank" rel=3D"nor=
eferrer" href=3D"https://community.openvpn.net/openvpn/wiki/DeveloperDocume=
ntation">https://community.openvpn.net/<wbr>openvpn/wiki/<wbr>DeveloperDocu=
mentation</a><br><br><br></span></div><div><span class=3D"gmail-im">I would=
 leave PR template skinny<br></span></div><div>=C2=A0</div><blockquote styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex" class=3D"gmail_quote">
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN Technologies, Inc<br>
<br>
<br>
</font></span></blockquote></div><br></div></div>

--001a1148e7c299303e054696d18d--

