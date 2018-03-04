References: <20180228231123.27782-1-steffan@...1856...>
 <20180304090817.GL69387@...1296...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <1999112e-8de3-5ac2-e9a2-0f499e69b123@...1856...>
Date: Sun, 4 Mar 2018 10:34:49 +0100
MIME-Version: 1.0
In-Reply-To: <20180304090817.GL69387@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hUSQHnBVmuLF2IVVXV8uJgWwukoxURmiI"
Subject: Re: [Openvpn-devel] [PATCH] Add a warning that we do not officially
 support LibreSSL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hUSQHnBVmuLF2IVVXV8uJgWwukoxURmiI
Content-Type: multipart/mixed; boundary="mBFXlPdsedH1FJWeR9ELGdbLeFFAjOpNi";
 protected-headers="v1"
From: Steffan Karger <steffan@...1856...>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <1999112e-8de3-5ac2-e9a2-0f499e69b123@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Add a warning that we do not officially
 support LibreSSL
References: <20180228231123.27782-1-steffan@...1856...>
 <20180304090817.GL69387@...1296...>
In-Reply-To: <20180304090817.GL69387@...1296...>

--mBFXlPdsedH1FJWeR9ELGdbLeFFAjOpNi
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 04-03-18 10:08, Gert Doering wrote:
> On Thu, Mar 01, 2018 at 12:11:23AM +0100, Steffan Karger wrote:
>> As discussed in the community meeting of 13-12-2017, we should warn our
>> users that LibreSSL is not officially supported.  We expect that it
>> currently works, but it might suddenly break or we might decide to no
>> longer build against LibreSSL in the future.
>=20
> Generally speaking, I agree.
>=20
> Should we also add a warning (+ sleep 60 to be extra-annoying?) to
> configure if LibreSSL is detected?

I considered that (modulo the sleep 60) and wrote the code to do the
configure check, but then thought that a not-suppressible warning in the
logs would be sufficient.  I still think it is, but don't mind re-adding
it to configure.ac if you prefer that.

-Steffan


--mBFXlPdsedH1FJWeR9ELGdbLeFFAjOpNi--

--hUSQHnBVmuLF2IVVXV8uJgWwukoxURmiI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJam73BAAoJEJgCyj0AftKIswcIAJeRyGURJ7APOoLN86ks8eiu
Gw9zxD0BcOTWI2zWxdQCJjNrSdRxkG6XVOPnBPY4GPaeTGonsm92KUWRL4Y2kOa3
PDT8SwaTMEnYhuC+zjv5EIbnk09mZjl/4aJ1RA3xId/Yv6Rs2fRaL45qFK9hPMj2
wkn8jG01Wa/KH8CReTm4ZFoXc3C6rO4r8T0kXyP2MDSmlFV+mZnckpxbnADy4GQb
bVWeCXkwDT5qOfJd0NxVDPVQ8Z8y10/sKYcm3WCf7KVbvNorYS7KR9uc4xQmCPL0
PUK6Owcc/6a3LZY2nylhaPbPH2YPNkgFnzKn4aUcWfRrobeg4HurbSRt00VePuI=
=tna0
-----END PGP SIGNATURE-----

--hUSQHnBVmuLF2IVVXV8uJgWwukoxURmiI--

