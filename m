Date: Sat, 14 Nov 2015 20:05:45 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151114190545.GY24952@...1296...>
References: <1373890626-13943-1-git-send-email-mludvig@...1388...>
	<1444553060-15946-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kUmo4NyTJbuJZ752"
Content-Disposition: inline
In-Reply-To: <1444553060-15946-1-git-send-email-dejong@...1435...>
Subject: Re: [Openvpn-devel] [PATCH APPLIED] Support for username-only auth
 file.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Adriaan de Jong <dejong@...1435...>
Cc: openvpn-devel@lists.sourceforge.net, Michal Ludvig <mludvig@...1388...>

--kUmo4NyTJbuJZ752
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Oct 11, 2015 at 10:44:20AM +0200, Adriaan de Jong wrote:
> Make OpenVPN read the username from the auth file
> parameter of --auth-user-pass and prompt for a
> password if it's not in the file.

ACK, applied and merged to master.

commit 6e9373c84639382c16d9eb8f1f78f60079bb89df
Author: Michal Ludvig <mludvig@...1388...>
Date:   Sun Oct 11 10:44:20 2015 +0200

    Support for username-only auth file.

    Signed-off-by: Michal Ludvig <mludvig@...1388...>
=20=20=20=20
    Reviewed and updated to current master.
=20=20=20=20
    Signed-off-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: <1444553060-15946-1-git-send-email-dejong@...1435...>
    URL: http://article.gmane.org/gmane.network.openvpn.devel/10255


(I have changed --author to point to Michal, as he's the original
author, even if the rebased patch from Adriaan says "From: Adriaan de Jong"
- contributor's history is clear enough from the commit message, I think)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--kUmo4NyTJbuJZ752
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVkeGCKkuBuNlUUl1AQKA/gP/Uy2D9WKUqIoNfos3+3KNoPOVVYEUNUZv
hi7IZQ+vUQM39BE7tx0AL3INcvK0fh1EromQ87Sbwd871t2ikje7ihWXayU8Zrhx
D/r9EjcysNUm6V5PFviiQuDan0JJBXNxSQTdyj8DVYTQW4vCr/+UgwCq+OCG4r4x
ZpjQDijgOGc=
=20U7
-----END PGP SIGNATURE-----

--kUmo4NyTJbuJZ752--

