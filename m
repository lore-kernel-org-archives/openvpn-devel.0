From: Adriaan de Jong <dejong@...1435...>
Date: Mon, 13 Dec 2010 14:44:23 +0100
Message-ID: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E418F@...1436...>
References: <4D021744.7010307@...515...> <4D060C34.7050801@...1147...>
In-Reply-To: <4D060C34.7050801@...1147...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (9th Dec 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jan Just Keijser <janjust@...1147...>, =?iso-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>, David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>



> -----Original Message-----
> From: Jan Just Keijser [mailto:janjust@...1147...]
> Hi Samuli, David, list,
>=20
> What some people get confused about is a stacked certificate vs a
> certificate chain: OpenVPN only supports stacked CA certificates,
> meaning that any of the certs present in the stacked file are
> considered
> trusted.
> What some people want is a certificate chain, like some websites use:
> the website has a server certificate signed by a sub-CA which in turn
> is
> signed by Verisign. The webserver sends the entire chain (server cert +
> sub-CA cert + verisign cert) to the client for verification. That way
> the client only needs the Verisign cert to trust a particular website
> (the Verisign CA cert is installed in most browser by default). OpenVPN
> does not support this at the moment. It would require changing
>   SSL_CTX_use_certificate()
> to
>   SSL_CTX_use_certificate_chain()
> to ensure that the entire certificate chain is sent to the remote end
> (client or server).

I think SSL_CTX_use_certificate_chain_file() is actually used when loading =
the certificate from a separate cert file. It's just slightly confusing due=
 to the fact that it is loaded twice:

- SSL_CTX_use_certificate_file is used here:
http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=3Dopenvpn/openvpn-testi=
ng.git;a=3Dblob;f=3Dssl.c;h=3Da1268ac2a9291dc1512fa28e3ab4efc65085c952;hb=
=3DHEAD#l1639

- SSL_CTX_use_certificate_chain_file is used here:
  http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=3Dopenvpn/openvpn-tes=
ting.git;a=3Dblob;f=3Dssl.c;h=3Da1268ac2a9291dc1512fa28e3ab4efc65085c952;hb=
=3DHEAD#l1738

I'm not entirely sure whether I'm right, and why things are done this way. =
Does anyone know the reasoning behind this?

Adriaan

