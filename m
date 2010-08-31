Date: Tue, 31 Aug 2010 13:31:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100831113136.GJ10703@...1296...>
References: <AANLkTina=B8Z8v2euOJYjZxMQhJ9WB6UMdY0qtnc_qyT@...278...>
	<4C7CD670.4030706@...1147...> <4C7CDAD7.9070500@...1294...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l3ej7W/Jb2pB3qL2"
Content-Disposition: inline
In-Reply-To: <4C7CDAD7.9070500@...1294...>
Subject: Re: [Openvpn-devel] Netmask OpenVPN Server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Eike Lohmann <e.lohmann@...1294...>
Cc: openvpn-devel@lists.sourceforge.net

--l3ej7W/Jb2pB3qL2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 31, 2010 at 12:35:03PM +0200, Eike Lohmann wrote:
> In the past only /16 networks were possibel per openvpn instance.
> Is it now possibel to define larger networks or define 2x /16 networks=20
> on one openvpn instance?

I assume that you're talking about this error message:

  --server directive netmask allows for too many host addresses (subnet mus=
t be %s or higher)

right?  If yes, it should work to change=20

#define IFCONFIG_POOL_MIN_NETBITS    16

in pool.h to "14" (etc) and recompile - every extra bit will double
memory consumption [for the pool handling, of I remember right], so=20
use with care.

(You really have more than 16000 users on a single OpenVPN instance?=20
Wow, I'm impressed!)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--l3ej7W/Jb2pB3qL2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iQCVAwUBTHzoGKkuBuNlUUl1AQIDVAP/VGFaa8hwstTBEe7ndcns9yPUfdytHzv9
Sqz2ZDqND5yeMZi1/T/eFQzhmo4PqAgwy8hps3yDIaPS+8NQYybCTT3P2dBGXZ6k
za8uWmGjZuLGXsEuDxcYso7DH7bFh1KC3g9sEzQoJCYCVxZ87bhCWGRNE66RCRr5
4nSng5lXKgI=
=jqou
-----END PGP SIGNATURE-----

--l3ej7W/Jb2pB3qL2--

