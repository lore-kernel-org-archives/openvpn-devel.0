MIME-Version: 1.0
References: <CAAUX2SWGzsjeCxjQ1C+zh8+qKXL3mUv5AJqEd6rM=A8f-Q1dBA@...278...>
 <a2152b6e-1429-6637-aef8-7eaf527316e3@...2181...>
 <CAAUX2SWEOk5TC1J9jBoiS6=chMbY_6DTMvPV1J07d3L26k9b0A@...278...>
 <228b401e-e700-447c-4c30-29d28cb22585@...2181...>
 <CAAUX2SX-90sKC-+MBQ9ycimK0YvHZC0rMjVKMKH_oFSDW=x5Tw@...278...>
 <8a1dc0cf-61d4-2ded-1c51-ccb755ba7ef9@...2181...>
 <CAAUX2SUqFRWcP+aTXUaW2+5zK6AGcAO51-rbcikexKXVPsc84g@...278...>
 <f34acee4-d928-509e-5bb3-9900c1578d5b@...2181...>
In-Reply-To: <f34acee4-d928-509e-5bb3-9900c1578d5b@...2181...>
From: Tony He <huangya90@...277...>
Date: Thu, 26 Nov 2020 16:53:14 +0800
Message-ID: <CAAUX2SXreiLnX5z0X9-oiKPJXT75=VjkdKsEb_taPHBGsP-39Q@...278...>
Content-Type: multipart/alternative; boundary="00000000000054344d05b4fead41"
Subject: Re: [Openvpn-devel] [ovpn-dco] Is cbc-hmac supported?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: lev@...515..., openvpn-devel@lists.sourceforge.net

--00000000000054344d05b4fead41
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Antonio,

Understood.  We have dicussed this in the OpenWRT forum. Maybe some kind
OpenWRT guys will implement  aead hmac-sha256-cbc-aes
for ovpn-dco module in the future.

https://forum.openwrt.org/t/ipq806x-nss-drivers/12613/2180?u=3Dtony.he

Tony

Antonio Quartulli <a@...2181...> =E4=BA=8E2020=E5=B9=B411=E6=9C=8826=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=883:49=E5=86=99=E9=81=93=EF=BC=9A

> Hi Tony,
>
> On 26/11/2020 01:46, Tony He wrote:
> >>OpenSSL directly talks to the crypto engine via a proprietary interface
> >>that the FW/driver exposes to userspace. The *data* flow does not cross
> >>the linux kernel crypto API
> >
> > No, OpenSSL doesn't directly talk to the  crypto engine via a
> > proprietary interface that the FW/driver exposes to userspace.
> > "cryptodev engine" is NOT the "HW engine" chip vendor provides. It's a
> > common interface and its source is not from
> > chip vendor. Please refer to:
> > https://github.com/cryptodev-linux/cryptodev-linux
> > <https://github.com/cryptodev-linux/cryptodev-linux>
> >
> https://openwrt.org/docs/techref/hardware/cryptographic.hardware.accelera=
tors
> > <
> https://openwrt.org/docs/techref/hardware/cryptographic.hardware.accelera=
tors
> >
>
> Thanks for clarifying!
> I thought you were talking about the crypto engine offload provided by
> OpenSSL via vendor library.
>
> So, if I understand this correctly, what you are saying is that the
> vendor provides kernel patches in order to add HW support to the kernel
> crypto API for an architecture that is normally not supported by the
> upstream kernel. Then cryptodev is used to allow userspace to use the
> kernel API.
>
> This said, I am sorry, but I am not sure we should continue this
> discussion any further, because as of now we have no plan to introduce
> yet another crypto family in ovpn-dco.
>
> One of the goal with ovpn-dco is to leave behind the legacy from
> openvpn2 in userspace and focus on those features we believe to be
> "state of the art". This is why we decided to only support AEAD with
> only AES-GCM and CHACHA20POLY1305, DATA_V2 only, etc.
>
> Focus is on keeping the code simple and ensure it can be accepted
> upstream in the Linux kernel quickly.
>
> It was an hard decision to make, but the whole group decided to take
> this direction. People that want to use different
> configurations/settings will still be able to do so by using openvpn2 in
> userspace, as it happened until now.
>
>
> Cheers,
>
>
> >
> > Tony
> >
> >
> > Antonio Quartulli <a@...2181...> =E4=BA=8E2020=E5=B9=B411=E6=9C=8826=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8812:19=E5=86=99=E9=81=93=EF=BC=9A
> >
> >     Hi Tony,
> >
> >     > OpenVPN-> openssl->crypodev engine->cryptodev-linux->Linux kernel
> >     crypto API->HW engine crypto API-> HW engine driver-> HW engine
> >
> >     Now I understand better what you have in mind.
> >
> >     To the best of my knowledge, this is not how it works.
> >
> >     OpenSSL directly talks to the crypto engine via a proprietary
> interface
> >     that the FW/driver exposes to userspace. The *data* flow does not
> cross
> >     the linux kernel crypto API.
> >
> >     Moist of the time this special interfaces are made "to work with
> openssl
> >     only", so I am not even sure how the kernel API could use it.
> >
> >     Do you have any pointer saying otherwise?
> >
> >
> >     --
> >     Antonio Quartulli
> >
>
> --
> Antonio Quartulli
>

