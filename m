References: <515a2f96-e50d-3de5-bf54-e6d00834ca01@...515...>
	<CAEsd45RwW+oa8B1er1FSYZ8-B_OxWojNnYB81zd707isPSJM5w@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <1e84c3fe-b45f-e739-7ff2-dc9f074a2b4c@...2080...>
Date: Fri, 19 May 2017 14:37:32 +0200
MIME-Version: 1.0
In-Reply-To: <CAEsd45RwW+oa8B1er1FSYZ8-B_OxWojNnYB81zd707isPSJM5w@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dPlof820lJjx5GNvC9FohWctoE2ITSbCQ"
Subject: Re: [Openvpn-devel] OpenVPN 2.3.16 released
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dPlof820lJjx5GNvC9FohWctoE2ITSbCQ
Content-Type: multipart/mixed; boundary="HAgpTsNNmv6J9KxFCod5k444bwhrsmX6D";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: "Jonathan K. Bullard" <jkbullard@...277...>,
	"openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <1e84c3fe-b45f-e739-7ff2-dc9f074a2b4c@...2080...>
Subject: Re: [Openvpn-devel] OpenVPN 2.3.16 released
References: <515a2f96-e50d-3de5-bf54-e6d00834ca01@...515...>
	<CAEsd45RwW+oa8B1er1FSYZ8-B_OxWojNnYB81zd707isPSJM5w@...278...>
In-Reply-To: <CAEsd45RwW+oa8B1er1FSYZ8-B_OxWojNnYB81zd707isPSJM5w@...278...>

--HAgpTsNNmv6J9KxFCod5k444bwhrsmX6D
Content-Type: multipart/mixed; boundary="------------D51B38EFD0984F810D7A30CE"
Content-Language: en-GB

This is a multi-part message in MIME format.
--------------D51B38EFD0984F810D7A30CE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 19/05/17 12:46, Jonathan K. Bullard wrote:
> On Fri, May 19, 2017 at 5:29 AM, Samuli Sepp=C3=A4nen <samuli@...515...> =
wrote:
>>
>> The OpenVPN community project team is proud to release OpenVPN 2.3.16.
>> It can be downloaded from here:
>>
>> <http://openvpn.net/index.php/open-source/downloads.html>
>>
>> This is a minor release that fixes a few bugs. This release was made
>> primarily because CloudFlare managed to serve obsolete pre-release
>> OpenVPN 2.3.15 tarballs which lack a fix for CVE-2017-7478:
>=20
> Were all copies of openvpn-2.3.15.tar.gz that were downloaded from the
> website pre-release versions and not the final versions, or only some?
>=20
> If only some were the pre-release version, is there a way to tell if a
> tarball was the pre-release version or was the actual version? (The
> SHA256s of both would be helpful here.)

I have asked Samuli to re-upload the real v2.3.15 source tarballs once
again, just to be on the safe side.  But beware, there are some caching
proxies in front of our download servers ... so until the caches have
been properly purged, there will be some confusion.

Attached is a list with all the v2.3.15 source tarballs and their SHA256
checksums.  This file is signed by our new signing key [1].  This is the
proper v2.3.15 release.

Any other checksums for v2.3.15 than the ones in this list are invalid
and must not be used.


[1] security@...515...
    F554 A368 7412 CFFE BDEF  E0A3 12F5 F7B4 2F2B 01E7
    <http://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x12F5F7B42F2B01E7>


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc


