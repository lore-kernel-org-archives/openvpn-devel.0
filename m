MIME-Version: 1.0
In-Reply-To: <7e7799f0-e2f1-8773-18aa-6a89b87d3500@...2080...>
References: <1484297432-14435-1-git-send-email-chipitsine@...277...>
	<7dc75a19-451e-effa-503a-ac5b75a23bab@...515...>
	<ac93d2de-d56a-0ff9-b97a-a590923f5cf8@...2080...>
	<CAFHpkQEHRCveRiiBWscwLQ7U3UoJ+yY5_0Lx82UMc=f4ucwMbQ@...278...>
	<CAFHpkQFs5x_7MEH5gjieUsp=1f2SPdG9Fr6PeakgBGrSEPQC_Q@...278...>
	<6256c846-ca60-be4f-7122-60465374a322@...515...>
	<7e7799f0-e2f1-8773-18aa-6a89b87d3500@...2080...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 2 Feb 2017 09:58:21 +0500
Message-ID: <CAFHpkQFOUVkrAHcW7yXNk4WvJ9-0NcNr8QMVhABgNTufZHjRyQ@...278...>
Content-Type: multipart/alternative; boundary=001a1148e7c2b1979b0547850308
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

--001a1148e7c2b1979b0547850308
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-01-31 18:49 GMT+05:00 David Sommerseth <
openvpn@...2080...>:

> On 30/01/17 13:34, Samuli Sepp=C3=A4nen wrote:
> > I agree with you on keeping the pull request template minimal and having
> > the more fine-grained information in Trac.
> >
> > ACK.
>
> Don't get me wrong!  I agree we should keep the template minimal.  But I
> yet have to see a developer full of enthusiasm with a fix ready, who
> just clicked "Send pull request!" who will actually instantly go reading
> further.  And especially when the information need is fairly
> comprehensive and not even directly in the first URL being listed.
>
> In fact the first place where the patch process is described is here:
> <https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation#
> Communitypatchesandtheacceptanceprocessofthesepatches>.
>  That is "hidden" in the middle of the wiki on the second URL.  And the
> first URL provides just a link to the same DeveloperDocumentation wiki
> page.
>
> So I kindly ask you to reconsider the text more carefully once more.
>

well, I double checked everything, including refrigerator, unfortunately,
current text is the best I have.

@mattock, do you have a better text ?


>
> From my experience, to get the best success, provide the most critical
> and as accurate information as quickly as possible.  Once things are
> behind one URL you need to visit, many ignores it.  If you need to read
> through more text on that URL, even more will fall off.  But provide
> links to the more verbose documentation, as some will read it if the
> first 2-3 sentences sounds intriguing and the contributor have time to
> be curious.
>
> Most developers are lazy beasts ... they just want their patches out
> ASAP, and documentation are too easily ignored.
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
> > On 30/01/2017 08:48, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=
=D1=86=D0=B8=D0=BD wrote:
> >> can we merge it ?
> >> @mattock ?
> >>
> >> 2017-01-21 13:47 GMT+05:00 =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...
> >> <mailto:chipitsine@...277...>>:
> >>
> >>
> >>
> >>     2017-01-21 0:24 GMT+05:00 David Sommerseth
> >>     <openvpn@...2080...
> >>     <mailto:openvpn@...2080...>>:
> >>
> >>         On 13/01/17 10:05, Samuli Sepp=C3=A4nen wrote:
> >>         > Il 13/01/2017 10:50, Ilya Shipitsin ha scritto:
> >>         >> ---
> >>         >>  .github/PULL_REQUEST_TEMPLATE.md | 8 ++++++++
> >>         >>  1 file changed, 8 insertions(+)
> >>         >>  create mode 100644 .github/PULL_REQUEST_TEMPLATE.md
> >>         >>
> >>         >> diff --git a/.github/PULL_REQUEST_TEMPLATE.md
> b/.github/PULL_REQUEST_TEMPLATE.md
> >>         >> new file mode 100644
> >>         >> index 0000000..d0cfd7f
> >>         >> --- /dev/null
> >>         >> +++ b/.github/PULL_REQUEST_TEMPLATE.md
> >>         >> @@ -0,0 +1,8 @@
> >>         >> +# Thank you for your contribution
> >>         >> +
> >>         >> +You are welcome to open PR, but they are used for
> discussion only. All
> >>         >> +patches must eventually go to the openvpn-devel mailing
> list for review.
> >>         >> +For details, see these Wiki articles:
> >>         >> +
> >>         >> +* https://community.openvpn.net/openvpn/wiki/Contributing
> >>         <https://community.openvpn.net/openvpn/wiki/Contributing>
> >>         >> +* https://community.openvpn.net/openvpn/wiki/
> DeveloperDocumentation <https://community.openvpn.net/openvpn/wiki/
> DeveloperDocumentation>
> >>         >>
> >>         >
> >>         > Based on testing in the travis-openssl-test repository the
> template
> >>         > works as intended, so ACK on that part.
> >>         >
> >>         > Any comments on the text itself?
> >>
> >>         How does this work with branches?  Do we need to say that new
> >>         patches
> >>         should go into the master branch primarily, unless it is fixing
> >>         a bug or
> >>         another issue which is only relevant for specific release
> branches?
> >>
> >>
> >>
> >>     we can put such information to
> >>
> >>     https://community.openvpn.net/openvpn/wiki/Contributing
> >>     <https://community.openvpn.net/openvpn/wiki/Contributing>
> >>     https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation
> >>     <https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation>
> >>
> >>
> >>     I would leave PR template skinny
> >>
> >>
> >>
> >>
> >>         --
> >>         kind regards,
> >>
> >>         David Sommerseth
> >>         OpenVPN Technologies, Inc
> >>
> >>
> >>
> >>
> >
> >
>
>
>
>

