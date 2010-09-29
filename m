Message-ID: <4CA362CD.8030204@...1410...>
Date: Wed, 29 Sep 2010 17:01:17 +0100
From: Lars Hupel <hupel@...1410...>
MIME-Version: 1.0
References: <4CA0551F.70703@...1410...>	<4CA08840.3030107@...1147...>	<4CA088DD.5040607@...1410...>	<4CA08C68.1080701@...1147...>
	<20100927124711.GS3275@...1355...>
	<4CA09A9F.6040009@...1147...> <4CA0B3A3.5030506@...1410...>
In-Reply-To: <4CA0B3A3.5030506@...1410...>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
	micalg=sha1; boundary="------------ms030504080907050808080702"
Subject: Re: [Openvpn-devel] HTTP/1.1 Host header
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a cryptographically signed message in MIME format.

--------------ms030504080907050808080702
Content-Type: multipart/mixed; boundary="------------040906040608080607080802"

This is a multi-part message in MIME format.
--------------040906040608080607080802
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

> After looking into the source code, there are (at least) two places
> where this patch has to be applied.
>=20
> 1) The place described earlier and mentioned in the original patch (I
> would guess)
> 2) There is duplicated code in the same function when the proxy answered
> with "407 Proxy Authentication Required". Maybe it is possible to move
> this into an extra function, maybe send_proxy_headers.

Apparently I was mistaken at this point. With the very first place where
an HTTP CONNECT is issued being the only exception, at all other places
the Host header is sent.

However, I'm not sure whether these are correct. As far as I can see,
there are two possible hosts which can be sent:

* 'host' (denoting the 'remote' config option)
* 'p->options.server' (denoting the 'http-proxy' config option)

I would guess that sending the latter would be correct, but the OpenVPN
sources use the first one. For example, consider the following
configuration:

	http-proxy-option VERSION 1.1
	http-proxy vpn.example.com 80
	remote localhost 1194

I would expect the OpenVPN client to send the request as following (over
a connection with vpn.example.com:80):

	CONNECT localhost:1194 HTTP/1.1
	Host: vpn.example.com

At the moment (and with the patch proposed in 2008), the following
request is sent:

	CONNECT localhost:1194 HTTP/1.1
	Host: localhost

The problem is that the RFC isn't clear at that point. Consider the
following snippet from the section about 'CONNECT':

>    This specification reserves the method name CONNECT for use with a
>    proxy that can dynamically switch to being a tunnel (e.g. SSL
>    tunneling [44]).

The section about the host header isn't very helpful either:

>    The Host request-header field specifies the Internet host and port
>    number of the resource being requested, as obtained from the original
>    URI given by the user or referring resource (generally an HTTP URL
>    [...]
--------------040906040608080607080802--

--------------ms030504080907050808080702--
