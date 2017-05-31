References: <1496177444-18373-1-git-send-email-steffan@...1856...>
	<29f51139-a525-fd92-0fe1-195d308d2924@...2080...>
	<20170531070258.GC97029@...1296...>
	<ae93b702-4edd-6772-0f1d-ac9629589ee8@...2080...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <2564329a-d3d8-ee78-dd09-b3c9a911bbd9@...1435...>
Date: Wed, 31 May 2017 11:33:38 +0200
MIME-Version: 1.0
In-Reply-To: <ae93b702-4edd-6772-0f1d-ac9629589ee8@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="A9t5fEiW9fJ8NmSUNc3MdQDD7djFKmpgk"
Subject: Re: [Openvpn-devel] [PATCH release/2.4] configure.ac: fix building
 against static openssl
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--A9t5fEiW9fJ8NmSUNc3MdQDD7djFKmpgk
Content-Type: multipart/mixed; boundary="DT5ONgAsavr4rpHJCpbMXgalunftpWd4L";
 protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <2564329a-d3d8-ee78-dd09-b3c9a911bbd9@...1435...>
Subject: Re: [Openvpn-devel] [PATCH release/2.4] configure.ac: fix building
 against static openssl
References: <1496177444-18373-1-git-send-email-steffan@...1856...>
 <29f51139-a525-fd92-0fe1-195d308d2924@...2080...>
 <20170531070258.GC97029@...1296...>
 <ae93b702-4edd-6772-0f1d-ac9629589ee8@...2080...>
In-Reply-To: <ae93b702-4edd-6772-0f1d-ac9629589ee8@...2080...>

--DT5ONgAsavr4rpHJCpbMXgalunftpWd4L
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 31-05-17 11:14, David Sommerseth wrote:
> On 31/05/17 09:02, Gert Doering wrote:
>> On Wed, May 31, 2017 at 02:31:40AM +0200, David Sommerseth wrote:
>>> If we really do care for supporting 0.9.8, in release/2.4 - I can give
>>> this an ACK.  Otherwise, I think it might be better to backport
>>> 039a89c331e9b7998d804 + 79ea67f77ca3afe91222f.
>>
>> You are the one that objects most violently if we break users' expectati=
ons
>=20
> Yes and no.  In regards to end users, I am very careful.  In regards to
> package maintainers, I am less weary as they won't distribute failing
> builds to end users.  This change hits package building, not the end user.
>=20
> And when we have had the policy (at least on the Linux side) that the
> oldest supported library and build dependencies are what the oldest
> officially supported RHEL release carries, then moving to OpenSSL 1.0.1
> should not break anything.
>=20
> When also considering that any releases older than OpenSSL 1.0.2 is not
> supported by OpenSSL upstream [1], and OpenSSL 1.0.1 is supported by at
> least Red Hat in RHEL for the lifetime of RHEL ... Then ditching 0.9.8
> support makes even more sense.
>=20
> [1] <https://www.openssl.org/policies/releasestrat.html>
>=20
> If there are other OS/distros actively supporting, fixing and
> backporting security fixes to 0.9.8, then I have no issues keeping 0.9.8
> support.  But unless there are someone having this requirement, cleaning
> up all the various OpenSSL hacks for unsupported version is fairly
> sensible to me.

Either backporting 039a89c331e9b7998d804 + 79ea67f77ca3afe91222f or
applying this patch is fine by me.  As I wrote a little while ago:

On 19-02-17 16:09, Steffan Karger wrote:
> The other big long-term-support distro, SLES, does still ship and
> support 0.9.8 in SELS11 until 2019 (2022 for extended support), but can
> be updated to 1.0.1.
>
> As far as I'm concerned, that is enough reason to only support OpenSSL
> 1.0.1+ for OpenVPN 2.4 (and newer).

I'll let you guys decide.

-Steffan


--DT5ONgAsavr4rpHJCpbMXgalunftpWd4L--

--A9t5fEiW9fJ8NmSUNc3MdQDD7djFKmpgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJZLo34AAoJEEEwndWOY1w54SAH/2hyYh/sTZY2znvWizCFoAtg
XbDulkCrUNaiGHA6LVqvBsjIX2MCVqRVQL6EL4/Ci9DSzVTYYGqbhrBNuAVpTivl
8fmh4n7YomJuDZq7e6UNpvtl/1waalJh6aZYGtWfGlaFsLCcwJLwxWdb7iJSeApZ
FKYMmxt93Z3QOVp13JWw2FmsStBqqzmz9mAw9P9M67VdVU/jHrfrK7aojLIlmKh1
G2972pXh8TFfVwfCBdhhYka4d3zv6tPSWSx99NHJF2/2GbCso3boxnW6UHVENLGT
rMvcHE4rGcQhQSVLex7mZe8y0iaL213/5uZhwLIsT5FU1P/HDo1oWpdGXe2IMqo=
=6wrj
-----END PGP SIGNATURE-----

--A9t5fEiW9fJ8NmSUNc3MdQDD7djFKmpgk--

