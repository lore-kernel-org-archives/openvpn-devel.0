Message-Id: <200210302241.g9UMfVe16747@...41...>
From: "James Yonan" <jim@...41...>
In-Reply-To: <Pine.LNX.4.40L2.0210292349540.1965-100000@...52...>
Subject: [Openvpn-devel] Re: [Openvpn-users] CRL with TLS security?
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Oct 30 14:42:03 2002
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Felipe Sanchez <izto@...51...>, openvpn-users@lists.sourceforge.net
Cc: openvpn-devel@lists.sourceforge.net

Felipe Sanchez <izto@...51...> said:

> 
> Hi, I've been using openvpn for about a month now with great success, I
> have already setup about a dozen VPN connections in various environments.
> 
> Lately I began wondering what would happen if I don't want some peer to be
> able to connect to my server anymore? From reading the docs I think I have
> these options:
> 
> a) Use a different CA for signing the certificate of each client, so when
>    I don't want that client to connect I just stop using the related
>    CA's certificate and key at the server.
> 
> b) Use my organization's CA for signing all the certificates (Which is
>    what I'm currently doing) and use --tls-verify and some scripting to
>    verify if the certificate presented by the peer is still acceptable
> 
> c) Use a Certificate Revocation List (CRL) to invalidate any certificates
>    I don't want to accept anymore.
> 
> 
> Looks like c) could be done in the same way that b) by using --tls-verify
> and the OpenSSL tools. My question is: Do I have to do that or does
> OpenVPN have built-in CRL support? I have found no mention of it in the
> documentation.
> 
> Felipe Sanchez.

You are right that while (a) and (b) are currently supported, (c) is not.  Having said that, I would imagine that adding CRL support would be straightforward.  If you are interested in writing a patch, init_ssl() in ssl.c would be the place to look + the OpenSSL docs concerning CRLs.  It's probably just a matter of adding the right OpenSSL calls to init_ssl to add the CRL to the SSL context.

James



