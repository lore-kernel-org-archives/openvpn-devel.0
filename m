MIME-Version: 1.0
References: <CAAUX2SWGzsjeCxjQ1C+zh8+qKXL3mUv5AJqEd6rM=A8f-Q1dBA@...278...>
 <a2152b6e-1429-6637-aef8-7eaf527316e3@...2181...>
 <CAAUX2SWEOk5TC1J9jBoiS6=chMbY_6DTMvPV1J07d3L26k9b0A@...278...>
 <228b401e-e700-447c-4c30-29d28cb22585@...2181...>
 <CAAUX2SX-90sKC-+MBQ9ycimK0YvHZC0rMjVKMKH_oFSDW=x5Tw@...278...>
 <8a1dc0cf-61d4-2ded-1c51-ccb755ba7ef9@...2181...>
In-Reply-To: <8a1dc0cf-61d4-2ded-1c51-ccb755ba7ef9@...2181...>
From: Tony He <huangya90@...277...>
Date: Thu, 26 Nov 2020 08:46:15 +0800
Message-ID: <CAAUX2SUqFRWcP+aTXUaW2+5zK6AGcAO51-rbcikexKXVPsc84g@...278...>
Content-Type: multipart/alternative; boundary="000000000000b8ab4505b4f7df1c"
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

--000000000000b8ab4505b4f7df1c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>OpenSSL directly talks to the crypto engine via a proprietary interface
>that the FW/driver exposes to userspace. The *data* flow does not cross
>the linux kernel crypto API

No, OpenSSL doesn't directly talk to the  crypto engine via a proprietary
interface that the FW/driver exposes to userspace.
"cryptodev engine" is NOT the "HW engine" chip vendor provides. It's a
common interface and its source is not from
chip vendor. Please refer to:
https://github.com/cryptodev-linux/cryptodev-linux
https://openwrt.org/docs/techref/hardware/cryptographic.hardware.accelerato=
rs

Tony


Antonio Quartulli <a@...2181...> =E4=BA=8E2020=E5=B9=B411=E6=9C=8826=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8812:19=E5=86=99=E9=81=93=EF=BC=9A

> Hi Tony,
>
> > OpenVPN-> openssl->crypodev engine->cryptodev-linux->Linux kernel crypto
> API->HW engine crypto API-> HW engine driver-> HW engine
>
> Now I understand better what you have in mind.
>
> To the best of my knowledge, this is not how it works.
>
> OpenSSL directly talks to the crypto engine via a proprietary interface
> that the FW/driver exposes to userspace. The *data* flow does not cross
> the linux kernel crypto API.
>
> Moist of the time this special interfaces are made "to work with openssl
> only", so I am not even sure how the kernel API could use it.
>
> Do you have any pointer saying otherwise?
>
>
> --
> Antonio Quartulli
>
>

--000000000000b8ab4505b4f7df1c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt;OpenSSL directly talks to the crypto engine via a prop=
rietary interface<br>&gt;that the FW/driver exposes to userspace. The *data=
* flow does not cross<br>&gt;the linux kernel crypto API<div><br></div><div=
>No, OpenSSL doesn&#39;t directly talk to the=C2=A0=C2=A0crypto engine via =
a proprietary interface=C2=A0that the FW/driver exposes to userspace.</div>=
<div>&quot;cryptodev engine&quot; is NOT the &quot;HW engine&quot; chip ven=
dor provides. It&#39;s a common interface and its source is not from</div><=
div>chip vendor. Please refer to:</div><div><a href=3D"https://github.com/c=
ryptodev-linux/cryptodev-linux">https://github.com/cryptodev-linux/cryptode=
v-linux</a></div><div><a href=3D"https://openwrt.org/docs/techref/hardware/=
cryptographic.hardware.accelerators">https://openwrt.org/docs/techref/hardw=
are/cryptographic.hardware.accelerators</a></div><div><br></div><div>Tony=
=C2=A0</div><div>=C2=A0</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">Antonio Quartulli &lt;a@...2181...&gt; =E4=BA=
=8E2020=E5=B9=B411=E6=9C=8826=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=88=
12:19=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Hi Tony,<br>
<br>
&gt; OpenVPN-&gt; openssl-&gt;crypodev engine-&gt;cryptodev-linux-&gt;Linux=
 kernel crypto API-&gt;HW engine crypto API-&gt; HW engine driver-&gt; HW e=
ngine<br>
<br>
Now I understand better what you have in mind.<br>
<br>
To the best of my knowledge, this is not how it works.<br>
<br>
OpenSSL directly talks to the crypto engine via a proprietary interface<br>
that the FW/driver exposes to userspace. The *data* flow does not cross<br>
the linux kernel crypto API.<br>
<br>
Moist of the time this special interfaces are made &quot;to work with opens=
sl<br>
only&quot;, so I am not even sure how the kernel API could use it.<br>
<br>
Do you have any pointer saying otherwise?<br>
<br>
<br>
-- <br>
Antonio Quartulli<br>
<br>
</blockquote></div>

--000000000000b8ab4505b4f7df1c--

