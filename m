References: <9a257a3b-e899-42a8-d67d-7a5b1a559535@...1376...>
	<e80f9e3d-5def-bc6f-871a-2ce1a76ddaff@...1376...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <85cba9aa-2ddd-d11b-b06a-d575f667ca44@...68...>
Date: Thu, 18 May 2017 09:27:04 +0200
MIME-Version: 1.0
In-Reply-To: <e80f9e3d-5def-bc6f-871a-2ce1a76ddaff@...1376...>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="rTMQ20Xl1ul0umDLfLgSCtb6Ms6Ox4OJx"
Subject: Re: [Openvpn-devel] security/openvpn23 tarball size mismatch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Renato Botelho <garga@...1376...>
Cc: ports-secteam@...1249..., openvpn-devel@lists.sourceforge.net, freebsd-ports@...1376...

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rTMQ20Xl1ul0umDLfLgSCtb6Ms6Ox4OJx
Content-Type: multipart/mixed; boundary="ED7oudH8vw0xFN6rfcVGpe3wSHpEHjU2I";
	protected-headers="v1"
From: Matthias Andree <matthias.andree@...68...>
To: Renato Botelho <garga@...1376...>
Cc: freebsd-ports@...1376..., ports-secteam@...1249...,
	openvpn-devel@lists.sourceforge.net
Message-ID: <85cba9aa-2ddd-d11b-b06a-d575f667ca44@...68...>
Subject: Re: security/openvpn23 tarball size mismatch
References: <9a257a3b-e899-42a8-d67d-7a5b1a559535@...1376...>
	<e80f9e3d-5def-bc6f-871a-2ce1a76ddaff@...1376...>
In-Reply-To: <e80f9e3d-5def-bc6f-871a-2ce1a76ddaff@...1376...>

--ED7oudH8vw0xFN6rfcVGpe3wSHpEHjU2I
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 16.05.2017 um 14:00 schrieb Renato Botelho:
> On 16/05/17 08:54, Renato Botelho wrote:
>> Hello Mathias,
>>
>> I was trying to get openvpn23 installed from quarterly branch and got
>> the following error:
>>
>> root@...2268...:/usr/local/poudriere/ports/pfSense_v2_3/security/openvpn=
23
>> # make checksum
>> =3D=3D=3D>  License GPLv2 accepted by the user
>> =3D=3D=3D>   openvpn23-2.3.15 depends on file: /usr/local/sbin/pkg - fou=
nd
>> =3D> openvpn-2.3.15.tar.xz doesn't seem to exist in
>> /usr/local/poudriere/ports/pfSense_v2_3/distfiles/.
>> =3D> Attempting to fetch
>> http://swupdate.openvpn.net/community/releases/openvpn-2.3.15.tar.xz
>> fetch:
>> http://swupdate.openvpn.net/community/releases/openvpn-2.3.15.tar.xz:
>> size mismatch: expected 863384, actual 829240
>> =3D> Attempting to fetch
>> http://build.openvpn.net/downloads/releases/openvpn-2.3.15.tar.xz
>> fetch:
>> http://build.openvpn.net/downloads/releases/openvpn-2.3.15.tar.xz: size
>> mismatch: expected 863384, actual 829240
>> =3D> Attempting to fetch
>> http://distcache.FreeBSD.org/ports-distfiles/openvpn-2.3.15.tar.xz
>> fetch:
>> http://distcache.FreeBSD.org/ports-distfiles/openvpn-2.3.15.tar.xz: Not
>> Found
>> =3D> Couldn't fetch it - please try to retrieve this
>> =3D> port manually into /usr/local/poudriere/ports/pfSense_v2_3/distfile=
s/
>> and try again.
>> *** Error code 1
>>
>> Stop.
>> make: stopped in /usr/local/poudriere/ports/pfSense_v2_3/security/openvp=
n23
>>
>=20
> Just FYI, I've downloaded current tarball from OpenVPN website and
> checked it using GPG and it's OK. I'm not sure why they rerolled tarball
> tough.
>=20

Hi Renato,

there is a size difference on the tarballs between swupdate and build.

Working together with Gert D=C3=B6ring via IRC, and diffing the tarballs fr=
om
the two download sites, we figured out that the smaller tarball on
build.openvpn.net carries a pre-release tarball that did NOT fix
CVE-2017-7478, only -7479, but should never have been made public.

The bigger tarball on swupdate.openvpn.net carries garbage files that do
not end up in our build, but also carries the fix for BOTH CVE-2017-7478
and -7479.  For details, see the commit log of r441129 at
<https://svnweb.freebsd.org/ports/branches/2017Q2/security/openvpn23/Makefi=
le?revision=3D441129&view=3Dmarkup>

So I've chosen to remove build.openvpn.net from the DISTSITES for now,
under ports-secteam@'s blanket approval.

Upstream maintainers will need to talk about this and may need to
release 2.3.16 to resolve any uncertainties.

I have uploaded the intact 2.3.15 tarball to my local public_distfiles,
so we can add LOCAL/mandree/ to the DISTSITES later on should that prove
necessary.

Renato, thanks for bringing this up!

Best regards,
Matthias


--ED7oudH8vw0xFN6rfcVGpe3wSHpEHjU2I--

--rTMQ20Xl1ul0umDLfLgSCtb6Ms6Ox4OJx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZHUzNAAoJEOQSsVbv84VayGoP/A6oIm9n40Wv38aZg4sr+CbQ
8nngrxhJRjsFiuf3vkhl5aEc6QMwN/fX0CZmpI0alVXfj828RV5rQtSTAvj1aKJ0
kWjf3bu2Dj59uyHVqRwIUEfdXNARoTsMnGzm4Z7QmgSQYsjYoecHAt2FzvQRG/PZ
2w3/VHoNwiOGcV9YMdbEE3hNa1LrCmyj8grpdo5v5YSdPL6zOmybN7ImunTJotaw
mc4nQpwaJY/iA7WrhhS2tGPU6qDTYvOuxx/8jixuN+BREQvjr1zsYLVPN70U9/CL
bdrEthl+jquw7A1uRcFJGSJTnr3nbd9lwLX7MeCgSCcZKltCS/M8pSF5JEWWBuAt
xaly4USDkL80Bog3x9H3LMEDArt1aAMDNqzADCCDq9FkRIq0TJlPRVURkCD5z0z/
oT1sMSHKv2SJ17J+Oko9AgqqmDiA6zqJvTVhYosai7LdC8mtClKSDEwSLlaDDI/2
Iv327Bh/9Iw5+9jvspxcA94yiGsGQHVWawwf2SLhfzYVWUmWP+GPIDJPiTnnmjdF
Ulk2Cyuw0MBhcYmrHmKAjU8PWrTBpJWo0L2nDJOnPyFSPtmfvniyr+aYN5LjE8hs
PWmSbGzy/VKDNprSuH6WGfrr3vMcsICJQIff8n+cknWO00z1A9wq18tLCbxChQXL
3JeB3ZrDFr2m81gyMook
=5D/7
-----END PGP SIGNATURE-----

--rTMQ20Xl1ul0umDLfLgSCtb6Ms6Ox4OJx--

