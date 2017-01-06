MIME-Version: 1.0
References: <CAFHpkQEqEqu4Pcy4-KfhGqLYW26HR-ydCZO0xeU9YP5ZZUiL-Q@...278...>
	<dec62c2a-7c92-bfcb-1949-48ae1eeadc44@...2080...>
	<CAFHpkQFd2iuv56YkdyMHsVya86MpDemm45uVO+8eEt+uLie33A@...278...>
In-Reply-To: <CAFHpkQFd2iuv56YkdyMHsVya86MpDemm45uVO+8eEt+uLie33A@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 06 Jan 2017 16:49:55 +0000
Message-ID: <CAFHpkQEtJU5hoExJhQuMV1ha5ELVsa1ThEqHsakOAj-ALNbSPQ@...278...>
Content-Type: multipart/alternative; boundary=001a114b7e0c56685105456fcfc5
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

--001a114b7e0c56685105456fcfc5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

it seems that Contributing.md should go to .github as well, @mattock?

=D0=9F=D1=82, 6 =D1=8F=D0=BD=D0=B2. 2017 =D0=B3. =D0=B2 21:06, =D0=98=D0=BB=
=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...1354...=
..>:

> 2017-01-06 15:52 GMT+03:00 David Sommerseth <
> openvpn@...2080...>:
>
> On 06/01/17 09:18, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
>
>
> > Hello,
>
>
> >
>
>
> > https://github.com/OpenVPN/openvpn/pull/77
>
>
> >
>
>
> > I'm not sure about exact text (I need help from you),
>
>
> > the idea behind those changes is to point developers who use regular
>
>
> > github workflow to a proper procedures (maybe there're pages on wiki ?
>
>
> > @mattock  ?)
>
>
> >
>
>
> > it will help to not lose PRs and will probably save time of current
>
>
> > developers
>
>
>
>
>
> Two questions:
>
>
>
>
>
> 1) Can you explain what those .github/ files does?
>
>
> those files are mark down templates for new PRs and new issues.
> when someone open new PR, he sees such a template
>
> https://github.com/blog/2111-issue-and-pull-request-templates
>
>
>
>
>
>
>
> 2) Can you please elaborate *how* this will save us developers time?
>
>
> new developers will see guide how to use PRs and how to contribute. it
> will save developers time to explain those things to every new developer
> who followed github workflow (fork and PR)
>
>
>
>
>
>
>
> As we do have public reviews on a distributed channel (which is the
>
>
> mailing list [0]), I would dare to say we have a very efficient way of
>
>
> handling that process.
>
>
>
>
>
> - Patch(es) arrives the mailing list
>
>
> - Patch(es) gets reviewed, with feedback, and finally an ACK
>
>
> - Gert or I download the mail(s) in our mail program (including
>
>
>   headers, fairly simple with mutt or alpline, not even much
>
>
>   complicated in Thunderbird)
>
>
> - We run our 'git ack-am' [1] script which takes the mail file and the
>
>
>   a nick of the person(s) giving an ACK ... which generates the "PATCH
>
>
>   applied" mails automatically.
>
>
> - We push the git out the git trees.
>
>
>
>
>
> The GitHub PRs are actually not giving us developers much benefits.  For
>
>
> the review process of larger patches, it can have some benefits for a
>
>
> more smooth discussion on individual patch lines.  But once the patches
>
>
> are ready for final ACK, the mailing list approach is much more
>
>
> efficient for us, as we want to keep references to final discussions
>
>
> decentralized.
>
>
>
>
>
>
>
>
> [0] We don't trust that GitHub will be present forever and our
>
>
>     mailing lists are archived several places, where the Message-ID is
>
>
>     unique for each mail - regardless of mail archive hosting.
>
>
> [1] <https://gitlab.com/dazo/misc-git-tools/tree/master>
>
>
>
>
>
>
>
>
> --
>
>
> kind regards,
>
>
>
>
>
> David Sommerseth
>
>
> OpenVPN Technologies, Inc
>
>
>
>
>
>
>
>
>

