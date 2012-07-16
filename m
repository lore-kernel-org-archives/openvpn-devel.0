MIME-Version: 1.0
In-Reply-To: <CAOazyz2VF2DYrpqVmE4TWi8TD5Wy1MXdgJ+zaMC9CAjVvfO3QQ@...278...>
References: <CAEsd45RxJ4Q6kvofngZwkEUBbV3P3fNWTEMc9KksKPOdpB870Q@...278...>
	<CAOazyz3AqvSu05xSDQn=0MX-4QV-mFB1SPNh8SSVL_y3=O5R+g@...278...>
	<CAEsd45Q2VTHKu8aE0adSPCNRsRTCUCUzfPqj_tWsLQe6XHk1TQ@...278...>
	<CAOazyz29f5yG19ygoY4y0yTf2GdYTfKsW_bHTkOib2RCQqgKvQ@...278...>
	<CAEsd45SyHA=ukYxhvSCAmMRYwg6QuaqT_1eW6dFv-p078_EPZQ@...278...>
	<CAOazyz2VF2DYrpqVmE4TWi8TD5Wy1MXdgJ+zaMC9CAjVvfO3QQ@...278...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Mon, 16 Jul 2012 16:24:05 -0400
Message-ID: <CAEsd45SSA-Etr00DAuJvfdGL+hbhQPWMR_B2BC0Jyy7RboabpQ@...278...>
Content-Type: multipart/alternative; boundary=f46d044786e779734a04c4f8380b
Subject: Re: [Openvpn-devel] OpenVPN 3.3_alpha2 build problem
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>, Arne Schwabe <arne@...1740...>

--f46d044786e779734a04c4f8380b
Content-Type: text/plain; charset=UTF-8

>
> Please try:
>
> ./configure CFLAGS="-Ixxx" LDFLAGS="-Lyyy"
>
> Should be simpler.
>

Thanks. Although

LDFLAGS="-Lxxx -Lyyy -Lzzz"

builds, but it causes config to output "checking for PKCS11_HELPER... no".
I assume that if it isn't finding pkcs11-helper, then it might not
configure the build to support it. (Otherwise, what's the point of checking
for it?)

LZO_LIBS="-Lxxx" OPENSSL_LIBS="-Lyyy" PKCS11_HELPER_LIBS="-Lzzz"

builds and shows "checking for PKCS11_HELPER... yes".

LIBS="-Lxxx -Lyyy -Lzzz"

doesn't build. It gets "ld: library not found for -llzo2".

On Mon, Jul 16, 2012 at 7:24 PM, Jonathan K. Bullard
> <jkbullard@...277...> wrote:
> > Thank you, Arne and Alon -- I finally managed to get Tunnelblick
> > more-or-less built using the new build system in 2.3_alpha2.
> >
> > For the record, I had to use xxx_LIBS="-Lyyy" (not xxx_LDFLAGS) before
> > ./configure, to get it working.
> >
>

--f46d044786e779734a04c4f8380b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Please try:<br>
<br>
./configure CFLAGS=3D&quot;-Ixxx&quot; LDFLAGS=3D&quot;-Lyyy&quot;<br>
<br>
Should be simpler.<br></blockquote><div><br></div><div>Thanks. Although</di=
v></div><blockquote style=3D"margin:0 0 0 40px;border:none;padding:0px"><di=
v class=3D"gmail_quote"><div>
LDFLAGS=3D&quot;-Lxxx -Lyyy -Lzzz&quot;</div></div></blockquote><div class=
=3D"gmail_quote"><div>builds, but it causes config to output &quot;checking=
 for PKCS11_HELPER... no&quot;. I assume that if it isn&#39;t finding pkcs1=
1-helper, then it might not configure the build to support it. (Otherwise, =
what&#39;s the point of checking for it?)</div>

<div><br></div></div><blockquote style=3D"margin:0 0 0 40px;border:none;pad=
ding:0px"><div class=3D"gmail_quote"><div><div class=3D"gmail_quote"><div>L=
ZO_LIBS=3D&quot;-Lxxx&quot; OPENSSL_LIBS=3D&quot;-Lyyy&quot; PKCS11_HELPER_=
LIBS=3D&quot;-Lzzz&quot;</div>

</div></div></div></blockquote><div class=3D"gmail_quote"><div class=3D"gma=
il_quote"></div></div>builds and shows &quot;checking for PKCS11_HELPER... =
yes&quot;.<div><br></div><div><blockquote style=3D"margin:0 0 0 40px;border=
:none;padding:0px">

<div class=3D"gmail_quote"><div class=3D"gmail_quote"><div>LIBS=3D&quot;-Lx=
xx=C2=A0-Lyyy -Lzzz&quot;</div></div></div></blockquote><div class=3D"gmail=
_quote"><div>doesn&#39;t build. It gets &quot;ld: library not found for -ll=
zo2&quot;.</div>

</div><div class=3D"gmail_quote"><div class=3D"gmail_quote"><div><br></div>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">
<div><div>On Mon, Jul 16, 2012 at 7:24 PM, Jonathan K. Bullard<br>
&lt;<a href=3D"mailto:jkbullard@...277..." target=3D"_blank">jkbullard@...1665...=
77...</a>&gt; wrote:<br>
&gt; Thank you, Arne and Alon -- I finally managed to get Tunnelblick<br>
&gt; more-or-less built using the new build system in 2.3_alpha2.<br>
&gt;<br>
&gt; For the record, I had to use xxx_LIBS=3D&quot;-Lyyy&quot; (not xxx_LDF=
LAGS) before<br>
&gt; ./configure, to get it working.<br>
&gt;<br>
</div></div></blockquote></div><br>
</div>

--f46d044786e779734a04c4f8380b--

