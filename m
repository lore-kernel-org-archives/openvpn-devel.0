MIME-Version: 1.0
In-Reply-To: <20130529185003.GJ20843@...1296...>
References: <CAMaBZnHDPHTpPmFoLbyDHxKnBwm7PdPDouZi99bgQzrA9=eXDw@...278...>
	<20130529122956.GH20843@...1296...>
	<20130529133817.GG6942@...1330...>
	<CAMaBZnFwr4iMVTg4QSkosMYsqnpq5-_rt9eny-O9fCSLFLoiqg@...278...>
	<20130529185003.GJ20843@...1296...>
Date: Wed, 29 May 2013 21:37:00 -0400
Message-ID: <CAMaBZnFVPuyUDRwKu0qiOLRdZwhmJXiho=29keGvft=fvBA6Sw@...278...>
From: Praetorian <praetoriancode@...277...>
Content-Type: multipart/alternative; boundary=001a11c2e238e30e6404dde588ed
Subject: Re: [Openvpn-devel] Repos for Debian Wheezy?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a11c2e238e30e6404dde588ed
Content-Type: text/plain; charset=ISO-8859-1

I tried using the snapshot branch of squeeze but ran into a dependency
problem with libssl0.9.8.  The version installed in Wheezy is libssl1.0.0.

 root@...1824...:/etc/apt/sources.list.d# apt-get install openvpn
Reading package lists... Done
Building dependency tree
Reading state information... Done
Some packages could not be installed. This may mean that you have
requested an impossible situation or if you are using the unstable
distribution that some required packages have not yet been created
or been moved out of Incoming.
The following information may help to resolve the situation:
The following packages have unmet dependencies:
 openvpn : Depends: libssl0.9.8 (>= 0.9.8m-1) but it is not installable
E: Unable to correct problems, you have held broken packages.
Any hints greatly appreciated.


On Wed, May 29, 2013 at 2:50 PM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Wed, May 29, 2013 at 02:37:12PM -0400, Praetorian wrote:
> > I'll take a look at the one in unstable.  I'm not sure what parts have
> been
> > back ported to 2.2 that I have been testing in the 2.3 branch.  I would
> > have thought that 2.3 is mature enough to be in the debian repos by now.
>
> Nah, this being debian, it's amazing that they are not stuck at 2.0.9 :-)
>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //
> www.muc.de/~gert/
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025
> gert@...1297...
>

--001a11c2e238e30e6404dde588ed
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I tried using the snapshot branch of squeeze but ran =
into a dependency problem with libssl0.9.8.=A0 The version installed in Whe=
ezy is libssl1.0.0.</div><div>=A0</div><div>=A0root@...1824...:/etc/apt/sou=
rces.list.d# apt-get install openvpn<br>
Reading package lists... Done<br>Building dependency tree<br>Reading state =
information... Done<br>Some packages could not be installed. This may mean =
that you have<br>requested an impossible situation or if you are using the =
unstable<br>
distribution that some required packages have not yet been created<br>or be=
en moved out of Incoming.<br>The following information may help to resolve =
the situation:</div><div>The following packages have unmet dependencies:<br>
=A0openvpn : Depends: libssl0.9.8 (&gt;=3D 0.9.8m-1) but it is not installa=
ble<br>E: Unable to correct problems, you have held broken packages.<br></d=
iv><div>Any hints greatly appreciated.</div></div><div class=3D"gmail_extra=
">
<br><br><div class=3D"gmail_quote">On Wed, May 29, 2013 at 2:50 PM, Gert Do=
ering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_b=
lank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
Hi,<br>
<div class=3D"im"><br>
On Wed, May 29, 2013 at 02:37:12PM -0400, Praetorian wrote:<br>
&gt; I&#39;ll take a look at the one in unstable. =A0I&#39;m not sure what =
parts have been<br>
&gt; back ported to 2.2 that I have been testing in the 2.3 branch. =A0I wo=
uld<br>
&gt; have thought that 2.3 is mature enough to be in the debian repos by no=
w.<br>
<br>
</div>Nah, this being debian, it&#39;s amazing that they are not stuck at 2=
.0.9 :-)<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
gert<br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0//<a href=3D"http://www.muc.de/=
~gert/" target=3D"_blank">www.muc.de/~gert/</a><br>
Gert Doering - Munich, Germany =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 <a href=3D"mailto:gert@...1296...">gert@...1296...</a><br>
fax: <a href=3D"tel:%2B49-89-35655025" value=3D"+498935655025">+49-89-35655=
025</a> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<a href=3D"mailto:ge=
rt@...1297...">gert@...1297...</a><br>
</div></div></blockquote></div><br></div>

--001a11c2e238e30e6404dde588ed--