--001a114b7e0c56685105456fcfc5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div>it seems that Contributing.md should go to .github as well, @mattock?<=
/div><div><br><div class=3D"gmail_quote"><div>=D0=9F=D1=82, 6 =D1=8F=D0=BD=
=D0=B2. 2017 =D0=B3. =D0=B2 21:06, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD &lt;<a href=3D"mailto:chipitsine@...277...">chi=
pitsine@...277...</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div cla=
ss=3D"gmail_msg"><div class=3D"gmail_extra gmail_msg"><div class=3D"gmail_q=
uote gmail_msg">2017-01-06 15:52 GMT+03:00 David Sommerseth <span class=3D"=
gmail_msg">&lt;<a href=3D"mailto:openvpn@...2080..." class=3D"gmail_msg" ta=
rget=3D"_blank">openvpn@...2080...</a>&gt;</span>:<br class=3D"gmail_msg"><=
blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex" class=3D"gmail_quote gmail_msg"><span class=3D"m=
_3645007669701513543gmail- gmail_msg">On 06/01/17 09:18, =D0=98=D0=BB=D1=8C=
=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD wrote:<br class=3D"gmail_=
msg"><br><br>&gt; Hello,<br class=3D"gmail_msg"><br><br>&gt;<br class=3D"gm=
ail_msg"><br><br>&gt; <a rel=3D"noreferrer" href=3D"https://github.com/Open=
VPN/openvpn/pull/77" class=3D"gmail_msg" target=3D"_blank">https://github.c=
om/OpenVPN/openvpn/pull/77</a><br class=3D"gmail_msg"><br><br>&gt;<br class=
=3D"gmail_msg"><br><br>&gt; I&#39;m not sure about exact text (I need help =
from you),<br class=3D"gmail_msg"><br><br>&gt; the idea behind those change=
s is to point developers who use regular<br class=3D"gmail_msg"><br><br>&gt=
; github workflow to a proper procedures (maybe there&#39;re pages on wiki =
?<br class=3D"gmail_msg"><br><br>&gt; @mattock=C2=A0 ?)<br class=3D"gmail_m=
sg"><br><br>&gt;<br class=3D"gmail_msg"><br><br>&gt; it will help to not lo=
se PRs and will probably save time of current<br class=3D"gmail_msg"><br><b=
r>&gt; developers<br class=3D"gmail_msg"><br><br><br class=3D"gmail_msg"><b=
r><br></span>Two questions:<br class=3D"gmail_msg"><br><br><br class=3D"gma=
il_msg"><br><br>1) Can you explain what those .github/ files does?<br class=
=3D"gmail_msg"></blockquote><div class=3D"gmail_msg"><br class=3D"gmail_msg=
"></div></div></div></div><div class=3D"gmail_msg"><div class=3D"gmail_extr=
a gmail_msg"><div class=3D"gmail_quote gmail_msg"><div class=3D"gmail_msg">=
those files are mark down templates for new PRs and new issues.<br class=3D=
"gmail_msg"></div><div class=3D"gmail_msg">when someone open new PR, he see=
s such a template<br class=3D"gmail_msg"><br class=3D"gmail_msg"><a href=3D=
"https://github.com/blog/2111-issue-and-pull-request-templates" class=3D"gm=
ail_msg" target=3D"_blank">https://github.com/blog/2111-issue-and-pull-requ=
est-templates</a><br class=3D"gmail_msg"></div></div></div></div><div class=
=3D"gmail_msg"><div class=3D"gmail_extra gmail_msg"><div class=3D"gmail_quo=
te gmail_msg"><div class=3D"gmail_msg">=C2=A0</div><blockquote style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex" class=3D"gmail_quote gmail_msg"><br><br><br class=3D"gmail_msg"><br><br=
>2) Can you please elaborate *how* this will save us developers time?<br cl=
ass=3D"gmail_msg"></blockquote><div class=3D"gmail_msg"><br class=3D"gmail_=
msg"></div></div></div></div><div class=3D"gmail_msg"><div class=3D"gmail_e=
xtra gmail_msg"><div class=3D"gmail_quote gmail_msg"><div class=3D"gmail_ms=
g">new developers will see guide how to use PRs and how to contribute. it w=
ill save developers time to explain those things to every new developer who=
 followed github workflow (fork and PR)<br class=3D"gmail_msg"></div></div>=
