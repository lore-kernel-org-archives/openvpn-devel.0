Message-ID: <500FA9E4.7000404@...1114...>
Date: Wed, 25 Jul 2012 10:10:12 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAO5YuCUbSojNT5m78QChRjTr=f4JHkiAA-P7+sa62RA5KVyHog@...278...>
In-Reply-To: <CAO5YuCUbSojNT5m78QChRjTr=f4JHkiAA-P7+sa62RA5KVyHog@...278...>
Subject: Re: [Openvpn-devel] enable P2MP opentions?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: jay alco <jproxy22@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 25/07/12 07:57, jay alco wrote:
[...snip...]
> It looks like all options under P2MP and P2MP_SERVER are disable
> when i disable SSL, CRYPTO. and for that i can not use 
> client-cert-not-required, username-as-common-name, server X X,
> etc.. and cannot run the server. How do i eneable P2MP and
> P2MP_SERVER during build?

OpenVPN does not support P2MP mode without PKI (certificates/keys).
So what you're trying to do is not possible.  And even though you want
to use --client-cert-not-required, the server-side would still need
both a key and a certificate.  And the client would still need the CA
certificate which issued the server certificate.

In addition common name is used in the code paths which are related to
X509 verifications.  These code paths are also disabled when
SSL/CRYPTO features are disabled.  Which again would remove the
- --username-as-common-name feature.

Compiling without SSL/CRYPTO will only make it possible to use P2P
mode, which means you need a single OpenVPN process using a dedicated
port for each client.

Further, if you want to use --secret instead of SSL/TLS certificates,
that would be really a weak solution in a P2MP setup, as all clients
would be able to decrypt the traffic from all other clients.  Using
SSL/TLS certificates, each client have an individual encryption so it
would be much harder for other clients to eavesdrop other connected
clients communication.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAPqeEACgkQDC186MBRfro0DgCgg2eckszK19J/6WFzj4zajQmn
3GMAn2KfoqiYWdJ/ygTV8GW21apBLOkA
=vsQE
-----END PGP SIGNATURE-----

