MIME-Version: 1.0
In-Reply-To: <a766bfda-08dd-0984-c310-e9fc502326b0@...515...>
References: <CAFHpkQHx1b4hDbeW2eOJDURHQoN6eCb40AZ5U4bhJOJdyPLnMg@...278...>
	<a766bfda-08dd-0984-c310-e9fc502326b0@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 9 Mar 2017 13:35:59 +0500
Message-ID: <CAFHpkQGfJovhga5C6pBSDcz9mEuie_Gj_JuiTxa3T4bbM=RVmw@...278...>
Content-Type: multipart/alternative; boundary=001a114b14ca72b3b9054a4822a6
Subject: Re: [Openvpn-devel] could be gitlab-ci an alternative to buildbot
	cloud?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114b14ca72b3b9054a4822a6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-03-09 0:58 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

> Hi,
>
> On 05/03/2017 16:25, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> > Hello,
> >
> > there was some buzz related to improvement of testing system, like
> > patchwork.
> > we tried gitlab-ci on our internal project, it looks very promising.
> >
> > since openvpn is already hosted on gitlab.com <http://gitlab.com>,
> > there's a possibility of
> >
> > 1) users can add their own gitlab-ci agents to the repo
> > 2) it might be even windows agents
> > 3) build results are publicly available (not easy to get from buildbot)
>
> Buildbot is behind VPN because of security reasons. We can easily grant
> more access to its WebUI if we need to. So far there has not been a
> pressing need to do that.
>
> Afaik it would be possible to run a Windows buildslaves. The problem is
> that OpenVPN Windows building tends to suck. Hence we have the custom
> hacked together cross-compile "buildslave" that makes use of openvpn-buil=
d.
>

I am going to build openvpn on AppVeyor+mingw soon.
Actually, it is just a half of solution. "make check" most probably will
not run on Windows yet



>
> > it looks like a big step, and it is hard to predict its result. but, I
> > think we can try and have a look at it.
> > thoughts?
>
> Personally I'm not too keen to migrate away from Buildbot unless there
> are very significant benefits. Not having to configure any
> agents/buildslaves would be such a benefit imho.
>
> That said, I will have a look at gitlab-ci to see what it can do.
>
> >
> > Cheers,
> > Ilya Shipitsin
> >
> > p.s. for our internal projects gitlab agents are always available, I did
> > not try yet how it works when some agents are unavalaible
> >
> >
> > ------------------------------------------------------------
> ------------------
> > Check out the vibrant tech community on one of the world's most
> > engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> >
> >
> >
> > _______________________________________________
> > Openvpn-devel mailing list
> > Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >
>
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>

--001a114b14ca72b3b9054a4822a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-03-09 0:58 GMT+05:00 Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...515...</a>&gt=
;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On 05/03/2017 16:25, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; there was some buzz related to improvement of testing system, like<br>
&gt; patchwork.<br>
&gt; we tried gitlab-ci on our internal project, it looks very promising.<b=
r>
&gt;<br>
</span>&gt; since openvpn is already hosted on <a href=3D"http://gitlab.com=
" rel=3D"noreferrer" target=3D"_blank">gitlab.com</a> &lt;<a href=3D"http:/=
/gitlab.com" rel=3D"noreferrer" target=3D"_blank">http://gitlab.com</a>&gt;=
,<br>
<span class=3D"">&gt; there&#39;s a possibility of<br>
&gt;<br>
&gt; 1) users can add their own gitlab-ci agents to the repo<br>
&gt; 2) it might be even windows agents<br>
&gt; 3) build results are publicly available (not easy to get from buildbot=
)<br>
<br>
</span>Buildbot is behind VPN because of security reasons. We can easily gr=
ant<br>
more access to its WebUI if we need to. So far there has not been a<br>
pressing need to do that.<br>
<br>
Afaik it would be possible to run a Windows buildslaves. The problem is<br>
that OpenVPN Windows building tends to suck. Hence we have the custom<br>
hacked together cross-compile &quot;buildslave&quot; that makes use of open=
vpn-build.<br></blockquote><div><br></div><div>I am going to build openvpn =
on AppVeyor+mingw soon.<br></div><div>Actually, it is just a half of soluti=
on. &quot;make check&quot; most probably will not run on Windows yet<br></d=
iv><div><br>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<span class=3D""><br>
&gt; it looks like a big step, and it is hard to predict its result. but, I=
<br>
&gt; think we can try and have a look at it.<br>
&gt; thoughts?<br>
<br>
</span>Personally I&#39;m not too keen to migrate away from Buildbot unless=
 there<br>
are very significant benefits. Not having to configure any<br>
agents/buildslaves would be such a benefit imho.<br>
<br>
That said, I will have a look at gitlab-ci to see what it can do.<br>
<span class=3D"im HOEnZb"><br>
&gt;<br>
&gt; Cheers,<br>
&gt; Ilya Shipitsin<br>
&gt;<br>
&gt; p.s. for our internal projects gitlab agents are always available, I d=
id<br>
&gt; not try yet how it works when some agents are unavalaible<br>
&gt;<br>
&gt;<br>
</span><div class=3D"HOEnZb"><div class=3D"h5">&gt; -----------------------=
-------<wbr>------------------------------<wbr>------------------<br>
&gt; Check out the vibrant tech community on one of the world&#39;s most<br>
&gt; engaging tech sites, SlashDot.org! <a href=3D"http://sdm.link/slashdot=
" rel=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; ______________________________<wbr>_________________<br>
&gt; Openvpn-devel mailing list<br>
&gt; <a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...220...=
..1199...<wbr>sourceforge.net</a><br>
&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>li=
sts/listinfo/openvpn-devel</a><br>
&gt;<br>
<br>
<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">--<br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
</font></span></blockquote></div><br></div></div>

--001a114b14ca72b3b9054a4822a6--

