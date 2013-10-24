MIME-Version: 1.0
In-Reply-To: <52685102.4050201@...1850...>
References: <52685102.4050201@...1850...>
Date: Thu, 24 Oct 2013 16:35:20 +0800
Message-ID: <CABDcBMnyF-wnH8=VudFuap_468N87_WDmxxHTO=3v-FX3+zCUA@...278...>
From: Steve Cook <stevecookhk@...277...>
Content-Type: multipart/alternative; boundary=001a1134a332a413da04e97883b8
Subject: Re: [Openvpn-devel] Linux client cant connect through socks,
 proxy - any known workaround?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Thomas Murach <murach@...1850...>, gert@...1296...
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a1134a332a413da04e97883b8
Content-Type: text/plain; charset=ISO-8859-1

Hi All

Thanks for the suggestions..

1) OK, I'm feeling dumb. I guess its a case of RTFS.

Based on the source here:
https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/socks.c, OpenVPN
only supports SOCKS5..
this doesn't appear to be mentioned anywhere in the documentation. My proxy
is a SOCKS4 proxy, and hence expects a longer header than is being sent,
resulting in timeouts.

I'd suggest updating the man page to explicitly say that only SOCKS5 is
supported - can someone point me in the direction of the file, and i'll
submit a git push?


2) I've now rewritten the proxy that I'm using to support SOCKS5, and
tested that it runs fine with curl --socks5. However when I try to tunnel
OpenVPN through it, I get the following error:

Oct 24 16:06:53 master rsyslogd-2177: imuxsock begins to drop messages from
pid 2331 due to rate-limiting
Oct 24 16:06:53 master ovpn-client[2332]: Attempting to establish TCP
connection with [AF_INET]192.168.147.82:110 [nonblock]
Oct 24 16:06:54 master ovpn-client[2332]: TCP connection established with
[AF_INET]192.168.147.82:110
Oct 24 16:06:54 master ovpn-client[2332]: TCPv4_CLIENT link local: [undef]
Oct 24 16:06:54 master ovpn-client[2332]: TCPv4_CLIENT link remote:
[AF_INET]192.168.147.82:110
Oct 24 16:06:54 master ovpn-client[2332]: WARNING: Bad encapsulated packet
length from peer (43520), which must be > 0 and <= 1544 -- please ensure
that --tun-mtu or --link-mtu is equal on both peers -- this condition could
also indicate a possible active attack on the TCP link -- [Attempting
restart...]
Oct 24 16:06:54 master ovpn-client[2332]: Connection reset, restarting [0]


Is there something special I need to implement in the SOCKS5 proxy to fix
this link issue? FWIW the proxy itself is running under Windows (although
both client & server are running under Ubuntu Linux), but 43520 bytes (42k)
seems a strange number.

I've already tried setting link-mtu (and then tun-mtu) to this number on
both client & server, but after that it doesn't seem to connect at all.

thanks
Steve




