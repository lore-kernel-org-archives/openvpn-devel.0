Date: Tue, 6 Oct 2015 13:13:22 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20151006111322.GW22054@...1296...>
References: <1425810005-11893-1-git-send-email-steffan@...1856...>
	<1425810005-11893-2-git-send-email-steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1BKOZKwX7DAU5odC"
Content-Disposition: inline
In-Reply-To: <1425810005-11893-2-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] polarssl: Improve PolarSSL logging
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--1BKOZKwX7DAU5odC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 08, 2015 at 11:20:05AM +0100, Steffan Karger wrote:
> Use the new polar_log_err() and polar_ok() functions introduced in the
> previous commit to provide more log/debug output for polarssl errors.

For the record on the list - this one looks good, but got left in the sun
for so long that it's not applying any longer :(

13:10 <@syzzer> I can send rebased versions when I get home tonight

"please" :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--1BKOZKwX7DAU5odC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVhOs0akuBuNlUUl1AQKeHwP/UvECxFC0QHLcbhv9GlnPsghlm+dQa0Ku
jGyhNMLQHPJaB7ftPBH8Ncpq8R5WVa79vTassOewWq6jjQ55oE7p7sgP3z9Di74y
hK3D+H3IJ3moQSp1GlnIasxDDFfv1ftYi93XoDTUqLX7o3boMKZlwx7FZY8n3tpF
PoELhKxgwSM=
=KAdM
-----END PGP SIGNATURE-----

--1BKOZKwX7DAU5odC--

