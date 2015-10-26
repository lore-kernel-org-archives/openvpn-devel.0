MIME-Version: 1.0
In-Reply-To: <1445816672.3405.17.camel@...1866...>
References: <1445597397.4113.184.camel@...1866...>
	<CAA1Abx+fvhCoDNhKF44UmwZm7Xm-k_+gQ8gTCwCrw2UDtdPsDg@...278...>
	<CAA1Abx+z_BmrZgR-2MFBmqFS8QK6LOeN1FDDfZSGQw1_EUgq4w@...278...>
	<1445816672.3405.17.camel@...1866...>
Date: Mon, 26 Oct 2015 01:02:00 +0100
Message-ID: <CAA1AbxLVK6r-_YKARZSOO_naqyLZXYmSj7eeUqsicX6gJ47tBg@...278...>
From: Steffan Karger <steffan@...1856...>
Content-Type: multipart/alternative; boundary=001a114d7256ade7cd0522f6abb9
Subject: Re: [Openvpn-devel] [RFC] --passtos default on/off, and IPv6.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Woodhouse <dwmw2@...1866...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a114d7256ade7cd0522f6abb9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 26 Oct 2015 00:44, "David Woodhouse" <dwmw2@...1866...> wrote:
>
> On Mon, 2015-10-26 at 00:15 +0100, Steffan Karger wrote:
> > On Mon, Oct 26, 2015 at 12:09 AM, Steffan Karger <steffan@...1856...>
wrote:
> > > For
> > > covert channels, it means 23 possible values per 1500-byte packet, or
> > > ~5 bits for BF, and 12 possible values (~4 bits) for AES-CBC. That is
> > > still less than the 8 bits QoS/ToS.
> >
> > Grmbl, at the moment I hit send I realize I messed up bytes and bits
> > in this back-of-the-envelope calculation.  For 1500-bytes packets,
> > there are 187 possible lengths (~8 bits) for BF-CBC, and 93 possible
> > lengths (~7 bits) for AES-CBC.  So just barely less than QoS/ToS, but
> > --passtos would still double the bandwidth.
>
> To be honest, you'd lost me a little before that anyway. The design
> goals of a VPN deployment typically *don't* include blocking that kind
> of covert channel anyway =E2=80=94 and if it did, then we should all pack=
 up
> and go home, because we've failed.

Well, I will admit that is the case for the large majority of OpenVPN use
cases, in particular the road warriors.  But there are also use cases, such
as connecting otherwise isolated networks, where this *is* a concern.

> It's not so much "I'll just disable the brakes", but more "there's this
> burned-out wreck by the side of the road and three of its wheels are
> missing; they probably won't notice if I take the fourth".

Heh, that did make me smile :)

> I'm actually *more* interested in the potential for incompatibilities
> if we start setting the TOS bits =E2=80=94 as we saw with stupid firewalls
> dropping packets when ECN was in use. That sounds like a much more
> reasonable argument for not doing --passtos by default, although even
> that is somewhat diminished these days =E2=80=94 I think most such firewa=
lls
> have been fixed now.

I am actually very interested in this part too, but lack the experience to
make any statements here.  *waiting for Gert and/or Arne to chime in*

-Steffan

--001a114d7256ade7cd0522f6abb9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On 26 Oct 2015 00:44, &quot;David Woodhouse&quot; &lt;<a href=3D"mailto:dwm=
w2@...1866...">dwmw2@...1866...</a>&gt; wrote:<br>
&gt;<br>
&gt; On Mon, 2015-10-26 at 00:15 +0100, Steffan Karger wrote:<br>
&gt; &gt; On Mon, Oct 26, 2015 at 12:09 AM, Steffan Karger &lt;<a href=3D"m=
ailto:steffan@...1856...">steffan@...1856...</a>&gt; wrote:<br>
&gt; &gt; &gt; For<br>
&gt; &gt; &gt; covert channels, it means 23 possible values per 1500-byte p=
acket, or<br>
&gt; &gt; &gt; ~5 bits for BF, and 12 possible values (~4 bits) for AES-CBC=
. That is<br>
&gt; &gt; &gt; still less than the 8 bits QoS/ToS.<br>
&gt; &gt;<br>
&gt; &gt; Grmbl, at the moment I hit send I realize I messed up bytes and b=
its<br>
&gt; &gt; in this back-of-the-envelope calculation.=C2=A0 For 1500-bytes pa=
ckets,<br>
&gt; &gt; there are 187 possible lengths (~8 bits) for BF-CBC, and 93 possi=
ble<br>
&gt; &gt; lengths (~7 bits) for AES-CBC.=C2=A0 So just barely less than QoS=
/ToS, but<br>
&gt; &gt; --passtos would still double the bandwidth.<br>
&gt;<br>
&gt; To be honest, you&#39;d lost me a little before that anyway. The desig=
n<br>
&gt; goals of a VPN deployment typically *don&#39;t* include blocking that =
kind<br>
&gt; of covert channel anyway =E2=80=94 and if it did, then we should all p=
ack up<br>
&gt; and go home, because we&#39;ve failed.</p>
<p dir=3D"ltr">Well, I will admit that is the case for the large majority o=
f OpenVPN use cases, in particular the road warriors.=C2=A0 But there are a=
lso use cases, such as connecting otherwise isolated networks, where this *=
is* a concern.</p>
<p dir=3D"ltr">&gt; It&#39;s not so much &quot;I&#39;ll just disable the br=
akes&quot;, but more &quot;there&#39;s this<br>
&gt; burned-out wreck by the side of the road and three of its wheels are<b=
r>
&gt; missing; they probably won&#39;t notice if I take the fourth&quot;.</p>
<p dir=3D"ltr">Heh, that did make me smile :) </p>
<p dir=3D"ltr">&gt; I&#39;m actually *more* interested in the potential for=
 incompatibilities<br>
&gt; if we start setting the TOS bits =E2=80=94 as we saw with stupid firew=
alls<br>
&gt; dropping packets when ECN was in use. That sounds like a much more<br>
&gt; reasonable argument for not doing --passtos by default, although even<=
br>
&gt; that is somewhat diminished these days =E2=80=94 I think most such fir=
ewalls<br>
&gt; have been fixed now.</p>
<p dir=3D"ltr">I am actually very interested in this part too, but lack the=
 experience to make any statements here.=C2=A0 *waiting for Gert and/or Arn=
e to chime in*</p>
<p dir=3D"ltr">-Steffan </p>

--001a114d7256ade7cd0522f6abb9--

