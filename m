MIME-Version: 1.0
In-Reply-To: <CAA1AbxLFdnrxw-2nVYrKfUZ4CbPgfjR5=zYWLcqfhcdGkktVJw@...278...>
References: <1463822525-2532-1-git-send-email-openvpn-devel@...2127...>
	<1463822525-2532-2-git-send-email-openvpn-devel@...2127...>
	<20160521095424.GQ53051@...1296...>
	<BF0BE230-3DDA-4CF6-A8DB-CABBE0825CF4@...2127...>
	<20160521111016.GS53051@...1296...>
	<9715E28C-0B26-4EAE-907A-B8A326BF98A7@...2127...>
	<20160522124546.GA53051@...1296...>
	<5742C2E1.2060407@...515...>
	<CAA1AbxLFdnrxw-2nVYrKfUZ4CbPgfjR5=zYWLcqfhcdGkktVJw@...278...>
Date: Tue, 24 May 2016 13:23:48 +0500
Message-ID: <CAFHpkQGG4iCZdA7kufN6PJXHXZ6KPScLb6VDdvBCYAtOrqsKkA@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Content-Type: multipart/alternative; boundary=001a1143a88ab7305e0533924647
Subject: Re: [Openvpn-devel] [PATCH 1/2] Refactor t_client.sh
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a1143a88ab7305e0533924647
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Travis CI supports Linux and MacOS X, no *BSD, no Windows, ...

2016-05-24 12:31 GMT+05:00 Steffan Karger <steffan@...1856...>:

> Hi,
>
> On Mon, May 23, 2016 at 10:44 AM, Samuli Sepp=C3=A4nen <samuli@...515...>
> wrote:
> > Yes. I think a separate testing branch with more liberal commit rights
> > combined with pulling from GitHub makes sense. I'm not sure what happens
> > at the buildslaves if we decide rewind history - rewinding would be
> > quite useful when working with pure testing branches in that we could
> > make "testing" track master and whenever a bad patch is found, simply
> > rewind back to the last known-good state.
>
> Isn't this what github pull requests + travis is supposed to give us?
> Of course, that currently only covers a rather small part (much less
> than the buildbot tests), but it's not that hard to expand that to at
> least a decent number of compile variations.  That would give us
> useful smoke tests before looking at a single line of code.
>
> (May I remind the list of
> http://thread.gmane.org/gmane.network.openvpn.devel/10865, which got
> some comments from ciphitsine (see
> http://thread.gmane.org/gmane.network.openvpn.devel/11557/focus=3D11585),
> but was never really ACK'ed and applied.)
>
> -Steffan
>
>
> -------------------------------------------------------------------------=
-----
> Mobile security can be enabling, not merely restricting. Employees who
> bring their own devices (BYOD) to work are irked by the imposition of MDM
> restrictions. Mobile Device Manager Plus allows you to control only the
> apps on BYO-devices by containerizing them, leaving personal data
> untouched!
> https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--001a1143a88ab7305e0533924647
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Travis CI supports Linux and MacOS X, no *BSD, no Windows,=
 ...<br></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">201=
6-05-24 12:31 GMT+05:00 Steffan Karger <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&gt;</span>=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On Mon, May 23, 2016 at 10:44 AM, Samuli Sepp=C3=A4nen &lt;<a href=3D"mailt=
o:samuli@...515...">samuli@...515...</a>&gt; wrote:<br>
&gt; Yes. I think a separate testing branch with more liberal commit rights=
<br>
&gt; combined with pulling from GitHub makes sense. I&#39;m not sure what h=
appens<br>
&gt; at the buildslaves if we decide rewind history - rewinding would be<br>
&gt; quite useful when working with pure testing branches in that we could<=
br>
&gt; make &quot;testing&quot; track master and whenever a bad patch is foun=
d, simply<br>
&gt; rewind back to the last known-good state.<br>
<br>
</span>Isn&#39;t this what github pull requests + travis is supposed to giv=
e us?<br>
Of course, that currently only covers a rather small part (much less<br>
than the buildbot tests), but it&#39;s not that hard to expand that to at<b=
r>
least a decent number of compile variations.=C2=A0 That would give us<br>
useful smoke tests before looking at a single line of code.<br>
<br>
(May I remind the list of<br>
<a href=3D"http://thread.gmane.org/gmane.network.openvpn.devel/10865" rel=
=3D"noreferrer" target=3D"_blank">http://thread.gmane.org/gmane.network.ope=
nvpn.devel/10865</a>, which got<br>
some comments from ciphitsine (see<br>
<a href=3D"http://thread.gmane.org/gmane.network.openvpn.devel/11557/focus=
=3D11585" rel=3D"noreferrer" target=3D"_blank">http://thread.gmane.org/gman=
e.network.openvpn.devel/11557/focus=3D11585</a>),<br>
but was never really ACK&#39;ed and applied.)<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
-Steffan<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
---------------------------------------------------------------------------=
---<br>
Mobile security can be enabling, not merely restricting. Employees who<br>
bring their own devices (BYOD) to work are irked by the imposition of MDM<b=
r>
restrictions. Mobile Device Manager Plus allows you to control only the<br>
apps on BYO-devices by containerizing them, leaving personal data untouched=
!<br>
<a href=3D"https://ad.doubleclick.net/ddm/clk/304595813;131938128;j" rel=3D=
"noreferrer" target=3D"_blank">https://ad.doubleclick.net/ddm/clk/304595813=
;131938128;j</a><br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</div></div></blockquote></div><br></div>

--001a1143a88ab7305e0533924647--

