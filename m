Date: Wed, 8 Nov 2017 10:50:31 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171108095031.GL958@...1296...>
References: <1509540912-8739-1-git-send-email-steffan.karger@...1435...>
 <1509540912-8739-2-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="NP+fiIeNjDlB/E6h"
Content-Disposition: inline
In-Reply-To: <1509540912-8739-2-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] doxygen: add make target
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

--NP+fiIeNjDlB/E6h
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 01, 2017 at 01:55:12PM +0100, Steffan Karger wrote:
> Add a make target, such that 'make doxygen' works (both for in-tree and
> out-of-tree builds).

The relative path used for INPUT=3D has some funky side effects if another
project happens to be checked out "nearby" - I had openvpn in=20

  /tmp/x/openvpn/

and doxygen started building documentation for

  /tmp/roundcubemail-1.3.1/

so that's overdoing things a bit :-) - feature-ACK, code-NAK.

(As discussed on IRC)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--NP+fiIeNjDlB/E6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaAtNnAAoJEB2Cnv7KVigStjAL/2ECVy5VefrmeiYwGnjCCWtJ
upTeJyld5BW/VDgy9cWzFREHTKGPW2jJ0vlAy8mr0MdxPikDGhO0zjDt5aPGVpuV
BKuc7osn+/FVYfShXWIjuUVBh3bM0DM7zBVB/QlT3L2KI1FwnGnbz8tzJHD7sfvk
G/A8KW3rhMmMrS0xP/sPBTXnoejhwFLFi5suTL0g5r7NLAahsSAcip7e/a8RVYJX
TI/eTbZvnt6tAtutbfom/sGpndzkhmENLelgLHpCHSMy89K8AoPns+8pfM/n6N3r
Z5WkZm6W2gBKtQLKMetzVXXvNo4jxfVh1+h0xpDv6Qba+7fUE9F1B9QupamELH1D
EWVWao6H4jTRKE1fGM8RHalozBGMQyPzbOHIG6aJ/m6EfZi06EKQ+eeG4P2TT/Um
T+/qKfhyos07+3XKp+tPYOHtpjUS85tOzycCjMnbtKw23pKCEOpRL52108m1PN8l
Ln2imEUbu5ZyArOLTvgt2DaGiAuX+zP4nMrt2jEUXg==
=u1Q9
-----END PGP SIGNATURE-----

--NP+fiIeNjDlB/E6h--