On Thu, Oct 24, 2013 at 6:43 AM, Thomas Murach
<murach@...1850...>wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Hi,
>
> in my case, I had to add the following options:
>
> pull
> tls-client
> persist-tun
> comp-lzo
>
> I'm quite sure that tls-client is the one you need. The others are
> specific to your setup. I hope that this helps.
>
> Cheers,
> Thomas
>
>
> Hi, On Wed, Oct 23, 2013 at 10:50:11PM +0800, Steve Cook wrote:
> > I can't get openvpn to connect through my socks proxy server, and
> searching
> > around seem to find other users with the same problem, but no
> > known solution.
>
> It "should" work.  Does the Android client work?
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.19 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/
>
> iQIcBAEBAgAGBQJSaFECAAoJEKQl1saKseE5nTkP/R50DTsaw2U/iYYY0h6IK6KP
> zSrGX+XF5cw2dnXVHY/NjYL19kCflB97MxzjzGww6EpuMtesNFX5w7Qq01X+zksd
> YOv6emgt9BhC5syyqYqFelr3MpV4kjCMBgP9vuZJZvIYfGssUgTdwAkeSxBYzjYt
> jUSklqoRZaN48sw8mA4YPGHUqZgZEy+rIUpAE2pMT+DBF0GQdDgkCdJ1qNzYT26C
> 9uVpA8ie3Aw3VRhwssKffmdonJzHfVcbR5mh1w0sNQd2Dgcc9tSj7Elw3EjEdzi9
> ML+03NZf++2OnEHO65V52g2HZ8Fq6pf1HnMOgCvv+kMMp5a5jDjR2MeMLComiR9Y
> FkD+IdhHtd+8kGZS1sEtwdrs1rIewS+FWCS7qWGVUsDSt517jgpz9rSs2nOo5ELm
> buCllZUVaZWko+Z3EQ0UPxv99Zdib63ZJZns5waDU0aSK5RlXhg4lqLmsMs4xjq7
> 2XpeLljtKUQ8LJrt+/PHcvFeLgBgDEG0+XhQZTkj112HvCSlDFQAkJEowgjMpFzH
> e8T/REWZUlTjlf7oQNx0jpGUW134VOMKMWN8NM01zxJasjipGdzCUrNjdwIvVI4C
> NyURsXTsue35lEJDiH2EEPchyK7A1983vZXRmETX/6uNoYWKsEH3nU90NhbucUe6
> ZfYzCGmVQeCcZ03+F6xJ
> =kHni
> -----END PGP SIGNATURE-----
>

--001a1134a332a413da04e97883b8
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi All</div><div>=A0</div><div>Thanks for the suggest=
ions..</div><div>=A0</div><div>1) OK, I&#39;m feeling dumb. I guess its a c=
ase of RTFS.</div><div>=A0</div><div>Based on the source here: <a href=3D"h=
ttps://github.com/OpenVPN/openvpn/blob/master/src/openvpn/socks.c">https://=
github.com/OpenVPN/openvpn/blob/master/src/openvpn/socks.c</a>, OpenVPN onl=
y supports SOCKS5.. </div>
<div>this doesn&#39;t appear to be mentioned anywhere in the documentation.=
 My proxy is a SOCKS4 proxy, and hence expects a longer header than is bein=
g sent, resulting in timeouts.</div><div>=A0</div><div>I&#39;d suggest upda=
ting the man page to explicitly say that only SOCKS5 is supported - can som=
eone point me in the direction of the file, and i&#39;ll submit a git push?=
</div>
<div>=A0</div><div>=A0</div><div>2) I&#39;ve now rewritten the proxy that I=
&#39;m using=A0to support SOCKS5, and tested that it runs fine with curl --=
socks5. However when=A0I try to tunnel OpenVPN through it, I get the follow=
ing error:</div>
<div>=A0</div><div>Oct 24 16:06:53 master rsyslogd-2177: imuxsock begins to=
 drop messages from pid 2331 due to rate-limiting<br>Oct 24 16:06:53 master=
 ovpn-client[2332]: Attempting to establish TCP connection with [AF_INET]<a=
 href=3D"http://192.168.147.82:110">192.168.147.82:110</a> [nonblock]<br>
Oct 24 16:06:54 master ovpn-client[2332]: TCP connection established with [=
AF_INET]<a href=3D"http://192.168.147.82:110">192.168.147.82:110</a><br>Oct=
 24 16:06:54 master ovpn-client[2332]: TCPv4_CLIENT link local: [undef]<br>
Oct 24 16:06:54 master ovpn-client[2332]: TCPv4_CLIENT link remote: [AF_INE=
T]<a href=3D"http://192.168.147.82:110">192.168.147.82:110</a><br>Oct 24 16=
:06:54 master ovpn-client[2332]: WARNING: Bad encapsulated packet length fr=
om peer (43520), which must be &gt; 0 and &lt;=3D 1544 -- please ensure tha=
t --tun-mtu or --link-mtu is equal on both peers -- this condition could al=
so indicate a possible active attack on the TCP link -- [Attempting restart=
...]<br>
Oct 24 16:06:54 master ovpn-client[2332]: Connection reset, restarting [0]<=
/div><div><br>=A0</div><div>Is there something special I need to implement =
in the SOCKS5 proxy to fix this link issue? FWIW the proxy itself is runnin=
g under Windows (although both client &amp; server are running under Ubuntu=
 Linux), but 43520 bytes (42k) seems a strange number.</div>
