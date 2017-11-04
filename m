Date: Sat, 4 Nov 2017 17:22:53 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171104162253.GW958@...1296...>
References: <20170907022827.10658-1-davids@...515...>
 <20170907172004.22534-1-davids@...515...>
 <c122b7ac9f1d63ac0ba060f7f7d3ceff.squirrel@...2257...>
 <20170922205944.GA70062@...1296...>
 <a08bca638691c21471fadd3d6589359a.squirrel@...2257...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="KjJb61kpjaVQeLm7"
Content-Disposition: inline
In-Reply-To: <a08bca638691c21471fadd3d6589359a.squirrel@...2257...>
Subject: Re: [Openvpn-devel] LZ4 library version printing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Matter <simon.matter@...2249...>
Cc: Gert Doering <gert@...1296...>, David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net

--KjJb61kpjaVQeLm7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

returning to this patchset about printing the LZ4 library version...

On Sat, Sep 23, 2017 at 10:52:16AM +0200, Simon Matter wrote:
> > On Thu, Sep 07, 2017 at 10:40:21PM +0200, Simon Matter wrote:
> >> While we are at it, I found it useful to see the used LZ4 version at
> >> runtime as it is done with LZO and other libraries.

I still like this :-)

[..]
> > Feature-ACK (I think this is a useful idea, for the same reasons we have
> > LZO and OpenSSL versions :-) ), but that will not work if we use
> > compat-lz4.h, so "code NAK".
>=20
> IIRC at the time of writing this, the embedded lz4 was too old and didn't
> have the LZ4_versionString() function. So the code won't work with the
> patch. If the embedded code has LZ4_versionString() now, it should be ok.

It now has...  (1.7.5).

I'm not sure where LZ4_versionString() got introduced, though - their
git repo does not have tags for 1.7.1 or 1.7.2, it is in the 1.7.3 tag,
but not in the "last of the old numbering scheme" version.=20=20

Our configure.ac requires 1.7.1 - so if LZ4_versionString() is not in
there yet, we might want to bump to 1.7.3 then.

Can you revisit this?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--KjJb61kpjaVQeLm7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZ/eldAAoJEB2Cnv7KVigSKnwL/3CdCnUhQ1YTRKUMk9p2X/OM
kfskoK+hpisPwTMRFFFLWOxdaT4islBTpgbRIpa14u7xXOJ2EMXjlM06bDIg7vEx
EaluRYTrGrE33uAZUnXOFk/LuRvrEalfPjzsEk4G8hG8aeSre4HH/5BYWPHv0Aez
vsgpMK4LXeuynKo9d81ZhnLinDw1kKLYICvyWGNaOliaus9YUsonLqBSUYmfwMr9
kVeAERFxGzvzSaVn+HnFk2t5K6ocYCTj42AKfvjd8QX3sfUwecqkRViARc0sFSQI
imxfVDDPsQS/0LHe8jk/In52tBwSpwgneZweeFQY1sUy6G4clwn0FxQFqr/74Bs4
rQHLaPQ0SgbDwZN/T+OUKgzc7JraOAQzs66/N8JMR57Aq0bP0bMPWeVPuLjP4ifq
n3CPolRDGnyj2ojD7n7jAN9r/sGZTVrmm2pPVWCw4lf4WEjwRbZsEZY9C/LBWL8E
+5tffMhJsWXFo1Mj67In1eQFwvI8qgpFCxjaO4Ckmg==
=MplN
-----END PGP SIGNATURE-----

--KjJb61kpjaVQeLm7--