--00000000000054344d05b4fead41
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Antonio,<div><br></div><div>Understood.=C2=A0 We have d=
icussed this in the OpenWRT forum. Maybe some kind OpenWRT guys will implem=
ent=C2=A0 aead hmac-sha256-cbc-aes</div><div>for ovpn-dco module in the=C2=
=A0future.=C2=A0</div><div><br></div><div><a href=3D"https://forum.openwrt.=
org/t/ipq806x-nss-drivers/12613/2180?u=3Dtony.he">https://forum.openwrt.org=
/t/ipq806x-nss-drivers/12613/2180?u=3Dtony.he</a><br></div><div><br></div><=
div>Tony</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">Antonio Quartulli &lt;a@...2181...&gt; =E4=BA=8E2020=E5=B9=
=B411=E6=9C=8826=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=883:49=E5=86=99=
=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">Hi Tony,<br>
<br>
On 26/11/2020 01:46, Tony He wrote:<br>
&gt;&gt;OpenSSL directly talks to the crypto engine via a proprietary inter=
face<br>
&gt;&gt;that the FW/driver exposes to userspace. The *data* flow does not c=
ross<br>
&gt;&gt;the linux kernel crypto API<br>
&gt; <br>
&gt; No, OpenSSL doesn&#39;t directly talk to the=C2=A0=C2=A0crypto engine =
via a<br>
&gt; proprietary interface=C2=A0that the FW/driver exposes to userspace.<br>
&gt; &quot;cryptodev engine&quot; is NOT the &quot;HW engine&quot; chip ven=
dor provides. It&#39;s a<br>
&gt; common interface and its source is not from<br>
&gt; chip vendor. Please refer to:<br>
&gt; <a href=3D"https://github.com/cryptodev-linux/cryptodev-linux" rel=3D"=
noreferrer" target=3D"_blank">https://github.com/cryptodev-linux/cryptodev-=
linux</a><br>
&gt; &lt;<a href=3D"https://github.com/cryptodev-linux/cryptodev-linux" rel=
=3D"noreferrer" target=3D"_blank">https://github.com/cryptodev-linux/crypto=
dev-linux</a>&gt;<br>
&gt; <a href=3D"https://openwrt.org/docs/techref/hardware/cryptographic.har=
dware.accelerators" rel=3D"noreferrer" target=3D"_blank">https://openwrt.or=
g/docs/techref/hardware/cryptographic.hardware.accelerators</a><br>
&gt; &lt;<a href=3D"https://openwrt.org/docs/techref/hardware/cryptographic=
.hardware.accelerators" rel=3D"noreferrer" target=3D"_blank">https://openwr=
t.org/docs/techref/hardware/cryptographic.hardware.accelerators</a>&gt;<br>
<br>
Thanks for clarifying!<br>
I thought you were talking about the crypto engine offload provided by<br>
OpenSSL via vendor library.<br>
<br>
So, if I understand this correctly, what you are saying is that the<br>
vendor provides kernel patches in order to add HW support to the kernel<br>
crypto API for an architecture that is normally not supported by the<br>
upstream kernel. Then cryptodev is used to allow userspace to use the<br>
kernel API.<br>
<br>
This said, I am sorry, but I am not sure we should continue this<br>
discussion any further, because as of now we have no plan to introduce<br>
yet another crypto family in ovpn-dco.<br>
<br>
One of the goal with ovpn-dco is to leave behind the legacy from<br>
openvpn2 in userspace and focus on those features we believe to be<br>
&quot;state of the art&quot;. This is why we decided to only support AEAD w=
ith<br>
only AES-GCM and CHACHA20POLY1305, DATA_V2 only, etc.<br>
<br>
Focus is on keeping the code simple and ensure it can be accepted<br>
upstream in the Linux kernel quickly.<br>
<br>
It was an hard decision to make, but the whole group decided to take<br>
this direction. People that want to use different<br>
configurations/settings will still be able to do so by using openvpn2 in<br>
userspace, as it happened until now.<br>
<br>
<br>
Cheers,<br>
<br>
<br>
&gt; <br>
&gt; Tony=C2=A0<br>
&gt; =C2=A0<br>
&gt; <br>
&gt; Antonio Quartulli &lt;a@...2181...&gt; =E4=BA=8E2020=E5=B9=B411=E6=9C=
=8826=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8812:19=E5=86=99=E9=81=93=
=EF=BC=9A<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi Tony,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; OpenVPN-&gt; openssl-&gt;crypodev engine-&gt;c=
ryptodev-linux-&gt;Linux kernel<br>
&gt;=C2=A0 =C2=A0 =C2=A0crypto API-&gt;HW engine crypto API-&gt; HW engine =
driver-&gt; HW engine<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Now I understand better what you have in mind.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0To the best of my knowledge, this is not how it wor=
ks.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0OpenSSL directly talks to the crypto engine via a p=
roprietary interface<br>
&gt;=C2=A0 =C2=A0 =C2=A0that the FW/driver exposes to userspace. The *data*=
 flow does not cross<br>
&gt;=C2=A0 =C2=A0 =C2=A0the linux kernel crypto API.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Moist of the time this special interfaces are made =
&quot;to work with openssl<br>
&gt;=C2=A0 =C2=A0 =C2=A0only&quot;, so I am not even sure how the kernel AP=
I could use it.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Do you have any pointer saying otherwise?<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;=C2=A0 =C2=A0 =C2=A0Antonio Quartulli<br>
&gt; <br>
<br>
-- <br>
Antonio Quartulli<br>
</blockquote></div>

--00000000000054344d05b4fead41--