--------------D51B38EFD0984F810D7A30CE
Content-Type: application/pgp-encrypted; name="openvpn-v2.3.15.sha256sum.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="openvpn-v2.3.15.sha256sum.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQpIYXNoOiBTSEEyNTYKCjkxNGNi
Y2UyMTAwYzU4MDk3NzJjOGU2MzM3Njk2MWFmMTUyZTM0NWM0OGVkZGEwM2UyMWU4YzNhZmVm
YWYwNWYgIG9wZW52cG4tMi4zLjE1LnRhci5negowMGIwODViYWMxZDQ0YjdhM2FkODQ4ZmQz
MTQwMTA3OWRjNWUyYzdhYmQ4MmI5Yzk1MWE3Njc1NzhkZDBlOTE4ICBvcGVudnBuLTIuMy4x
NS50YXIueHoKYjU2ZTY1Yzk1NGUxMDEyYzUzZDE0MGVlZDZjMTA5OTM0ODA3NTgwYjJmZjg4
MzQ4MGRiZWQ4ODFmM2UxMjU1OCAgb3BlbnZwbi0yLjMuMTUuemlwCi0tLS0tQkVHSU4gUEdQ
IFNJR05BVFVSRS0tLS0tClZlcnNpb246IEdudVBHIHYyLjAuMjIgKEdOVS9MaW51eCkKCmlR
SWNCQUVCQ0FBR0JRSlpIZzQxQUFvSkVOY3E4MFNNd3JBMEtvY1AvQXpESUVrdnFmaTVBYVNt
UGN6WVJxdlYKMWtQcHJOUS9JbVFaMk03azN0SlJzM01BTzFSODlIMllrZjNnQkhlZFBOYWNL
eG1iM0NrWWdNR1VobEZYaDFHUApYRlM5MU53bGRDMlIvWFVCdGJXeTF6ZEs2L3kvdHJYTWt5
YmxmK3RZWDlVb2EyYVFGQ2tlZ08ycEN0QW50SzBXCkV0MnZZK3J6MVlVLzR2b2MrRGtTQUpU
WEU1dU9zWmk5bk83aVpHemZKa3I3ZmF1aFI3MmMxb3JNTENFeWR0NHgKVS9MSlFvRFp3Mk5C
MGpKdlFLTU9Fd0l4L1pBQU9Ca0tZaFNHKzJWTFJXYXBMc0J6VW9BbVFJdUpTZW5YTjJEdgpw
OTY4VlJmUjZNWlNUMWE4TlNpekUwSkp3UnpWakRucUtsbXJHT2Y5UXBERTFwak42VzFVUjl5
Vmx2Y041VHlKCjRwZmdXVG5vMTJrdWNkVEp4NGgvNmNjbUZHTStJSWk3L0ltbWc3Y0F6VWtI
aVorVmJkZkFSUDZJTGlycytVaUcKT2pQWGtBVVlCa3FQbTVCd2h0WjdGSC9Sb1lsL2owSVYw
blA1ZXp4OG1lUlJ1cHBSYWQxU2doVW44Yjh2eXVGWQpaMy9rZzM1ZTZuTTNnQnBVUzBXODM4
VW5JVTNTVHUraVY0VmhYNUxvT3lFMmg3YmJDMkVVOTNWVi81UmtHOGVNCnR1aVcwdTlBV2Na
Q2FtUUZuR2tlTllPcUhBL3ZwTnQ0MmxXbS85cXIzWExVa3JyZE5BK3dhM0lpTjY3YUlhUnYK
SnRHZCtxZDBNUmpzSzQ3bnluWURuSWcvRXpNbnBab050bk9ZMmN4TEk3V0lXY09TVmNzRWd5
UVg1Vk93VzcwMApCcWw3cVAzSzlhazkvcldaRG5wNwo9RjhnRAotLS0tLUVORCBQR1AgU0lH
TkFUVVJFLS0tLS0K

--------------D51B38EFD0984F810D7A30CE--

--HAgpTsNNmv6J9KxFCod5k444bwhrsmX6D--

--dPlof820lJjx5GNvC9FohWctoE2ITSbCQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZHucMAAoJEIbPlEyWcf3ydBwQAK3oe5eFB4MMw6WRAPOHqVXd
TKVNzsUuK+5lpMtMJ6RL1k3btzBS/Tv7ttGraPjSwSk8FItg3xva7YQUdcQFZOW3
8xJ7alFPoDavyVDkrYHjcIt/XYxzYqn3tdlEQWhrz3iG/YOMFGg7Q/0yb+qVTzU3
hjTTOe9M/x9LvBFbGlhBfO/MvGwkEl+DrM+gPK4vIT7b2xs76omLkOHIx8dhw+1f
xdIOzBDgfmuPtwSWXX4+dxu5cUqwG7jAe23HK2xXL+pBcwmgghW6CiTJBpvh2pCW
fvvSGBmhUJxfjxtMQn3j6P0gUhdJKv3dWPuikxpVXNIIomR1g7k63xkOiVjDy00/
Wp/icuuLyc4CsiFG2UqIosyuN97BTPjhSdyRCBRf7JFXst4n3TmV4kavrMHk3Nrx
S98xhKSoPkab/WQGqlnLqTkMDjEBypM3RvuDES+04t+2jdUB3UZUmJhbdqKYHCXS
bOsSWcCLECjVRZzy4zmDk4EZK+xSm4JIK5DPVIWD/c5WPJL7t1BpzTjM2RiCIDoS
bTcNR7KXZqLGoyaeE35OpCjVnk2S1fB+tUmO8HvNsIdn2L3pkTD7zEsAapkcpt7f
0hfb7w+GV6sAhjYvkpRWKjfJNhlFn8bx+kaxi3ePS/cOy0vdFTOpMx02ggVkOnSI
2udXHRwkVBSDu3+JWHYg
=sZg+
-----END PGP SIGNATURE-----

--dPlof820lJjx5GNvC9FohWctoE2ITSbCQ--

