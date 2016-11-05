MIME-Version: 1.0
In-Reply-To: <4bf6ce6c-ab68-d5b1-cd79-fb6e0dad2ffd@...1856...>
References: <CAFHpkQFzZRLQhOTqoOakUuwUURo4=-Jf-FPiYfi-de86=6Q1Pw@...278...>
	<4bf6ce6c-ab68-d5b1-cd79-fb6e0dad2ffd@...1856...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sat, 5 Nov 2016 15:34:21 +0500
Message-ID: <CAFHpkQGC8kRpVLE=2vBAYpEMkh+=VTqy_VTqfbWdhsOOr-GGUA@...278...>
Content-Type: multipart/alternative; boundary=001a114b2126749cb005408b55b5
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

--001a114b2126749cb005408b55b5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2016-11-05 13:08 GMT+05:00 Steffan Karger <steffan@...1856...>:

> Hi,
>
> On 05-11-16 06:52, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> > I'm geting "build only" travis-ci mingw cross compile config
> > and I came to idea that I do not understand why "tap-windows.h" must be
> > downloaded separately
> >
> > 1) if we use some functions, we should include prototypes. it is not
> > very common to download prototypes from different location
>
> When using external dependencies it is *not* a best practice to include
> the headers of that dependency (or even worse, binaries) into your own
> project repository.  I haven't seen any decent C project do that.  We
> wouldn't include the OpenSSL, mbed TLS or even libc headers either,
> would we?
>


we include cmocka as git submodule.
if such an approach is acceptable, we can use another submodule (to
tap-windows repo)


>
> > 2) such way requires also complicated things like configure checks
> > (which in turn may be avoided if we include tap-windows.h)
>
> configure checks are there to help you simplify dependency management.
> Our configure.ac might be a bit convoluted, so surely qualified for
> improvement, but setting a few paths isn't that hard, is it?
>
> > so, I guess, there're might be legal issue ?
> > if not, I vote for adding tap-windows.h into openvpn repo.
> > it will simplify things a lot
>
> I do not believe there are legal issues, but for the reasons above I
> vote against including the tap-windows headers into the core openvpn
> repo.  So, Feature-NAK.
>
> -Steffan
>
> ------------------------------------------------------------
> ------------------
> Developer Access Program for Intel Xeon Phi Processors
> Access to Intel Xeon Phi processor-based developer platforms.
> With one year of Intel Parallel Studio XE.
> Training and support from Colfax.
> Order your platform today. http://sdm.link/xeonphi
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--001a114b2126749cb005408b55b5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-11-05 13:08 GMT+05:00 Steffan Karger <span dir=3D"ltr">&lt;<a href=
=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&gt;=
</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On 05-11-16 06:52, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:<br>
&gt; I&#39;m geting &quot;build only&quot; travis-ci mingw cross compile co=
nfig<br>
&gt; and I came to idea that I do not understand why &quot;tap-windows.h&qu=
ot; must be<br>
&gt; downloaded separately<br>
&gt;<br>
&gt; 1) if we use some functions, we should include prototypes. it is not<b=
r>
&gt; very common to download prototypes from different location<br>
<br>
</span>When using external dependencies it is *not* a best practice to incl=
ude<br>
the headers of that dependency (or even worse, binaries) into your own<br>
project repository.=C2=A0 I haven&#39;t seen any decent C project do that.=
=C2=A0 We<br>
wouldn&#39;t include the OpenSSL, mbed TLS or even libc headers either,<br>
would we?<br></blockquote><div><br><br></div><div>we include cmocka as git =
submodule.<br></div><div>if such an approach is acceptable, we can use anot=
her submodule (to tap-windows repo)<br>=C2=A0<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">
<span class=3D""><br>
&gt; 2) such way requires also complicated things like configure checks<br>
&gt; (which in turn may be avoided if we include tap-windows.h)<br>
<br>
</span>configure checks are there to help you simplify dependency managemen=
t.<br>
Our <a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">co=
nfigure.ac</a> might be a bit convoluted, so surely qualified for<br>
improvement, but setting a few paths isn&#39;t that hard, is it?<br>
<span class=3D""><br>
&gt; so, I guess, there&#39;re might be legal issue ?<br>
&gt; if not, I vote for adding tap-windows.h into openvpn repo.<br>
&gt; it will simplify things a lot<br>
<br>
</span>I do not believe there are legal issues, but for the reasons above I=
<br>
vote against including the tap-windows headers into the core openvpn<br>
repo.=C2=A0 So, Feature-NAK.<br>
<br>
-Steffan<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
Developer Access Program for Intel Xeon Phi Processors<br>
Access to Intel Xeon Phi processor-based developer platforms.<br>
With one year of Intel Parallel Studio XE.<br>
Training and support from Colfax.<br>
Order your platform today. <a href=3D"http://sdm.link/xeonphi" rel=3D"noref=
errer" target=3D"_blank">http://sdm.link/xeonphi</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</blockquote></div><br></div></div>

--001a114b2126749cb005408b55b5--

