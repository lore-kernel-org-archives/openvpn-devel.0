MIME-Version: 1.0
In-Reply-To: <20120508073716.GM1359@...1296...>
References: <CAArKS8hPVLQSNrX4HtB+6UA+UU-63PmyN0BNmFuPdu4W0ZFEMw@...278...>
	<20120508073716.GM1359@...1296...>
From: Tom Kent <lists@...1718...>
Date: Thu, 10 May 2012 20:45:04 -0400
Message-ID: <CAArKS8gibawt-LNQws_7iiewyhAkH6TborXMiamsn1WqbLSr4g@...278...>
Content-Type: multipart/alternative; boundary=0015173fe5c844492a04bfb80d09
Subject: Re: [Openvpn-devel] OpenVPN in the Hypervisor
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0015173fe5c844492a04bfb80d09
Content-Type: text/plain; charset=ISO-8859-1

Hmm, that wasn't very successful. I guess I'm not sure what you mean when
you say to have open vpn use the tap interface right away.

My VM has a couple tap (I assume) interfaces vibr0 vibr1 (I can make more),
which say "br" in the name, but aren't actually bridged to anything
physical, they are just "virtual" networks, local to the machine.  I tried
to specify the name of one of those in the openvpn config file (in place of
tap0), but it didn't seem to work.

The other thing I tried was to have openvpn up and running, then to attach
the VM to the tap0 device that it created...that ended with this error:
libvirtError: internal error Failed to add tap interface to bridge. tap0 is
not a bridge device

Neither of these surprised me, this was how I thought the tap stuff worked,
but it sounded from your message like you knew of something else.  Could
you please clarify the idea you had on how to get openvpn connected to the
hypervisor?

On Tue, May 8, 2012 at 3:37 AM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Mon, May 07, 2012 at 09:03:17PM -0400, Tom Kent wrote:
> > The idea I had, and wanted to run by, was if it would be possible to
> > integrate an openvpn client into the hypervisor's virtual network card.
> > This would make it so that from the moment the VM boots up, it is only
> > connected to the private LAN served by the OpenVPN server. The VM would
> see
> > just another NIC, but instead of routing the data directly to the
> > Hypervisor's NIC (tap) or NATing it or whatever, it would go to an
> OpenVPN
> > client library (that wouldn't need a tun/tap device on the hypervisor)
> > which sends the data to the server over the udp connection.
>
> If your hypervisor uses a tap interface, you can just have openvpn use
> that tap interface "right away".  So don't bridge tap0 to eth0 on the
> Hypervisor, but just have tap0 available for the VMs, and run OpenVPN
> with "--dev tap0".
>
> This might be somewhat more expensive performance-wise - but it will
> be much cheaper programmer-time-wise, as all you need is already there
> and well-tested :-)
>
> gert
>
> --
> USENET is *not* the non-clickable part of WWW!
>                                                           //
> www.muc.de/~gert/
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025
> gert@...1297...
>

--0015173fe5c844492a04bfb80d09
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<div>Hmm, that wasn&#39;t very successful. I guess I&#39;m not sure what yo=
u mean when you say to have open vpn use the tap interface right away. =A0<=
/div><div><br></div><div>My VM has a couple=A0tap=A0(I assume) interfaces v=
ibr0 vibr1 (I can make more), which say &quot;br&quot; in the name, but are=
n&#39;t actually bridged to anything physical, they are just &quot;virtual&=
quot; networks, local to the machine. =A0I tried to specify the name of one=
 of those in the openvpn config file (in place of tap0), but it didn&#39;t =
seem to work.</div>

<div><br></div><div>The other thing I tried was to have openvpn up and runn=
ing, then to attach the VM to the tap0 device that it created...that ended =
with this error:</div>libvirtError: internal error Failed to add tap interf=
ace to bridge. tap0 is not a bridge device<div>

<br></div><div>Neither of these=A0surprised=A0me, this was how I thought th=
e tap stuff worked, but it sounded from your message like you knew of somet=
hing else. =A0Could you please clarify the idea you had on how to get openv=
pn connected to the hypervisor?<br>

<br><div class=3D"gmail_quote">On Tue, May 8, 2012 at 3:37 AM, Gert Doering=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank"=
>gert@...1296...</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi,<br>
<div><br>
On Mon, May 07, 2012 at 09:03:17PM -0400, Tom Kent wrote:<br>
&gt; The idea I had, and wanted to run by, was if it would be possible to<b=
r>
&gt; integrate an openvpn client into the hypervisor&#39;s virtual network =
card.<br>
&gt; This would make it so that from the moment the VM boots up, it is only=
<br>
&gt; connected to the private LAN served by the OpenVPN server. The VM woul=
d see<br>
&gt; just another NIC, but instead of routing the data directly to the<br>
&gt; Hypervisor&#39;s NIC (tap) or NATing it or whatever, it would go to an=
 OpenVPN<br>
&gt; client library (that wouldn&#39;t need a tun/tap device on the hypervi=
sor)<br>
&gt; which sends the data to the server over the udp connection.<br>
<br>
</div>If your hypervisor uses a tap interface, you can just have openvpn us=
e<br>
that tap interface &quot;right away&quot;. =A0So don&#39;t bridge tap0 to e=
th0 on the<br>
Hypervisor, but just have tap0 available for the VMs, and run OpenVPN<br>
with &quot;--dev tap0&quot;.<br>
<br>
This might be somewhat more expensive performance-wise - but it will<br>
be much cheaper programmer-time-wise, as all you need is already there<br>
and well-tested :-)<br>
<span><font color=3D"#888888"><br>
gert<br>
<br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 //<a href=3D"http://www.muc.de/=
~gert/" target=3D"_blank">www.muc.de/~gert/</a><br>
Gert Doering - Munich, Germany =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 <a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1711...=
96...</a><br>
fax: <a href=3D"tel:%2B49-89-35655025" value=3D"+498935655025" target=3D"_b=
lank">+49-89-35655025</a> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<a=
 href=3D"mailto:gert@...1297..." target=3D"_blank">gert@...1297...</a><br>


</font></span></blockquote></div><br>
</div>

--0015173fe5c844492a04bfb80d09--

