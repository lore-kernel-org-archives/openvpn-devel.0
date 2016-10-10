Date: Mon, 10 Oct 2016 19:41:20 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20161010174120.GW78279@...1296...>
References: <20161010073931.54469-1-gert@...1296...>
	<bbd8ce5c-b7fc-aa14-358a-76ce1484dfe9@...68...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rnPVEzlAIFDl46si"
Content-Disposition: inline
In-Reply-To: <bbd8ce5c-b7fc-aa14-358a-76ce1484dfe9@...68...>
Subject: Re: [Openvpn-devel] [PATCH] Enable -D_SVR4_2 for compilation on
 Solaris
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--rnPVEzlAIFDl46si
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Oct 10, 2016 at 07:23:33PM +0200, Matthias Andree wrote:
> Am 10.10.2016 um 09:39 schrieb Gert Doering:
> > +		CPPFLAGS=3D"$CPPFLAGS -D_XPG4_2"
> NAK. Description mismatches content. Please revert and reapply with
> proper description.

Indeed.  Silly me.  So much effort for a one-line change.

Thanks for pointing that out.

commit 4e2038ed2e77aa7189852304d802382bad140f53
Author: Gert Doering <gert@...1296...>
Date:   Mon Oct 10 09:39:31 2016 +0200

    Enable -D_XPG4_2 for compilation on Solaris
...
    (v2: same patch as in 6eaa70e80aea7, reverted in e25d03a4cc0, and now
    with correct description)

commit e25d03a4cc0664f6ece067facb1bc8e38134f396
Author: Gert Doering <gert@...1296...>
Date:   Mon Oct 10 19:36:20 2016 +0200

    Revert "Enable -D_SVR4_2 for compilation on Solaris"
=20=20=20=20
    This reverts commit 6eaa70e80aea7dfd1b3114fcb369a8f72c19ceee.
    (the description was incorrect and the patch was already pushed out)


gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--rnPVEzlAIFDl46si
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV/vSwKkuBuNlUUl1AQK0wwQAlIPCjBs2YqsOoqyhKM1BBrTWKJjZOrdc
4KZ3HH6sXlKGXuZa2vKp2GD2ENz8IdF/pmDEi1HqeT/Ho1AQ5XERiWFA6Ue/CWR8
hc14gVKGrZywMYsMJVZ04zvpSsjdFQgBNp7oHtbmvkjU62+ZdJwk4d3t+NggRot+
Xs+DbPYPvvs=
=nf5Y
-----END PGP SIGNATURE-----

--rnPVEzlAIFDl46si--

