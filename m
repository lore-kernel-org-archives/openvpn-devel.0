MIME-Version: 1.0
In-Reply-To: <f077c965-a063-5f11-f298-2fd551ae4f95@...1856...>
References: <CAFHpkQFzZRLQhOTqoOakUuwUURo4=-Jf-FPiYfi-de86=6Q1Pw@...278...>
	<4bf6ce6c-ab68-d5b1-cd79-fb6e0dad2ffd@...1856...>
	<CAFHpkQGC8kRpVLE=2vBAYpEMkh+=VTqy_VTqfbWdhsOOr-GGUA@...278...>
	<f077c965-a063-5f11-f298-2fd551ae4f95@...1856...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 6 Nov 2016 13:19:45 +0500
Message-ID: <CAFHpkQFaUZTSEZLU02najYjtKNye6L=kEN0051q9TTCMzVeOnQ@...278...>
Content-Type: multipart/alternative; boundary=001a114ccbbaee982805409d9180
Subject: Re: [Openvpn-devel] any reason to not adding tap-windows.h to
 https://github.com/OpenVPN/openvpn/tree/master/include ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114ccbbaee982805409d9180
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2016-11-05 15:53 GMT+05:00 Steffan Karger <steffan@...1856...>:

> Hi,
>
> On 05-11-16 11:34, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> >
> > 2016-11-05 13:08 GMT+05:00 Steffan Karger <steffan@...1856...
> > <mailto:steffan@...1856...>>:
> >
> >     On 05-11-16 06:52, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD wrote:
> >     > I'm geting "build only" travis-ci mingw cross compile config
> >     > and I came to idea that I do not understand why "tap-windows.h"
> must be
> >     > downloaded separately
> >     >
> >     > 1) if we use some functions, we should include prototypes. it is
> not
> >     > very common to download prototypes from different location
> >
> >     When using external dependencies it is *not* a best practice to
> include
> >     the headers of that dependency (or even worse, binaries) into your
> own
> >     project repository.  I haven't seen any decent C project do that.  =
We
> >     wouldn't include the OpenSSL, mbed TLS or even libc headers either,
> >     would we?
> >
> > we include cmocka as git submodule.
> > if such an approach is acceptable, we can use another submodule (to
> > tap-windows repo)
>
> Yes, which I'm still wondering about whether that was the right choice.
> Using configure might have made more sense.
>

I would really like to hear the reason of "ACK"ing cmocka and "NOT ACK"ing
tap-windows


>
> Either way, although I don't agree with your suggested approach, I do
> see that building (and particularly, cross compiling) isn't easy, and
> that it would be nice to improve on that.
>
> A different approach (which I use internally for OpenVPN-NL) is to
> create a build repository with build scripts and all the required
> dependencies as submodules.  It might make sense to do something like
> that for openvpn-build?  (This works nicely for us internally, but I'm
> not so sure that would work as well for openvpn-build.)
>
> -Steffan
>

--001a114ccbbaee982805409d9180
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-11-05 15:53 GMT+05:00 Steffan Karger <span dir=3D"ltr">&lt;<a href=
=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&gt;=
</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On 05-11-16 11:34, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:<br>
&gt;<br>
&gt; 2016-11-05 13:08 GMT+05:00 Steffan Karger &lt;<a href=3D"mailto:steffa=
n@...1856...">steffan@...1856...</a><br>
</span>&gt; &lt;mailto:<a href=3D"mailto:steffan@...1856...">steffan@...1852...=
6...</a>&gt;&gt;:<br>
<span class=3D"">&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0On 05-11-16 06:52, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=
=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I&#39;m geting &quot;build only&quot; travis-c=
i mingw cross compile config<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; and I came to idea that I do not understand wh=
y &quot;tap-windows.h&quot; must be<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; downloaded separately<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; 1) if we use some functions, we should include=
 prototypes. it is not<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; very common to download prototypes from differ=
ent location<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0When using external dependencies it is *not* a best=
 practice to include<br>
&gt;=C2=A0 =C2=A0 =C2=A0the headers of that dependency (or even worse, bina=
ries) into your own<br>
&gt;=C2=A0 =C2=A0 =C2=A0project repository.=C2=A0 I haven&#39;t seen any de=
cent C project do that.=C2=A0 We<br>
&gt;=C2=A0 =C2=A0 =C2=A0wouldn&#39;t include the OpenSSL, mbed TLS or even =
libc headers either,<br>
&gt;=C2=A0 =C2=A0 =C2=A0would we?<br>
&gt;<br>
&gt; we include cmocka as git submodule.<br>
&gt; if such an approach is acceptable, we can use another submodule (to<br>
&gt; tap-windows repo)<br>
<br>
</span>Yes, which I&#39;m still wondering about whether that was the right =
choice.<br>
Using configure might have made more sense.<br></blockquote><div><br></div>=
<div>I would really like to hear the reason of &quot;ACK&quot;ing cmocka an=
d &quot;NOT ACK&quot;ing tap-windows<br></div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">
<br>
Either way, although I don&#39;t agree with your suggested approach, I do<b=
r>
see that building (and particularly, cross compiling) isn&#39;t easy, and<b=
r>
that it would be nice to improve on that.<br>
<br>
A different approach (which I use internally for OpenVPN-NL) is to<br>
create a build repository with build scripts and all the required<br>
dependencies as submodules.=C2=A0 It might make sense to do something like<=
br>
that for openvpn-build?=C2=A0 (This works nicely for us internally, but I&#=
39;m<br>
not so sure that would work as well for openvpn-build.)<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
-Steffan<br>
</font></span></blockquote></div><br></div></div>

--001a114ccbbaee982805409d9180--

