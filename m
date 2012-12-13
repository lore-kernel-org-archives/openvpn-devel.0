Message-ID: <50C9FA1A.1050801@...1114...>
Date: Thu, 13 Dec 2012 16:54:02 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1354303076-13606-1-git-send-email-arne@...1227...>
In-Reply-To: <1354303076-13606-1-git-send-email-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC2C9707E7D26FD6B7D8170FF"
Subject: Re: [Openvpn-devel] [PATCH 01/10] Remove dnsflags_to_socktype,
 it is not used anywhere
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC2C9707E7D26FD6B7D8170FF
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 30/11/12 20:17, Arne Schwabe wrote:
> ---
>  src/openvpn/socket.c |    2 +-
>  src/openvpn/socket.h |    5 -----
>  2 files changed, 1 insertion(+), 6 deletions(-)

Applied to master and beta/2.3


commit 740137f6bb7b3565054c3a8e894ceca93f2ff0e4 (master)
commit e99982218b5549894a94cc3c5f6209219d911ba1 (beta/2.3)
Author: Arne Schwabe <arne@...1227...>
Date:   Fri Nov 30 20:17:47 2012 +0100

    Remove dnsflags_to_socktype, it is not used anywhere

    Signed-off-by: Arne Schwabe <arne@...1227...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: 1354303076-13606-1-git-send-email-arne@...1227...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/7160
    Signed-off-by: David Sommerseth <davids@...1347...>


--=20
kind regards,

David Sommerseth


--------------enigC2C9707E7D26FD6B7D8170FF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDJ+h4ACgkQDC186MBRfrrLmwCdEhf73QuFLwdxZkPEHJzvZvTw
s+MAoKjc7YDGjjlK7myx5KbqQmSESKDt
=suEd
-----END PGP SIGNATURE-----

--------------enigC2C9707E7D26FD6B7D8170FF--

