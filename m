MIME-Version: 1.0
In-Reply-To: <20120511064110.GU1359@...1296...>
References: <CAArKS8hPVLQSNrX4HtB+6UA+UU-63PmyN0BNmFuPdu4W0ZFEMw@...278...>
	<20120508073716.GM1359@...1296...>
	<CAArKS8gibawt-LNQws_7iiewyhAkH6TborXMiamsn1WqbLSr4g@...278...>
	<20120511064110.GU1359@...1296...>
From: Tom Kent <lists@...1718...>
Date: Fri, 11 May 2012 16:29:17 -0400
Message-ID: <CAArKS8iRLu+01e9LSs44VSy5VTBC9eBTAqf7C-+vaNRmhgD+Yg@...278...>
Content-Type: multipart/alternative; boundary=00151748e0ec64e21104bfc8984e
Subject: Re: [Openvpn-devel] OpenVPN in the Hypervisor
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--00151748e0ec64e21104bfc8984e
Content-Type: text/plain; charset=ISO-8859-1

Thanks for making that clear, it worked great...not sure why I was confused
about it in the other message.

I was able to get everything up and running. I've documented my adventures
here:
http://teeks99.com/sys/doku.php?id=openvpn_vm_segregated_net

Thanks for all the input,
Tom

On Fri, May 11, 2012 at 2:41 AM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Thu, May 10, 2012 at 08:45:04PM -0400, Tom Kent wrote:
> > The other thing I tried was to have openvpn up and running, then to
> attach
> > the VM to the tap0 device that it created...that ended with this error:
> > libvirtError: internal error Failed to add tap interface to bridge. tap0
> is
> > not a bridge device
>
> Try what David suggested: creating a bridge device.
>
> Start OpenVPN with "tap0", then run
>
>  "brctl addbr br0"
>  "brctl addif br0 tap0"
>
> and then have libvirt attach to br0.
>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
>                                                           //
> www.muc.de/~gert/
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025
> gert@...1297...
>

--00151748e0ec64e21104bfc8984e
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks for making that clear, it worked great...not sure why I was confused=
 about it in the other message.<div><br></div><div>I was able to get everyt=
hing up and running. I&#39;ve documented my adventures here:</div><div><a h=
ref=3D"http://teeks99.com/sys/doku.php?id=3Dopenvpn_vm_segregated_net">http=
://teeks99.com/sys/doku.php?id=3Dopenvpn_vm_segregated_net</a></div>

<div><br></div><div>Thanks for all the input,</div><div>Tom<br><br><div cla=
ss=3D"gmail_quote">On Fri, May 11, 2012 at 2:41 AM, Gert Doering <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1386...=
296...</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi,<br>
<div class=3D"im"><br>
On Thu, May 10, 2012 at 08:45:04PM -0400, Tom Kent wrote:<br>
&gt; The other thing I tried was to have openvpn up and running, then to at=
tach<br>
&gt; the VM to the tap0 device that it created...that ended with this error=
:<br>
&gt; libvirtError: internal error Failed to add tap interface to bridge. ta=
p0 is<br>
&gt; not a bridge device<br>
<br>
</div>Try what David suggested: creating a bridge device.<br>
<br>
Start OpenVPN with &quot;tap0&quot;, then run<br>
<br>
 =A0&quot;brctl addbr br0&quot;<br>
 =A0&quot;brctl addif br0 tap0&quot;<br>
<br>
and then have libvirt attach to br0.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
gert<br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 //<a href=3D"http://www.muc.de/=
~gert/" target=3D"_blank">www.muc.de/~gert/</a><br>
Gert Doering - Munich, Germany =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 <a href=3D"mailto:gert@...1296...">gert@...1296...</a><br>
fax: <a href=3D"tel:%2B49-89-35655025" value=3D"+498935655025">+49-89-35655=
025</a> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<a href=3D"mailto:ge=
rt@...1297...">gert@...1297...</a><br>
</div></div></blockquote></div><br></div>

--00151748e0ec64e21104bfc8984e--