--001a1148e7c2b1979b0547850308
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-01-31 18:49 GMT+05:00 David Sommerseth <span dir=3D"ltr">&lt;<a ta=
rget=3D"_blank" href=3D"mailto:openvpn@...2080...">openvpn@...2080...</a>&g=
t;</span>:<br><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote"><span class=
=3D"gmail-">On 30/01/17 13:34, Samuli Sepp=C3=A4nen wrote:<br>
&gt; I agree with you on keeping the pull request template minimal and havi=
ng<br>
&gt; the more fine-grained information in Trac.<br>
&gt;<br>
&gt; ACK.<br>
<br>
</span>Don&#39;t get me wrong!=C2=A0 I agree we should keep the template mi=
nimal.=C2=A0 But I<br>
yet have to see a developer full of enthusiasm with a fix ready, who<br>
just clicked &quot;Send pull request!&quot; who will actually instantly go =
reading<br>
further.=C2=A0 And especially when the information need is fairly<br>
comprehensive and not even directly in the first URL being listed.<br>
<br>
In fact the first place where the patch process is described is here:<br>
&lt;<a target=3D"_blank" rel=3D"noreferrer" href=3D"https://community.openv=
pn.net/openvpn/wiki/DeveloperDocumentation#Communitypatchesandtheacceptance=
processofthesepatches">https://community.openvpn.<wbr>net/openvpn/wiki/<wbr=
>DeveloperDocumentation#<wbr>Communitypatchesandtheacceptan<wbr>ceprocessof=
thesepatches</a>&gt;.<br>
=C2=A0That is &quot;hidden&quot; in the middle of the wiki on the second UR=
L.=C2=A0 And the<br>
first URL provides just a link to the same DeveloperDocumentation wiki page=
.<br>
<br>
So I kindly ask you to reconsider the text more carefully once more.<br></b=
lockquote><div><br></div><div>well, I double checked everything, including =
refrigerator, unfortunately, current text is the best I have.<br><br></div>=
<div>@mattock, do you have a better text ?<br></div><div>=C2=A0</div><block=
quote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex" class=3D"gmail_quote">
<br>
From my experience, to get the best success, provide the most critical<br>
and as accurate information as quickly as possible.=C2=A0 Once things are<b=
r>
behind one URL you need to visit, many ignores it.=C2=A0 If you need to rea=
d<br>
through more text on that URL, even more will fall off.=C2=A0 But provide<b=
r>
links to the more verbose documentation, as some will read it if the<br>
first 2-3 sentences sounds intriguing and the contributor have time to<br>
be curious.<br>
<br>
Most developers are lazy beasts ... they just want their patches out<br>
ASAP, and documentation are too easily ignored.<br>
<div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5"><br>
<br>
--<br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN Technologies, Inc<br>
<br>
<br>
<br>
&gt; On 30/01/2017 08:48, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=
=D1=86=D0=B8=D0=BD wrote:<br>
&gt;&gt; can we merge it ?<br>
&gt;&gt; @mattock ?<br>
&gt;&gt;<br>
&gt;&gt; 2017-01-21 13:47 GMT+05:00 =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=
=D0=BF=D0=B8=D1=86=D0=B8=D0=BD &lt;<a href=3D"mailto:chipitsine@...277...">=
chipitsine@...277...</a><br>
&gt;&gt; &lt;mailto:<a href=3D"mailto:chipitsine@...277...">chipitsine@...1665...=
77...</a>&gt;&gt;<wbr>:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A02017-01-21 0:24 GMT+05:00 David Sommerseth<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:openvpn@...2080...">openv=
pn@...2142...<wbr>topphemmelig.net</a><br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:openvpn@...2080...=
">openvpn@...2142...<wbr>topphemmelig.net</a>&gt;&gt;:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0On 13/01/17 10:05, Samuli Sepp=C3=
=A4nen wrote:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Il 13/01/2017 10:50, Ilya Sh=
ipitsin ha scritto:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 .github/PULL_REQUE=
ST_TEMPLATE.<wbr>md | 8 ++++++++<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 1 file changed, 8 =
insertions(+)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 create mode 100644=
 .github/PULL_REQUEST_TEMPLATE.<wbr>md<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; diff --git a/.github/PUL=
