Date: Fri, 17 Jun 2016 10:00:53 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160617080052.GC79504@...1296...>
References: <1466132093-1178-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <1466132093-1178-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Fix management-external-cert option
 parsing error
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

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jun 16, 2016 at 10:54:53PM -0400, Selva Nair wrote:
>  - Allow --management-external-cert as an alternative to --cert
>  - Also make sure --cert and --management-external-cert are not
>    both specified, and clarify in the man page that the latter
>    must be used with --management-external-key.

Not being familiar with this particular code section - is this master-only
or master + 2.3?

(Proper review to be done later)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV2OuL6kuBuNlUUl1AQLTvwQAnRnyvayuX0GsmkEJxLEIkUZBojKOkWX8
xWcyccXFxR6xTC731ADyQZAPQXgOIpejeMy3oz397YyoFdcGlE2Rfz/wfampVnKw
TIrllrGpQf0L8PtPx2wKz32wa0Ts+OK4GReIiVtjZSFV3JVuje+YwcXrlXUNnwNJ
ciogEKvGmKA=
=zEC7
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--

