MIME-Version: 1.0
In-Reply-To: <CAEsd45Qa34HsKZ6rwhuF5qnvBBnsFVeaJcRConfLEjXOdu+StQ@...278...>
References: <54450921.30501@...515...> <54461F20.5060908@...1147...>
	<20141021091159.GY396@...1296...>
	<CAEsd45SOhJcowu27gs6Be5YShph91pUBwq4eBfhGtpCT2MXo1w@...278...>
	<20141021104308.GZ396@...1296...>
	<CAEsd45Qa34HsKZ6rwhuF5qnvBBnsFVeaJcRConfLEjXOdu+StQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 21 Oct 2014 09:55:09 -0400
Message-ID: <CAKuzo_juo92ZC8aGjE4FN=EFnw1WMczE_noX7Aa2m+wQEXeJfQ@...278...>
Content-Type: multipart/alternative; boundary=bcaec52bee611a5a030505ef2fe9
Subject: Re: [Openvpn-devel] New OpenVPN Windows installers (I004 and I604)
	released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--bcaec52bee611a5a030505ef2fe9
Content-Type: text/plain; charset=UTF-8

Currently OpneVPN-MI-GUI does work without elevated privileges using
openvpn service and the management interface. I have a small user-base who
have been happily using it this way for more than a year now. In my view if
OpenVPN distribution could bundle the MI-GUI, it would be of great help.

Selva

On Tue, Oct 21, 2014 at 6:58 AM, Jonathan K. Bullard <jkbullard@...277...>
wrote:

> On Tue, Oct 21, 2014 at 6:43 AM, Gert Doering <gert@...1296...> wrote:
> > Yes, exactly.  In essence, you have a windows service running with full
> > privileges, which is instructed by the GUI to run an openvpn.exe process
> > (with user privs, so OpenVPN can't do damage) and OpenVPN communicates
> > back to the service what should be ifconfig'ed and what routes should
> > be installed.  So the network config is done by the service, and
> > undone when OpenVPN exits or crashes.
>
> That's what I am hoping for -- either an extension to the management
> interface, or an similar but separate interface.
>
>
> > Unfortunately, right now, there is nothing at all yet - there is most of
> > the code, but it's still living in Heiko's private tree.  We plan to meet
> > in person in November ("Munich Hackathon") and hopefully this will
> unravel
> > the knot that's holding up this change.
>
> I look forward to hearing about it.
>
> > How do you handle things in Tunnelblick today?  Run OpenVPN "as root"?
>
> Yes, exactly. I'd love to make that not necessary.
>
> Thanks for the info.
>
> Jon
>
>
> ------------------------------------------------------------------------------
> Comprehensive Server Monitoring with Site24x7.
> Monitor 10 servers for $9/Month.
> Get alerted through email, SMS, voice calls or mobile push notifications.
> Take corrective actions from your mobile device.
> http://p.sf.net/sfu/Zoho
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--bcaec52bee611a5a030505ef2fe9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Currently OpneVPN-MI-GUI does work without elevated p=
rivileges using openvpn service and the management interface. I have a smal=
l user-base who have been happily using it this way for more than a year no=
w. In my view if OpenVPN distribution could bundle the MI-GUI, it would be =
of great help. <br><br></div>Selva<br></div><div class=3D"gmail_extra"><br>=
<div class=3D"gmail_quote">On Tue, Oct 21, 2014 at 6:58 AM, Jonathan K. Bul=
lard <span dir=3D"ltr">&lt;<a href=3D"mailto:jkbullard@...277..." target=3D=
"_blank">jkbullard@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex"><span class=3D"">On Tue, Oct 21, 2014 at 6:43 AM, Gert Doering &l=
t;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<br>
&gt; Yes, exactly.=C2=A0 In essence, you have a windows service running wit=
h full<br>
&gt; privileges, which is instructed by the GUI to run an openvpn.exe proce=
ss<br>
&gt; (with user privs, so OpenVPN can&#39;t do damage) and OpenVPN communic=
ates<br>
&gt; back to the service what should be ifconfig&#39;ed and what routes sho=
uld<br>
&gt; be installed.=C2=A0 So the network config is done by the service, and<=
br>
&gt; undone when OpenVPN exits or crashes.<br>
<br>
</span>That&#39;s what I am hoping for -- either an extension to the manage=
ment<br>
interface, or an similar but separate interface.<br>
<span class=3D""><br>
<br>
&gt; Unfortunately, right now, there is nothing at all yet - there is most =
of<br>
&gt; the code, but it&#39;s still living in Heiko&#39;s private tree.=C2=A0=
 We plan to meet<br>
&gt; in person in November (&quot;Munich Hackathon&quot;) and hopefully thi=
s will unravel<br>
&gt; the knot that&#39;s holding up this change.<br>
<br>
</span>I look forward to hearing about it.<br>
<span class=3D""><br>
&gt; How do you handle things in Tunnelblick today?=C2=A0 Run OpenVPN &quot=
;as root&quot;?<br>
<br>
</span>Yes, exactly. I&#39;d love to make that not necessary.<br>
<br>
Thanks for the info.<br>
<br>
Jon<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
---------------------------------------------------------------------------=
---<br>
Comprehensive Server Monitoring with Site24x7.<br>
Monitor 10 servers for $9/Month.<br>
Get alerted through email, SMS, voice calls or mobile push notifications.<b=
r>
Take corrective actions from your mobile device.<br>
<a href=3D"http://p.sf.net/sfu/Zoho" target=3D"_blank">http://p.sf.net/sfu/=
Zoho</a><br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" targ=
et=3D"_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a=
><br>
</div></div></blockquote></div><br></div>

--bcaec52bee611a5a030505ef2fe9--

