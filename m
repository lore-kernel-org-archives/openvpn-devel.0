Date: Mon, 8 Aug 2016 14:20:11 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160808122011.GC78279@...1296...>
References: <57A87572.6080306@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="60m8Ey44SH8YQcXf"
Content-Disposition: inline
In-Reply-To: <57A87572.6080306@...277...>
Subject: Re: [Openvpn-devel] Is --ifconfig-ipv6-noexec planned ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--60m8Ey44SH8YQcXf
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Aug 08, 2016 at 01:05:06PM +0100, debbie10t wrote:
> --ifconfig-ipv6-noexec
>=20
> not sure if this would be a 'feature request/wish list' item
> or if it has just been over looked.
>=20
> I did have an annoying use case but I reconfigured so as not
> to need it, but I feel like there would be cases for it.

I do not see the use case to have "only IPv6" --ifconfig-noexec - so the
generic command does that for both IPv4 and IPv6 (as will --route-noexec
do for both IPv4 and IPv6).

What is your use case?

(The idea behind --ifconfig-noexec is not "do not enable IPv6", use
--pull-filter for that.  --ifconfig-noexec is used together with --up
to run more custom stuff on ifconfig, which the built-in mechanisms
cannot do)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--60m8Ey44SH8YQcXf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV6h4+6kuBuNlUUl1AQKygQP8Cuk2Az/pPkgHlckh3wLOhEgrL6aehdS5
tPmGvOv3ZMusdPOspMa36NtOycxZZWXr4aGioBG8wvKjMtj2ay4xxx94rWqi2hs8
cogLsYTUiEtSBM3y7un9N0P3POpXjimy9esCP3CIJbOu1e6G7ydW8oVzN5lyp7yy
l/KUb9a7vbk=
=iXkI
-----END PGP SIGNATURE-----

--60m8Ey44SH8YQcXf--

