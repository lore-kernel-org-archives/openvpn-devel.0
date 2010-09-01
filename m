Date: Wed, 1 Sep 2010 10:22:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100901082202.GR10703@...1296...>
References: <AANLkTina=B8Z8v2euOJYjZxMQhJ9WB6UMdY0qtnc_qyT@...278...>
	<4C7CD670.4030706@...1147...> <4C7CDAD7.9070500@...1294...>
	<20100831113136.GJ10703@...1296...> <4C7CFD59.8080707@...1294...>
	<20100831165110.GK10703@...1296...> <4C7E0A83.3060206@...1294...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NAmHCRPXNp23hR9r"
Content-Disposition: inline
In-Reply-To: <4C7E0A83.3060206@...1294...>
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

--NAmHCRPXNp23hR9r
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Sep 01, 2010 at 10:10:43AM +0200, Eike Lohmann wrote:
> My mistake, didn't checked that you allready did my math. ;)
> Do you have experience with changing"#define IFCONFIG_POOL_MIN_NETBITS
> 16", is it realy so simple?

I haven't tested it, but from looking at the code, it should work.

> The best way for me would be to define 2 different /16 networks on one
> server/instance.
> E.g. 172.16.0.0/16 and 10.1.0.0/16

Well, this really depends on what you want to do with it.  If you want
to do static assignments (ifconfig-push in ccd/ or via radius-plugin),
this can be done today.  If you want the ifconfig-pool to span two=20
different networks, this can not be done today - there can only be one=20
pool, and it must be contiguous.

> Is it possible to add this to the wishlist for the next community meeting=
s?

Well, the community meeting is not "please go and implement this for me",
it's more "I want to implement this, what do you think about it?" (and
"there's a *bug*, how can we fix this?").

So you're welcome to send patches and if the patch is OK, it's likely
to go into 2.3

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--NAmHCRPXNp23hR9r
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iQCVAwUBTH4NKqkuBuNlUUl1AQJuuwQAg40gNTcCRKjLcQQetCwRYodOwQoFgBZm
x6efflhWRpNCkdA/XGhYzLHcRMvBaFx9/cBdmb5eVTlrft1sx+sKDc6yb7QszA9R
15iqgeCzmB0sDCjA+fcC31n51SskOdlPgolTJHavqUzJlmWA1W88FabYE6jMxdQi
30ufkh2xV5Q=
=aHAj
-----END PGP SIGNATURE-----

--NAmHCRPXNp23hR9r--

