MIME-Version: 1.0
In-Reply-To: <20130529133817.GG6942@...1330...>
References: <CAMaBZnHDPHTpPmFoLbyDHxKnBwm7PdPDouZi99bgQzrA9=eXDw@...278...>
	<20130529122956.GH20843@...1296...>
	<20130529133817.GG6942@...1330...>
Date: Wed, 29 May 2013 14:37:12 -0400
Message-ID: <CAMaBZnFwr4iMVTg4QSkosMYsqnpq5-_rt9eny-O9fCSLFLoiqg@...278...>
From: Praetorian <praetoriancode@...277...>
Content-Type: multipart/alternative; boundary=047d7b2e471093eecd04dddfab47
Subject: Re: [Openvpn-devel] Repos for Debian Wheezy?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--047d7b2e471093eecd04dddfab47
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

I'll take a look at the one in unstable.  I'm not sure what parts have been
back ported to 2.2 that I have been testing in the 2.3 branch.  I would
have thought that 2.3 is mature enough to be in the debian repos by now.


On Wed, May 29, 2013 at 9:38 AM, Alberto Gonzalez Iniesta
<agi@...64...>wrote:

> On Wed, May 29, 2013 at 02:29:57PM +0200, Gert Doering wrote:
> > Hi,
> >
> > On Wed, May 29, 2013 at 08:24:43AM -0400, Praetorian wrote:
> > > With the stable release of Wheezy is there a time frame that there
> might be
> > > a openvpn repo for Wheezy?  I have a multisite setup that I would like
> to
> > > update to Wheezy that could take advantage of some of the advancements
> in
> > > Wheezy. Sadly ver 2.2 is what is in the Debian repo for Wheezy
> currently.
> > >  The setup currently runs off the 2.3 version for some of the ipv6
> needs.
> >
> > Isn't Debian incorporating the IPv6 patches anyway that bring most of
> > the 2.3 ipv6 functionality to 2.2?
>
> Yes, it is. AFAIK.
> Anyway, I'll try to make a backport one of these days, but the one in
> unstable should work in Wheezy too.
>
> --
> Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cn=
ico
> agi@(inittab.org|debian.org)| en GNU/Linux y software libre
> Encrypted mail preferred    | http://inittab.com
>
> Key fingerprint =3D 5347 CBD8 3E30 A9EB 4D7D  4BF2 009B 3375 6B9A AA55
>
>
> -------------------------------------------------------------------------=
-----
> Introducing AppDynamics Lite, a free troubleshooting tool for Java/.NET
> Get 100% visibility into your production application - at no cost.
> Code-level diagnostics for performance bottlenecks with <2% overhead
> Download for free and get started troubleshooting in minutes.
> http://p.sf.net/sfu/appdyn_d2d_ap1
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--047d7b2e471093eecd04dddfab47
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;ll take a look at the one in unstable. =A0I&#39;m no=
t sure what parts have been back ported to 2.2 that I have been testing in =
the 2.3 branch. =A0I would have thought that 2.3 is mature enough to be in =
the debian repos by now.=A0</div>
<div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Wed, May 2=
9, 2013 at 9:38 AM, Alberto Gonzalez Iniesta <span dir=3D"ltr">&lt;<a href=
=3D"mailto:agi@...64..." target=3D"_blank">agi@...64...</a>&gt;</span> wrot=
e:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Wed, May 29, 2013 at 02=
:29:57PM +0200, Gert Doering wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; On Wed, May 29, 2013 at 08:24:43AM -0400, Praetorian wrote:<br>
&gt; &gt; With the stable release of Wheezy is there a time frame that ther=
e might be<br>
&gt; &gt; a openvpn repo for Wheezy? =A0I have a multisite setup that I wou=
ld like to<br>
&gt; &gt; update to Wheezy that could take advantage of some of the advance=
ments in<br>
&gt; &gt; Wheezy. Sadly ver 2.2 is what is in the Debian repo for Wheezy cu=
rrently.<br>
&gt; &gt; =A0The setup currently runs off the 2.3 version for some of the i=
pv6 needs.<br>
&gt;<br>
&gt; Isn&#39;t Debian incorporating the IPv6 patches anyway that bring most=
 of<br>
&gt; the 2.3 ipv6 functionality to 2.2?<br>
<br>
</div>Yes, it is. AFAIK.<br>
Anyway, I&#39;ll try to make a backport one of these days, but the one in<b=
r>
unstable should work in Wheezy too.<br>
<br>
--<br>
Alberto Gonzalez Iniesta =A0 =A0| Formaci=F3n, consultor=EDa y soporte t=E9=
cnico<br>
agi@(<a href=3D"http://inittab.org" target=3D"_blank">inittab.org</a>|<a hr=
ef=3D"http://debian.org" target=3D"_blank">debian.org</a>)| en GNU/Linux y =
software libre<br>
Encrypted mail preferred =A0 =A0| <a href=3D"http://inittab.com" target=3D"=
_blank">http://inittab.com</a><br>
<br>
Key fingerprint =3D 5347 CBD8 3E30 A9EB 4D7D =A04BF2 009B 3375 6B9A AA55<br>
<br>
---------------------------------------------------------------------------=
---<br>
Introducing AppDynamics Lite, a free troubleshooting tool for Java/.NET<br>
Get 100% visibility into your production application - at no cost.<br>
Code-level diagnostics for performance bottlenecks with &lt;2% overhead<br>
Download for free and get started troubleshooting in minutes.<br>
<a href=3D"http://p.sf.net/sfu/appdyn_d2d_ap1" target=3D"_blank">http://p.s=
f.net/sfu/appdyn_d2d_ap1</a><br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" targ=
et=3D"_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a=
><br>
</blockquote></div><br></div>

--047d7b2e471093eecd04dddfab47--

