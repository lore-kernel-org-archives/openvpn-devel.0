Date: Thu, 21 Mar 2013 22:17:28 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20130321211728.GF17727@...1296...>
References: <1363624652-7001-1-git-send-email-steffan.karger@...1435...>
	<1363624652-7001-5-git-send-email-steffan.karger@...1435...>
	<20130320085250.GA953@...1296...>
	<1CED409804E2164C8104F9E623B08B9013B9050666@...1436...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Content-Disposition: inline
In-Reply-To: <1CED409804E2164C8104F9E623B08B9013B9050666@...1436...>
Subject: Re: [Openvpn-devel] [PATCH 4/5] Config compatibility patch. Added
	translate_cipher_name.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 21, 2013 at 06:41:04PM +0100, Steffan Karger wrote:
> Attached an updated version of the patch, which should resolve the issue.=
 It passes t_client tests.

It does!  OCC is happy now, keysize defaults to 128 bits now, so I am
happy to report that

  "release/2.3 plus your most recent patches 1-6"

will a) compile with polar 1.2.6 (on FreeBSD), and b) pass all my t_client
tests as well with all cipher/crypto related options "at default", talking
to an openssl-openvpn server, also "all options at default":

   Test sets succeded: 1 1a 2 2a 2b 3 4 4a 5.
   Test sets failed: none.

So there's an ACK from me as well (tested and stared at the code).

Now, due to adding a "patch 6/5" to the series afterwards, and sending
new versions of patch 1 and patch 4, the whole mail thread is a bit=20
confusing now.  Since we're aiming for maximum transparency regarding
"which bits go in the tree and why", may I ask you to "git send-email"
these 6 patches in their most recent version in one new thread again
(and Adriaan to ACK *those* as well)?

That way we'll have a definite patch set in one single thread, and I
can merge that with less chance of accident.

thanks in advance, and for the work done this week!

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUUt46KkuBuNlUUl1AQKlagP/Ulw6KCPQHgxBJPGmLirjXlAG4MjoBB2Y
pFyRu5MhtCzn/588wVQJrlQISWEZvzHyMsGrbWE/duk54vCNBEVFJVzlm2mZRFro
AjRIxPjQu9cG5MKW3NbA3Cs0g5Zq/V9ZtX5sYm5XX9bONWuwl0CwBbozb6NrzGGb
jhp9yN4EanI=
=ibu9
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--

