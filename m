Date: Thu, 26 Nov 2015 13:53:13 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151126125313.GX24952@...1296...>
References: <1448514932-13023-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9nLP/ACA6Hz7sAOz"
Content-Disposition: inline
In-Reply-To: <1448514932-13023-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH take2] Unbreak read username password
 from management
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--9nLP/ACA6Hz7sAOz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Nov 26, 2015 at 12:15:32AM -0500, Selva Nair wrote:
> Commit 6e9373c846.. introduced a bug by which auth-user-pass
> input falls back to read-from-stdin after successfully reading
> from management.

Mmmmh.  I was all willing to merge the other one - but this one looks
like a workable alternative as well, just tell the subsequent code
"we're done, no need to query anymore".

Any other variants that could trigger this?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--9nLP/ACA6Hz7sAOz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVlcAuKkuBuNlUUl1AQLwXwQAjSVSa1bgC3/B8Z99gUloIS/0l46QY2mT
SPoMc8zPeU7c5XY3uzBCHPhI47C64+98g82zk9ezWMNE9Ml3gooN3XVUi6sDh/+G
sar46qY2LmzMmGyDUFErkVw5t1ObUgYe4sEF3MmYCdVWp2Isss0/D9qH2mTuTomF
0eqCsfadaEU=
=Cu24
-----END PGP SIGNATURE-----

--9nLP/ACA6Hz7sAOz--

