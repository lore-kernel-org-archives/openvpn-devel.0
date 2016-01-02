MIME-Version: 1.0
In-Reply-To: <567E60A9.6020006@...1856...>
References: <1450123758-31641-1-git-send-email-steffan@...1856...>
	<566F5B01.8020109@...2080...>
	<20151215075312.GN24952@...1296...>
	<5670890D.7050501@...1147...>
	<CAA1AbxJbKeLqeDgBVLJ4HB22NPv+rbL=nB6bXiTqv+d_BLuRbg@...278...>
	<567AB995.70204@...1147...> <20151226091900.GU24952@...1296...>
	<567E60A9.6020006@...1856...>
Date: Sat, 2 Jan 2016 21:11:05 +0300
Message-ID: <CAFHpkQHvDRP8vgBBjBbnf8GJJbk8OzcVcgXxf=u7zMTHqzFw5Q@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Content-Type: multipart/alternative; boundary=001a114028a6b6389905285dcfd3
Subject: Re: [Openvpn-devel] [PATCH] Warn user if their certificate has
	expired
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

--001a114028a6b6389905285dcfd3
Content-Type: text/plain; charset=UTF-8

I'm getting "segmentation fault" after that commit.
well, I suspect you beleive that user _always_ has client cert, which is
not true.

obviously, for preshared keys there''s no user cert, and for user/password
auth there's also no user cert (which is our case)

is Valgrind I see the following:

https://community.openvpn.net/openvpn/ticket/644#ticket

==19381== Invalid read of size 8
==19381==    at 0x487454: tls_ctx_check_cert_time (ssl_openssl.c:368)
==19381==    by 0x47F619: init_ssl (ssl.c:571)
==19381==    by 0x420F45: do_init_crypto_tls_c1 (init.c:2160)
==19381==    by 0x4211F6: do_init_crypto_tls (init.c:2240)
==19381==    by 0x42197B: do_init_crypto (init.c:2428)
==19381==    by 0x423C92: init_instance (init.c:3550)
==19381==    by 0x423855: init_instance_handle_signals (init.c:3405)
==19381==    by 0x443788: tunnel_point_to_point (openvpn.c:70)
==19381==    by 0x443BAD: openvpn_main (openvpn.c:270)
==19381==    by 0x443CC0: main (openvpn.c:345)
==19381==  Address 0x0 is not stack'd, malloc'd or (recently) free'd


does that mean "I'm trying to read a cert which does not exist" ?


I investigated, I'm getting crash dumps since
https://github.com/OpenVPN/openvpn/commit/091edd8e2996867447eeb665af957547aa8b3107

can you please fix that before 2.3.10 ?


2015-12-26 12:40 GMT+03:00 Steffan Karger <steffan@...1856...>:

> On 26-12-15 10:19, Gert Doering wrote:
> > On Wed, Dec 23, 2015 at 04:11:17PM +0100, Jan Just Keijser wrote:
> >> I justed wanted to get back to this one one more time: attached is a
> >> patch to ssl_openssl.c that works in combination with Steffan's patch to
> >> check for expired certificates. This new patch-patch works on my CentOS
> >> 6 (openssl 1.0.1e) box :)  This patch was done against the v2.3.9 code
> >> base and I have no clue how to get it into proper git formatting ;)
> >
> > Great discovery :-) - and it nicely works for me:
> >
> > Sat Dec 26 10:11:14 2015 OpenVPN 2.3_git
> [git:ssl-expire/0f7319906a9dff58+] amd64-unknown-freebsd7.4 [SSL (OpenSSL)]
> [LZO] [LZ4] [MH] [IPv6] built on Dec 26 2015
> > Sat Dec 26 10:11:14 2015 library versions: OpenSSL 0.9.8q 2 Dec 2010,
> LZO 2.04
> > Sat Dec 26 10:11:16 2015 WARNING: Your certificate has expired!
> >
> > this is about as old as it gets - thanks a lot.  Mogrified into a patch
> > against git master with the SSL_free() moved to the right place attached
> > below, for Steffan to ACK.
>
> ACK, much wanted functionality and code looks good.
>
> -Steffan
>
>
> ------------------------------------------------------------------------------
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--001a114028a6b6389905285dcfd3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div>I&#39;m getting &quot;s=
egmentation fault&quot; after that commit.<br></div>well, I suspect you bel=
eive that user _always_ has client cert, which is not true.<br><br></div>ob=
viously, for preshared keys there&#39;&#39;s no user cert, and for user/pas=
sword auth there&#39;s also no user cert (which is our case)<br><br></div>i=
s Valgrind I see the following:<br><br><a href=3D"https://community.openvpn=
.net/openvpn/ticket/644#ticket">https://community.openvpn.net/openvpn/ticke=
t/644#ticket</a><br><br>=3D=3D19381=3D=3D Invalid read of size 8<br>=3D=3D1=
9381=3D=3D=C2=A0=C2=A0=C2=A0 at 0x487454: tls_ctx_check_cert_time (ssl_open=
ssl.c:368)<br>=3D=3D19381=3D=3D=C2=A0=C2=A0=C2=A0 by 0x47F619: init_ssl (ss=
l.c:571)<br>=3D=3D19381=3D=3D=C2=A0=C2=A0=C2=A0 by 0x420F45: do_init_crypto=
_tls_c1 (init.c:2160)<br>=3D=3D19381=3D=3D=C2=A0=C2=A0=C2=A0 by 0x4211F6: d=
o_init_crypto_tls (init.c:2240)<br>=3D=3D19381=3D=3D=C2=A0=C2=A0=C2=A0 by 0=
x42197B: do_init_crypto (init.c:2428)<br>=3D=3D19381=3D=3D=C2=A0=C2=A0=C2=
=A0 by 0x423C92: init_instance (init.c:3550)<br>=3D=3D19381=3D=3D=C2=A0=C2=
=A0=C2=A0 by 0x423855: init_instance_handle_signals (init.c:3405)<br>=3D=3D=
19381=3D=3D=C2=A0=C2=A0=C2=A0 by 0x443788: tunnel_point_to_point (openvpn.c=
:70)<br>=3D=3D19381=3D=3D=C2=A0=C2=A0=C2=A0 by 0x443BAD: openvpn_main (open=
vpn.c:270)<br>=3D=3D19381=3D=3D=C2=A0=C2=A0=C2=A0 by 0x443CC0: main (openvp=
n.c:345)<br>=3D=3D19381=3D=3D=C2=A0 Address 0x0 is not stack&#39;d, malloc&=
#39;d or (recently) free&#39;d<br><br><br></div>does that mean &quot;I&#39;=
m trying to read a cert which does not exist&quot; ?<br></div><br><br></div=
>I investigated, I&#39;m getting crash dumps since <a href=3D"https://githu=
b.com/OpenVPN/openvpn/commit/091edd8e2996867447eeb665af957547aa8b3107">http=
s://github.com/OpenVPN/openvpn/commit/091edd8e2996867447eeb665af957547aa8b3=
107</a><br><br></div>can you please fix that before 2.3.10 ?<br><div><div><=
div><div><br></div></div></div></div></div><div class=3D"gmail_extra"><br><=
div class=3D"gmail_quote">2015-12-26 12:40 GMT+03:00 Steffan Karger <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:steffan@...1856..." target=3D"_blank">stef=
fan@...1856...</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span cl=
ass=3D"">On 26-12-15 10:19, Gert Doering wrote:<br>
&gt; On Wed, Dec 23, 2015 at 04:11:17PM +0100, Jan Just Keijser wrote:<br>
&gt;&gt; I justed wanted to get back to this one one more time: attached is=
 a<br>
&gt;&gt; patch to ssl_openssl.c that works in combination with Steffan&#39;=
s patch to<br>
&gt;&gt; check for expired certificates. This new patch-patch works on my C=
entOS<br>
&gt;&gt; 6 (openssl 1.0.1e) box :)=C2=A0 This patch was done against the v2=
.3.9 code<br>
&gt;&gt; base and I have no clue how to get it into proper git formatting ;=
)<br>
&gt;<br>
&gt; Great discovery :-) - and it nicely works for me:<br>
&gt;<br>
&gt; Sat Dec 26 10:11:14 2015 OpenVPN 2.3_git [git:ssl-expire/0f7319906a9df=
f58+] amd64-unknown-freebsd7.4 [SSL (OpenSSL)] [LZO] [LZ4] [MH] [IPv6] buil=
t on Dec 26 2015<br>
&gt; Sat Dec 26 10:11:14 2015 library versions: OpenSSL 0.9.8q 2 Dec 2010, =
LZO 2.04<br>
&gt; Sat Dec 26 10:11:16 2015 WARNING: Your certificate has expired!<br>
&gt;<br>
&gt; this is about as old as it gets - thanks a lot.=C2=A0 Mogrified into a=
 patch<br>
&gt; against git master with the SSL_free() moved to the right place attach=
ed<br>
&gt; below, for Steffan to ACK.<br>
<br>
</span>ACK, much wanted functionality and code looks good.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
-Steffan<br>
<br>
---------------------------------------------------------------------------=
---<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</div></div></blockquote></div><br></div>

--001a114028a6b6389905285dcfd3--

