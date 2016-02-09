Date: Tue, 9 Feb 2016 12:58:26 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160209115825.GP24952@...1296...>
References: <20160208213929.GA20623@...2120...>
	<20160209092821.GH24952@...1296...>
	<20160209101533.GJ3102@...2121...>
	<20160209104625.GL24952@...1296...>
	<20160209105839.GP3102@...2121...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f7hTBRK9VATTLb5J"
Content-Disposition: inline
In-Reply-To: <20160209105839.GP3102@...2121...>
Subject: Re: [Openvpn-devel] route / route-ipv6 can not be used in ccd
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuel Thibault <samuel.thibault@...1817...>, Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--f7hTBRK9VATTLb5J
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 09, 2016 at 11:58:39AM +0100, Samuel Thibault wrote:
> I have tried putting
>=20
> iroute-ipv6 2a01:474:5:1100::/56
>=20
> in the ccd, but from the learn-address script the environment does not
> contain this route.

       --learn-address cmd
              Run  command cmd to validate client virtual addresses or rout=
es.
...
              Three arguments will be appended to any arguments in cmd as f=
ol-
              lows:

              [1] operation -- "add", "update", or "delete" based  on  whet=
her
              or  not the address is being added to, modified, or deleted f=
rom
              OpenVPN's internal routing table.
              [2] address -- The address being learned or unlearned.  This =
can
              be  an IPv4 address such as "198.162.10.14", an IPv4 subnet s=
uch
              as "198.162.10.0/24", or an ethernet MAC address (when --dev =
tap
              is being used) such as "00:FF:01:02:03:04".
...

"it's not in the environment" :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--f7hTBRK9VATTLb5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVrnUYakuBuNlUUl1AQICXQQAoLPD3zWBwCLWqaHkySdFFZUsEZxxio7o
mz7JhgP2YM78TQYPvXrmjHqYWVrLiOs4fJedOTBppKjs8KP4Vz89Qkycwisdtr7u
26G1VdquXBE9WcrooGLb4Zx2a9s5c1cNvSnVRTY7G//JQjjsKsISQa1mEyo0G01g
jVmtUlIXdcM=
=DsYD
-----END PGP SIGNATURE-----

--f7hTBRK9VATTLb5J--

