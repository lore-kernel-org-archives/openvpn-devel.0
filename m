MIME-Version: 1.0
In-Reply-To: <567E60A9.6020006@...1856...>
References: <1450123758-31641-1-git-send-email-steffan@...1856...>
	<566F5B01.8020109@...2080...>
	<20151215075312.GN24952@...1296...>
	<5670890D.7050501@...1147...>
	<CAA1AbxJbKeLqeDgBVLJ4HB22NPv+rbL=nB6bXiTqv+d_BLuRbg@...278...>
	<567AB995.70204@...1147...> <20151226091900.GU24952@...1296...>
	<567E60A9.6020006@...1856...>
Date: Sat, 2 Jan 2016 21:14:21 +0300
Message-ID: <CAFHpkQEiJevqD7+jQ0+MdFh2Q0XmbFR3=8vTeAYz6meH1pFGAA@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Content-Type: multipart/alternative; boundary=001a11c3783266eb3805285ddbab
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

--001a11c3783266eb3805285ddbab
Content-Type: text/plain; charset=UTF-8

also, does it make sence to perform unit testing on build like

setup server with user/password auth on localhost, connect to is using
client, see whether it is ok....

?

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

--001a11c3783266eb3805285ddbab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>also, does it make sence to perform unit testing on b=
uild like<br><br></div>setup server with user/password auth on localhost, c=
onnect to is using client, see whether it is ok....<br><br>?<br></div><div =
class=3D"gmail_extra"><br><div class=3D"gmail_quote">2015-12-26 12:40 GMT+0=
3:00 Steffan Karger <span dir=3D"ltr">&lt;<a href=3D"mailto:steffan@...2111...=
..." target=3D"_blank">steffan@...1856...</a>&gt;</span>:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">On 26-12-15 10:19, Gert Doering wrote:<br>
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
ACK, much wanted functionality and code looks good.<br>
<br>
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
</blockquote></div><br></div>

--001a11c3783266eb3805285ddbab--