</div></div><div class=3D"gmail_msg"><div class=3D"gmail_extra gmail_msg"><=
div class=3D"gmail_quote gmail_msg"><div class=3D"gmail_msg">=C2=A0</div><b=
lockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex" class=3D"gmail_quote gmail_msg"><br><br><br class=
=3D"gmail_msg"><br><br>As we do have public reviews on a distributed channe=
l (which is the<br class=3D"gmail_msg"><br><br>mailing list [0]), I would d=
are to say we have a very efficient way of<br class=3D"gmail_msg"><br><br>h=
andling that process.<br class=3D"gmail_msg"><br><br><br class=3D"gmail_msg=
"><br><br>- Patch(es) arrives the mailing list<br class=3D"gmail_msg"><br><=
br>- Patch(es) gets reviewed, with feedback, and finally an ACK<br class=3D=
"gmail_msg"><br><br>- Gert or I download the mail(s) in our mail program (i=
ncluding<br class=3D"gmail_msg"><br><br>=C2=A0 headers, fairly simple with =
mutt or alpline, not even much<br class=3D"gmail_msg"><br><br>=C2=A0 compli=
cated in Thunderbird)<br class=3D"gmail_msg"><br><br>- We run our &#39;git =
ack-am&#39; [1] script which takes the mail file and the<br class=3D"gmail_=
msg"><br><br>=C2=A0 a nick of the person(s) giving an ACK ... which generat=
es the &quot;PATCH<br class=3D"gmail_msg"><br><br>=C2=A0 applied&quot; mail=
s automatically.<br class=3D"gmail_msg"><br><br>- We push the git out the g=
it trees.<br class=3D"gmail_msg"><br><br><br class=3D"gmail_msg"><br><br>Th=
e GitHub PRs are actually not giving us developers much benefits.=C2=A0 For=
<br class=3D"gmail_msg"><br><br>the review process of larger patches, it ca=
n have some benefits for a<br class=3D"gmail_msg"><br><br>more smooth discu=
ssion on individual patch lines.=C2=A0 But once the patches<br class=3D"gma=
il_msg"><br><br>are ready for final ACK, the mailing list approach is much =
more<br class=3D"gmail_msg"><br><br>efficient for us, as we want to keep re=
ferences to final discussions<br class=3D"gmail_msg"><br><br>decentralized.=
<br class=3D"gmail_msg"><br><br><br class=3D"gmail_msg"><br><br><br class=
=3D"gmail_msg"><br><br>[0] We don&#39;t trust that GitHub will be present f=
orever and our<br class=3D"gmail_msg"><br><br>=C2=A0 =C2=A0 mailing lists a=
re archived several places, where the Message-ID is<br class=3D"gmail_msg">=
<br><br>=C2=A0 =C2=A0 unique for each mail - regardless of mail archive hos=
ting.<br class=3D"gmail_msg"><br><br>[1] &lt;<a rel=3D"noreferrer" href=3D"=
https://gitlab.com/dazo/misc-git-tools/tree/master" class=3D"gmail_msg" tar=
get=3D"_blank">https://gitlab.com/dazo/misc-git-tools/tree/master</a>&gt;<b=
r class=3D"gmail_msg"><br><br><span class=3D"m_3645007669701513543gmail-HOE=
nZb gmail_msg"><font color=3D"#888888" class=3D"gmail_msg"><br class=3D"gma=
il_msg"><br><br><br class=3D"gmail_msg"><br><br>--<br class=3D"gmail_msg"><=
br><br>kind regards,<br class=3D"gmail_msg"><br><br><br class=3D"gmail_msg"=
><br><br>David Sommerseth<br class=3D"gmail_msg"><br><br>OpenVPN Technologi=
es, Inc<br class=3D"gmail_msg"><br><br><br class=3D"gmail_msg"><br><br><br =
class=3D"gmail_msg"><br><br></font></span></blockquote></div></div></div></=
blockquote></div></div>

--001a114b7e0c56685105456fcfc5--