<div>=A0</div><div>I&#39;ve already tried setting link-mtu (and then tun-mt=
u) to this number on both client &amp; server, but after that it doesn&#39;=
t seem to connect at all.</div><div>=A0</div><div>thanks</div><div>Steve</d=
iv>
<div>=A0</div><div>=A0</div></div><div class=3D"gmail_extra"><br><br><div c=
lass=3D"gmail_quote">On Thu, Oct 24, 2013 at 6:43 AM, Thomas Murach <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:murach@...1850..." target=3D"_blank">murac=
h@...1850...</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">-----BEGIN PGP SIGNED MESSAGE-----<br>
Hash: SHA1<br>
<br>
Hi,<br>
<br>
in my case, I had to add the following options:<br>
<br>
pull<br>
tls-client<br>
persist-tun<br>
comp-lzo<br>
<br>
I&#39;m quite sure that tls-client is the one you need. The others are<br>
specific to your setup. I hope that this helps.<br>
<br>
Cheers,<br>
Thomas<br>
<br>
<br>
Hi, On Wed, Oct 23, 2013 at 10:50:11PM +0800, Steve Cook wrote:<br>
&gt; I can&#39;t get openvpn to connect through my socks proxy server, and<=
br>
searching<br>
&gt; around seem to find other users with the same problem, but no<br>
&gt; known solution.<br>
<br>
It &quot;should&quot; work. =A0Does the Android client work?<br>
-----BEGIN PGP SIGNATURE-----<br>
Version: GnuPG v2.0.19 (GNU/Linux)<br>
Comment: Using GnuPG with Thunderbird - <a href=3D"http://www.enigmail.net/=
" target=3D"_blank">http://www.enigmail.net/</a><br>
<br>
iQIcBAEBAgAGBQJSaFECAAoJEKQl1saKseE5nTkP/R50DTsaw2U/iYYY0h6IK6KP<br>
zSrGX+XF5cw2dnXVHY/NjYL19kCflB97MxzjzGww6EpuMtesNFX5w7Qq01X+zksd<br>
YOv6emgt9BhC5syyqYqFelr3MpV4kjCMBgP9vuZJZvIYfGssUgTdwAkeSxBYzjYt<br>
jUSklqoRZaN48sw8mA4YPGHUqZgZEy+rIUpAE2pMT+DBF0GQdDgkCdJ1qNzYT26C<br>
9uVpA8ie3Aw3VRhwssKffmdonJzHfVcbR5mh1w0sNQd2Dgcc9tSj7Elw3EjEdzi9<br>
ML+03NZf++2OnEHO65V52g2HZ8Fq6pf1HnMOgCvv+kMMp5a5jDjR2MeMLComiR9Y<br>
FkD+IdhHtd+8kGZS1sEtwdrs1rIewS+FWCS7qWGVUsDSt517jgpz9rSs2nOo5ELm<br>
buCllZUVaZWko+Z3EQ0UPxv99Zdib63ZJZns5waDU0aSK5RlXhg4lqLmsMs4xjq7<br>
2XpeLljtKUQ8LJrt+/PHcvFeLgBgDEG0+XhQZTkj112HvCSlDFQAkJEowgjMpFzH<br>
e8T/REWZUlTjlf7oQNx0jpGUW134VOMKMWN8NM01zxJasjipGdzCUrNjdwIvVI4C<br>
NyURsXTsue35lEJDiH2EEPchyK7A1983vZXRmETX/6uNoYWKsEH3nU90NhbucUe6<br>
ZfYzCGmVQeCcZ03+F6xJ<br>
=3DkHni<br>
-----END PGP SIGNATURE-----<br>
</blockquote></div><br></div>

--001a1134a332a413da04e97883b8--