L_REQUEST_<wbr>TEMPLATE.md b/.github/PULL_REQUEST_<wbr>TEMPLATE.md<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; new file mode 100644<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; index 0000000..d0cfd7f<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; --- /dev/null<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; +++ b/.github/PULL_REQUE=
ST_<wbr>TEMPLATE.md<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; @@ -0,0 +1,8 @@<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; +# Thank you for your co=
ntribution<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; +You are welcome to open=
 PR, but they are used for discussion only. All<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; +patches must eventually=
 go to the openvpn-devel mailing list for review.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; +For details, see these =
Wiki articles:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; +* <a target=3D"_blank" =
rel=3D"noreferrer" href=3D"https://community.openvpn.net/openvpn/wiki/Contr=
ibuting">https://community.openvpn.net/<wbr>openvpn/wiki/Contributing</a><b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a target=3D"_blank" rel=3D"n=
oreferrer" href=3D"https://community.openvpn.net/openvpn/wiki/Contributing"=
>https://community.openvpn.<wbr>net/openvpn/wiki/Contributing</a>&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; +* <a target=3D"_blank" =
rel=3D"noreferrer" href=3D"https://community.openvpn.net/openvpn/wiki/Devel=
operDocumentation">https://community.openvpn.net/<wbr>openvpn/wiki/<wbr>Dev=
eloperDocumentation</a> &lt;<a target=3D"_blank" rel=3D"noreferrer" href=3D=
"https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation">https:/=
/community.openvpn.<wbr>net/openvpn/wiki/<wbr>DeveloperDocumentation</a>&gt=
;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Based on testing in the trav=
is-openssl-test repository the template<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; works as intended, so ACK on=
 that part.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Any comments on the text its=
elf?<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0How does this work with branches?=
=C2=A0 Do we need to say that new<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0patches<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0should go into the master branch =
primarily, unless it is fixing<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a bug or<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0another issue which is only relev=
ant for specific release branches?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0we can put such information to<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0<a target=3D"_blank" rel=3D"noreferrer" href=3D=
"https://community.openvpn.net/openvpn/wiki/Contributing">https://community=
.openvpn.net/<wbr>openvpn/wiki/Contributing</a><br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a target=3D"_blank" rel=3D"noreferrer" hre=
f=3D"https://community.openvpn.net/openvpn/wiki/Contributing">https://commu=
nity.openvpn.<wbr>net/openvpn/wiki/Contributing</a>&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0<a target=3D"_blank" rel=3D"noreferrer" href=3D=
"https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation">https:/=
/community.openvpn.net/<wbr>openvpn/wiki/<wbr>DeveloperDocumentation</a><br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a target=3D"_blank" rel=3D"noreferrer" hre=
f=3D"https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation">htt=
ps://community.openvpn.<wbr>net/openvpn/wiki/<wbr>DeveloperDocumentation</a=
>&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0I would leave PR template skinny<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kind regards,<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0David Sommerseth<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OpenVPN Technologies, Inc<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
<br>
<br>
<br>
</div></div></blockquote></div><br></div></div>

--001a1148e7c2b1979b0547850308--

