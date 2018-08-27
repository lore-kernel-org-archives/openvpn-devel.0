Reply-To: openvpn-devel@lists.sourceforge.net
From: David Sommerseth <openvpn@...2080...>
References: <149619ba-265f-1a7a-6403-f99c6f4b7eac@...1227...>
 <f89c1cbd-4899-432a-5288-1055b5045318@...2080...>
 <20180824191654.GK997@...1296...>
 <a94f7c1d-9d84-477c-0c0c-cc10ba589186@...2080...>
Message-ID: <888da3bf-2827-5dbd-bdcd-e70945f17db7@...2080...>
Date: Mon, 27 Aug 2018 14:52:44 +0200
MIME-Version: 1.0
In-Reply-To: <a94f7c1d-9d84-477c-0c0c-cc10ba589186@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="s8LX8rjA65UL3ZU7uvHwmkHPgp1Bp9CGN"
Subject: Re: [Openvpn-devel] Discussion: Moving forward with compression and
 voracle
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s8LX8rjA65UL3ZU7uvHwmkHPgp1Bp9CGN
Content-Type: multipart/mixed; boundary="Q1TPfwt0Bx8vC8cyx0eguYpPL3kYCMVf2";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Message-ID: <888da3bf-2827-5dbd-bdcd-e70945f17db7@...2080...>
Subject: Re: [Openvpn-devel] Discussion: Moving forward with compression and
 voracle
References: <149619ba-265f-1a7a-6403-f99c6f4b7eac@...1227...>
 <f89c1cbd-4899-432a-5288-1055b5045318@...2080...>
 <20180824191654.GK997@...1296...>
 <a94f7c1d-9d84-477c-0c0c-cc10ba589186@...2080...>
In-Reply-To: <a94f7c1d-9d84-477c-0c0c-cc10ba589186@...2080...>

--Q1TPfwt0Bx8vC8cyx0eguYpPL3kYCMVf2
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 27/08/18 14:46, David Sommerseth wrote:
> Wrong.  We have those #ifdefs already, it just needs to be reverted and a=
dd an
> additional logic in configure.ac to "unlock" unsafe features.  Look for
> ENABLE_LZO and ENABLE_LZ4 in the code.
Meh ... Just to clarify ... It needs to be *reversed*, is what I tried to
type.  Also forgot to mention the USE_COMP macro as well.

--=20
kind regards,

David Sommerseth
OpenVPN Inc



--Q1TPfwt0Bx8vC8cyx0eguYpPL3kYCMVf2--

--s8LX8rjA65UL3ZU7uvHwmkHPgp1Bp9CGN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJbg/QcAAoJEIbPlEyWcf3ydGoP/3WyJgdK4cai45kGevh2J3mV
CN06ox0r34Ae4Rt0oPuGA6REeNuGsk8Y6iZKkpOkJYD7V5vzEQlIZvE0gyaLADsO
kd+n9+ZqxQ1STvCrMV1q9evsjYUQc6Y5aDUXuwjIH4SZG9r5wTcKBHadVBEa3Dqb
5G9teXMy0wrdDPUlmhHrV1ioJFkA2MfOwBU5j3yqu6gVJgFYlUucee0jN2E58lCS
d4sZpX7A6Ri+D8PVYZcckxOHYcIXbo0AxhD5fbE+uPArtekUuVWHF5fmVKefHBTx
APY6/StMRoMAOtKROaVPC9BiK5Qtjgzc/WTXyv4tW27ih1qw07l/TZBaJwdM+825
oqrkbtYoFkRvCyfZder3XNHDTodDo/AwmVMKqxj1sqsP6Ky9nXah6/tit527L6vq
eszz9f+BpVeaajdbVeRiv4K+lVFnCSgnYObpJ72xc6AcEPVjTXI1dCIUx3eC2+pe
iHZ2FvApoIgjfkgZQDSWrx7leRWmITBr4+kTmo6eQSuruDrHE2VceY2XoHm/D/SD
edohQZ0d6qUbsIpgnB35VveeBJFYJc4jpfyelDlRQybFvKsB9aOyGn/MXvhCmUxk
zHmgS7l7w4nNtqgeOlai1oR+Y+9e/LY+VduSNvPLxAM6/xCEoUvByrkR2V++dFCx
SSC9YVkF+t6ImrUdF26+
=qQSZ
-----END PGP SIGNATURE-----

--s8LX8rjA65UL3ZU7uvHwmkHPgp1Bp9CGN--

