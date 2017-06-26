Reply-To: openvpn-devel@lists.sourceforge.net
References: <1498475606-8337-1-git-send-email-arne@...1227...>
	<99e7102e-8b4a-6b42-3095-40fcfada8c28@...2080...>
	<73f851af-608e-7a15-1021-82cb0b05dada@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <96916139-fed0-fae9-1c36-b4e2417eb26a@...2080...>
Date: Mon, 26 Jun 2017 15:21:38 +0200
MIME-Version: 1.0
In-Reply-To: <73f851af-608e-7a15-1021-82cb0b05dada@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="u65wESb7cHqoUUwD4R1KMeUknPPbCq7Co"
Subject: Re: [Openvpn-devel] [PATCH] Set tls-cipher restriction before
 loading certificates
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u65wESb7cHqoUUwD4R1KMeUknPPbCq7Co
Content-Type: multipart/mixed; boundary="BTcWa3p6HxmnDrEb3fbcung22Rf3TLvP1";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <96916139-fed0-fae9-1c36-b4e2417eb26a@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Set tls-cipher restriction before loading
 certificates
References: <1498475606-8337-1-git-send-email-arne@...1227...>
 <99e7102e-8b4a-6b42-3095-40fcfada8c28@...2080...>
 <73f851af-608e-7a15-1021-82cb0b05dada@...1227...>
In-Reply-To: <73f851af-608e-7a15-1021-82cb0b05dada@...1227...>

--BTcWa3p6HxmnDrEb3fbcung22Rf3TLvP1
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 26/06/17 14:12, Arne Schwabe wrote:
> Am 26.06.17 um 13:51 schrieb David Sommerseth:
>> On 26/06/17 13:13, Arne Schwabe wrote:
>>> OpenSSL 1.1 does not allow MD5 signed certificates by default anymore. =
This can be enabled again by settings tls-cipher "DEFAULT:@SECLEVEL=3D0" bu=
t only if the cipher list is set before loading the certificates. This patc=
h changes the order of loading.
>>
>> I'm not fully convinced of the argumentation for this feature - unless
>> something have changed in OpenSSL 1.1.  I believe the same can be
>> achieved by setting an environment variable before starting OpenVPN.
>>
>>   $ OPENSSL_ENABLE_MD5_VERIFY=3D1 /usr/sbin/openvpn ....
>>
>> I know several Fedora users have deployed this, even when systemd is
>> involved.  This is needed on systems with OpenSSL 1.0 as well when they
>> connect to a server having an MD5 based certificate or signed by a CA
>> with an MD5 based certificate.
>>
>> So unless OpenSSL 1.1 have changed this behaviour from OpenSSL 1.0, I'm
>> not really convinced we need this.
>>
>>
>=20
> See this also a bugfix. Since tls-cipher options affect certificate
> loading, it is good to set it before certificate loading. E.g. you might
> want to use @SECLEVEL=3D5 to only allow loading of SHA256 based certifica=
tes.
>=20
> Also I think your option is Fedora specific as I could not find anything
> in the source code in my OSSL copy and the message also mentions it
> being Fedora specific:
>=20
> ** WARNING ** [Fedora modification] MD5 certificate hash re-enabled via
> OPENSSL_ENABLE_MD5_VERIFY environment variable.

Nope, that is actually a warning I added in one of the earlier mbed TLS
builds for Fedora.  That patch have been removed again, as I moved back
to compat-openssl10 when compat-openssl10-pkcs11-helper became available.

The patch which adds that warning is a workaround so that uses already
having deployed MD5 support when they used OpenSSL ... so we needed to
ensure users did have this feature enabled.  So instead of requiring
users to define MBEDTLS_ENABLE_MD5_VERIFY, I re-used the
OPENSSL_ENABLE_MD5_VERIFY variable name.  And complained about it in the
logs.

But I'm actually a bit fascinated you found a Fedora build with that
warning.  IIRC, that build was from a scratch build, testing out this
issue - used by a user which got into troubles during the mbed TLS based
builds in Fedora 26 (not yet released) and Fedora Rawhide.  With
openvpn-2.4.2-1, I switched back to OpenSSL.

As of the next Fedora 26 openvpn build, I will move further forward to
OpenSSL 1.1 instead of compat-openssl10.  Fedora Rawhide is already on
openssl-1.1.



--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--BTcWa3p6HxmnDrEb3fbcung22Rf3TLvP1--

--u65wESb7cHqoUUwD4R1KMeUknPPbCq7Co
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZUQpiAAoJEIbPlEyWcf3ywVkP/A02NgmXZDwOtW/qQtlwtbVe
f/dzRtsNizoER79F4HJ0wyfvVnEQSZdU3oia/ZxoHzIZGURDOXcHpLE2WqumIdY7
dg2xl6js39QXgwk+Uqyvlob46Uw+I1VY5oltC/cIsi3EyftqDmilWHV6XDnkRUzi
s2ZcGyJhabz/O53HCAl9keIseLwE3QszjpCxABfnprvkMwTGwDvALC8DfC/6FVdf
m1T2uc4R/eVFwGE6tfnr6tNZXGb0mt8XzGkx1jgpu9hSXqv+jQXxrbwRb+z4WlJ3
aQgobm0nYm8nXSHK9WigDGjlBcvAu3/WcTOCI/RuaYFMxCNjeBnytSOBrLvQ0dQM
ZXapZwW1ULc96VWdlqI8sDTi6b0xexBj8zwk5cAfCp1nhAJoV/U3GnVja2o9pLtF
aT1hQahhb/x+Q8ECKnitDxpQrCrQhbhDVcWacfmF8zlSuxwpja2tW153mwaZtR7z
xjKSEIBfpod++KlmBYvGaFgEJGq6/EpAuHu8NU2PieV/OazYRgcnnVFjcixdgo2e
0cr+VTBDd9Cl77Bwab3i+CLOot+TPvb+/n/mSHa1vblTK8IOb/y7lnFuM0sQdbCL
bD9LFFFMAOyv9tHZSx84FuxQf62dhV/rLKZvhj7bQ2cBh2+QKUib7WNUwdwBS44e
HnkGk95zQEqKDlYA6Bjc
=G3xf
-----END PGP SIGNATURE-----

--u65wESb7cHqoUUwD4R1KMeUknPPbCq7Co--

