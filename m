References: <cover.1487368114.git.logout@...260...>
	<3b87d588-aad7-433d-f802-ea9f9f7a0a63@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <82c84d12-58b9-471c-1f0d-550fa5ade390@...2080...>
Date: Sun, 19 Feb 2017 15:58:18 +0100
MIME-Version: 1.0
In-Reply-To: <3b87d588-aad7-433d-f802-ea9f9f7a0a63@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6OqqrcfPX3GRqF5TmHjBvxPvc3IX7M2vo"
Subject: Re: [Openvpn-devel] [RFC PATCH v1 00/15] Add support for OpenSSL
 1.1.x
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6OqqrcfPX3GRqF5TmHjBvxPvc3IX7M2vo
Content-Type: multipart/mixed; boundary="TkNOf88UiOcCorJ2xSipRTWgwevhpVET6";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <82c84d12-58b9-471c-1f0d-550fa5ade390@...2080...>
Subject: Re: [Openvpn-devel] [RFC PATCH v1 00/15] Add support for OpenSSL 1.1.x
References: <cover.1487368114.git.logout@...260...>
	<3b87d588-aad7-433d-f802-ea9f9f7a0a63@...1856...>
In-Reply-To: <3b87d588-aad7-433d-f802-ea9f9f7a0a63@...1856...>

--TkNOf88UiOcCorJ2xSipRTWgwevhpVET6
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 19/02/17 13:03, Steffan Karger wrote:

> As discussed in other threads, we do want to support building on RHEL6,
> which is why we would prefer to be compatible with (patched) OpenSSL
> 0.9.8.  I haven't tested anything yet, but looking at the patches this
> might very well just work, or otherwise just needs some minor tweaking.

RHEL6 ships with OpenSSL 1.0.1e.  We don't need anything older for git
master, and I would even argue release/2.4.

RHEL5 (which goes EOL by end of next month) ships with OpenSSL 0.9.8e.
So I vote for ditching 0.9.8e now.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--TkNOf88UiOcCorJ2xSipRTWgwevhpVET6--

--6OqqrcfPX3GRqF5TmHjBvxPvc3IX7M2vo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJYqbKNAAoJEIbPlEyWcf3yKKgP/33KpF+tle9Qch4XR6SiK3Cf
3GCnVQdMqRvdvPk3GjSf3mCISHAtXz/q1JpJAYEHGgBSnDrhtvlwjnH7JDN64O0n
SR9yGmzf23rxlDhrN3DA27EWCq+EiiFMwHlzqa6PLvHEQMBsoSXu6uHp4jLEZE5v
cYJfX61xa2GpdrqCarsKQoi52Z82T8ZFgwDMRrSOMP3mvveYIZ7jmxageKJ5K+9U
ZVHzMKlLe/VdL2YNr5k2fnDS/3JB0Rh3mvG8z9+HrZJTUoQcO0HGvikcWDYxfOZb
rFl1yeemjy1/SfAlLTlGBzEnH+ZJhJMvxwqO8fhm4QwlAywqMfLPnRAZzmaIVncB
mvKzyChGx9AJR1Q6IvLVwhituvFjaLfCiOS1TSHRa/LrGr7jhcuAkkZkGRfN3oRv
d1d5nUxapievxkffODLzBCqbRa572FcL6OnKgA5InCOhR+j5/b34G+0J8R3fguKQ
V/cx0bsgZSygI3snXwsD7/jU27v4dUbInbl9TD15GR7YlwX1UEcKZ53BS5RceOjN
jrk2EevhirdUzy3iQPTmBBUo9BdD6+7EOLxndkfinfCw5hFeIzZZyyg9zUJXoETK
DiFPwlWIpYVPnev93NX4sxvXvWHrVQ0qZ1pVAgJ4ZtJiX8IfTUEuGaWeQmL6xljL
GhIwqyvrhlNhMZufpVz8
=JdRp
-----END PGP SIGNATURE-----

--6OqqrcfPX3GRqF5TmHjBvxPvc3IX7M2vo--

