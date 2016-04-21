Date: Thu, 21 Apr 2016 20:01:25 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160421180125.GK53051@...1296...>
References: <950C8167-A5FF-4F56-9020-C956EED49557@...2127...>
	<5718879E.8050007@...1227...> <57189BF4.7040400@...515...>
	<5E0364AE-B4E5-45B7-A30D-4CB6C018BF1C@...2127...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qZLFzaLf2KECwqmh"
Content-Disposition: inline
In-Reply-To: <5E0364AE-B4E5-45B7-A30D-4CB6C018BF1C@...2127...>
Subject: Re: [Openvpn-devel] Unit testing in openvpn?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jens Neuhalfen <openvpn-devel@...2127...>
Cc: openvpn-devel <Openvpn-devel@lists.sourceforge.net>

--qZLFzaLf2KECwqmh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 21, 2016 at 07:40:16PM +0200, Jens Neuhalfen wrote:
> The first candidate would be the U2F integration that I???d like
> to write. A proven strategy for starting unit testing is to write
> tests for all new features. This way the up-front cost is reduced
> to the invest for ???the first test???.

A test driver for the plugin API is actually something which might=20
work reasonably well as test rig...

OTOH, testing one-time-passwords in an automated manner sounds complicated.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--qZLFzaLf2KECwqmh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVxkVdKkuBuNlUUl1AQKBygP+Nctk4HGKzp/nbW4HXT6oxLGDbTfb8GuO
hFDCyhPNTlSUZUToj9BMSADDa7DAooMMmV1z6+qy1CgousdZmxWkBSYfNhgZNK7Y
VMvTKHo5iIkkFgLVVa/N7EBLim7a/yqvX5Tp6NR6G1InwrLa7Yu4Z3T/Acq40u0u
54SeKMVdqHc=
=F3AX
-----END PGP SIGNATURE-----

--qZLFzaLf2KECwqmh--

