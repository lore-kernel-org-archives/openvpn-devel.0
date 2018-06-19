References: <42bafab6-9e6f-56b5-2c44-b449ec503ce7@...515...>
 <20180611075242.GF57262@...1296...>
 <bb55cab5-2523-b899-0ead-6f34886c4d2b@...515...>
 <DM5PR2101MB1112279487CBA7B6DE9A3ABDB0710@...2412...>
 <20180618205610.GI57262@...1296...>
 <20180618205916.GJ57262@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <40307566-0fe7-81cc-773b-3f50aef1b5ef@...515...>
Date: Tue, 19 Jun 2018 10:43:53 +0300
MIME-Version: 1.0
In-Reply-To: <20180618205916.GJ57262@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6s4eIjy4BeJFXMhBejF9VzE2YvHfuOhLC"
Subject: Re: [Openvpn-devel] Regarding tap-windows6 driver signatures and
 driver distribution
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Jon Kunkee <jkunkee@...2393...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6s4eIjy4BeJFXMhBejF9VzE2YvHfuOhLC
Content-Type: multipart/mixed; boundary="kAQCatamYnoyy6eRYXDvZ8OcDZLe3V9kw";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: Gert Doering <gert@...1296...>, Jon Kunkee <jkunkee@...2393...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <40307566-0fe7-81cc-773b-3f50aef1b5ef@...515...>
Subject: Re: [Openvpn-devel] Regarding tap-windows6 driver signatures and
 driver distribution
References: <42bafab6-9e6f-56b5-2c44-b449ec503ce7@...515...>
 <20180611075242.GF57262@...1296...>
 <bb55cab5-2523-b899-0ead-6f34886c4d2b@...515...>
 <DM5PR2101MB1112279487CBA7B6DE9A3ABDB0710@...2412...>
 <20180618205610.GI57262@...1296...>
 <20180618205916.GJ57262@...1296...>
In-Reply-To: <20180618205916.GJ57262@...1296...>

--kAQCatamYnoyy6eRYXDvZ8OcDZLe3V9kw
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Il 18/06/2018 23:59, Gert Doering ha scritto:
> Hi,
>=20
> silly me
>=20
> On Mon, Jun 18, 2018 at 10:56:10PM +0200, Gert Doering wrote:
>> On Mon, Jun 18, 2018 at 08:27:31PM +0000, Jon Kunkee wrote:
> [..]
>>> Is there a chance the ARM64 changes (NDIS 6.30+build+installer) will
>>> make it in? (Are we trying to get the MSI changes in for this release?)
>=20
> Didn't have time to look at the MSI stuff yet, and haven't heard from
> others.
>=20
> Most likely this release will be "get things out with compromises" -=20
> that is, have one attestation signed driver for Win10+Server 2016> and on=
e driver for "Win7 + 8 + 8.1", and two .exe installers.  Win10
> is still waiting for bugfixed + signed tap drivers for the fix in
> commit 7d6a1335bfe7a...

Minor correction. We will have a separate installer for Windows Server
2016, which refuses to load any drivers whose attestation signing
submission did not include HLK test results.

Windows 10 should accept drivers with an attestation signature that does
not include HLK test results. Also, if the driver includes a
cross-signed signature when it is submitted, the attestation signature
should get added to the driver. So we'd end up with a dual-signed driver
that _should_ work on Windows 7, 8, 8.1, 10 plus Windows Server 2008r2
and 2012r2.

This is at least what MS documentation says.

>=20
> Then, focus on make nicer installers - .msi for the tap driver, .msi
> for openvpn proper, return to *one* driver that has proper signatures
> for everything.
>=20
> gert
>=20


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--kAQCatamYnoyy6eRYXDvZ8OcDZLe3V9kw--

--6s4eIjy4BeJFXMhBejF9VzE2YvHfuOhLC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlsotDkACgkQKVhNn0CG
RXiGdQf/fSC1H/G13zbPVljE2FnOvQYs/S7T5H0vIbHkSgP379Wvgp9KV5cY8VrR
07JRMI+BXc9Ua+GXy13TeuE27cEmjTt3puSZRwl0mClf82AYJuV1GJLgp0Ts8gcE
vGtxT6/Yt2utSimhFoMZqWRvSDbQ9wqnI5IQ5g76BLT9k6hIfIIskv0Vl5yMNzJ5
g7rnxyRkmmtDMVUvX4QKhJqGXzl89HSQ7H4SVo325afnwhIKbyBP6XuvMQj1JUhe
FcwYtp9f30gASBrLLhH7yyZtvAvdc8icUL1Gk1PR6vyxEUzs88JiR/u5Gao1dJzv
LEXCfPyGhIK6qSRRCq06S8xTAy7fDw==
=IpaP
-----END PGP SIGNATURE-----

--6s4eIjy4BeJFXMhBejF9VzE2YvHfuOhLC--

