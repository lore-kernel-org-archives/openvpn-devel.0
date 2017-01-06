MIME-Version: 1.0
In-Reply-To: <dec62c2a-7c92-bfcb-1949-48ae1eeadc44@...2080...>
References: <CAFHpkQEqEqu4Pcy4-KfhGqLYW26HR-ydCZO0xeU9YP5ZZUiL-Q@...278...>
	<dec62c2a-7c92-bfcb-1949-48ae1eeadc44@...2080...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 6 Jan 2017 19:06:47 +0300
Message-ID: <CAFHpkQFd2iuv56YkdyMHsVya86MpDemm45uVO+8eEt+uLie33A@...278...>
Content-Type: multipart/alternative; boundary=001a1148e7c2814a4205456f3499
Subject: Re: [Openvpn-devel] helping developers to collaborate properly
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1148e7c2814a4205456f3499
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-01-06 15:52 GMT+03:00 David Sommerseth <
openvpn@...2080...>:

> On 06/01/17 09:18, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> > Hello,
> >
> > https://github.com/OpenVPN/openvpn/pull/77
> >
> > I'm not sure about exact text (I need help from you),
> > the idea behind those changes is to point developers who use regular
> > github workflow to a proper procedures (maybe there're pages on wiki ?
> > @mattock  ?)
> >
> > it will help to not lose PRs and will probably save time of current
> > developers
>
> Two questions:
>
> 1) Can you explain what those .github/ files does?
>

those files are mark down templates for new PRs and new issues.
when someone open new PR, he sees such a template

https://github.com/blog/2111-issue-and-pull-request-templates


>
> 2) Can you please elaborate *how* this will save us developers time?
>

new developers will see guide how to use PRs and how to contribute. it will
save developers time to explain those things to every new developer who
followed github workflow (fork and PR)


>
> As we do have public reviews on a distributed channel (which is the
> mailing list [0]), I would dare to say we have a very efficient way of
> handling that process.
>
> - Patch(es) arrives the mailing list
> - Patch(es) gets reviewed, with feedback, and finally an ACK
> - Gert or I download the mail(s) in our mail program (including
>   headers, fairly simple with mutt or alpline, not even much
>   complicated in Thunderbird)
> - We run our 'git ack-am' [1] script which takes the mail file and the
>   a nick of the person(s) giving an ACK ... which generates the "PATCH
>   applied" mails automatically.
> - We push the git out the git trees.
>
> The GitHub PRs are actually not giving us developers much benefits.  For
> the review process of larger patches, it can have some benefits for a
> more smooth discussion on individual patch lines.  But once the patches
> are ready for final ACK, the mailing list approach is much more
> efficient for us, as we want to keep references to final discussions
> decentralized.
>
>
> [0] We don't trust that GitHub will be present forever and our
>     mailing lists are archived several places, where the Message-ID is
>     unique for each mail - regardless of mail archive hosting.
> [1] <https://gitlab.com/dazo/misc-git-tools/tree/master>
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

--001a1148e7c2814a4205456f3499
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-01-06 15:52 GMT+03:00 David Sommerseth <span dir=3D"ltr">&lt;<a ta=
rget=3D"_blank" href=3D"mailto:openvpn@...2080...">openvpn@...2080...</a>&g=
t;</span>:<br><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote"><span class=
=3D"gmail-">On 06/01/17 09:18, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD wrote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; <a target=3D"_blank" rel=3D"noreferrer" href=3D"https://github.com/Ope=
nVPN/openvpn/pull/77">https://github.com/OpenVPN/<wbr>openvpn/pull/77</a><b=
r>
&gt;<br>
&gt; I&#39;m not sure about exact text (I need help from you),<br>
&gt; the idea behind those changes is to point developers who use regular<b=
r>
&gt; github workflow to a proper procedures (maybe there&#39;re pages on wi=
ki ?<br>
&gt; @mattock=C2=A0 ?)<br>
&gt;<br>
&gt; it will help to not lose PRs and will probably save time of current<br>
&gt; developers<br>
<br>
</span>Two questions:<br>
<br>
1) Can you explain what those .github/ files does?<br></blockquote><div><br=
></div><div>those files are mark down templates for new PRs and new issues.=
<br></div><div>when someone open new PR, he sees such a template<br><br><a =
href=3D"https://github.com/blog/2111-issue-and-pull-request-templates">http=
s://github.com/blog/2111-issue-and-pull-request-templates</a><br></div><div=
>=C2=A0</div><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote">
<br>
2) Can you please elaborate *how* this will save us developers time?<br></b=
lockquote><div><br></div><div>new developers will see guide how to use PRs =
and how to contribute. it will save developers time to explain those things=
 to every new developer who followed github workflow (fork and PR)<br></div=
><div>=C2=A0</div><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote">
<br>
As we do have public reviews on a distributed channel (which is the<br>
mailing list [0]), I would dare to say we have a very efficient way of<br>
handling that process.<br>
<br>
- Patch(es) arrives the mailing list<br>
- Patch(es) gets reviewed, with feedback, and finally an ACK<br>
- Gert or I download the mail(s) in our mail program (including<br>
=C2=A0 headers, fairly simple with mutt or alpline, not even much<br>
=C2=A0 complicated in Thunderbird)<br>
- We run our &#39;git ack-am&#39; [1] script which takes the mail file and =
the<br>
=C2=A0 a nick of the person(s) giving an ACK ... which generates the &quot;=
PATCH<br>
=C2=A0 applied&quot; mails automatically.<br>
- We push the git out the git trees.<br>
<br>
The GitHub PRs are actually not giving us developers much benefits.=C2=A0 F=
or<br>
the review process of larger patches, it can have some benefits for a<br>
more smooth discussion on individual patch lines.=C2=A0 But once the patche=
s<br>
are ready for final ACK, the mailing list approach is much more<br>
efficient for us, as we want to keep references to final discussions<br>
decentralized.<br>
<br>
<br>
[0] We don&#39;t trust that GitHub will be present forever and our<br>
=C2=A0 =C2=A0 mailing lists are archived several places, where the Message-=
ID is<br>
=C2=A0 =C2=A0 unique for each mail - regardless of mail archive hosting.<br>
[1] &lt;<a target=3D"_blank" rel=3D"noreferrer" href=3D"https://gitlab.com/=
dazo/misc-git-tools/tree/master">https://gitlab.com/dazo/misc-<wbr>git-tool=
s/tree/master</a>&gt;<br>
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

--001a1148e7c2814a4205456f3499--

