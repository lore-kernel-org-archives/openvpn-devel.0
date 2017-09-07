Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170907012225.21661-1-davids@...515...>
 <20170907061200.GB70062@...1296...>
 <73fb2899-edfb-1399-39de-e84d9c3e87fe@...2080...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <bcd4211c-b553-5c41-0a84-2985e79e4376@...2080...>
Date: Thu, 7 Sep 2017 16:54:01 +0200
MIME-Version: 1.0
In-Reply-To: <73fb2899-edfb-1399-39de-e84d9c3e87fe@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="T00SJCwEtviL3KiPugIvvT6TEkXvmqGvP"
Subject: Re: [Openvpn-devel] [PATCH] lz4: Changing how LZ4 library handling
 is done
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>, David Sommerseth <davids@...515...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T00SJCwEtviL3KiPugIvvT6TEkXvmqGvP
Content-Type: multipart/mixed; boundary="lip9mgb1fgfpL98hOErt8GSG19qMddWnw";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>,
 David Sommerseth <davids@...515...>
Message-ID: <bcd4211c-b553-5c41-0a84-2985e79e4376@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] lz4: Changing how LZ4 library handling is
 done
References: <20170907012225.21661-1-davids@...515...>
 <20170907061200.GB70062@...1296...>
 <73fb2899-edfb-1399-39de-e84d9c3e87fe@...2080...>
In-Reply-To: <73fb2899-edfb-1399-39de-e84d9c3e87fe@...2080...>

--lip9mgb1fgfpL98hOErt8GSG19qMddWnw
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 07/09/17 16:06, David Sommerseth wrote:
> On 07/09/17 08:12, Gert Doering wrote:
>> Hi,
>>
>> On Thu, Sep 07, 2017 at 03:22:25AM +0200, David Sommerseth wrote:
>>> This change will expect the system to have LZ4 libraries and headers
>>> installed by default.  We still carry a bundled LZ4 library, which
>>> must now be explicitly enabled through providing --enable-bundled-lz4
>>> to ./configure.  Otherwise, as before, --disable-lz4 will completely
>>> remove any LZ4 support.
>>
>> I'm totally missing the *reason* why you want to change this
>=20
> Bundled libraries are considered to be bad, as it requires active
> maintenance.  Just look at which version we ship in OpenVPN (1.6.0) and

Just a correction.  We bundle lz4-1.7.1, not 1.6.0.  That was a
left-over from my testing of the API update patch.  But that doesn't
change my argument that much.

--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--lip9mgb1fgfpL98hOErt8GSG19qMddWnw--

--T00SJCwEtviL3KiPugIvvT6TEkXvmqGvP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZsV2JAAoJEIbPlEyWcf3yQ9sP/jld6Eu4p0mT476r5fMvvr/R
1Sm7TKm8kuqjzmBjH+ZdtlRY6/rtACNNvjYNIGmvBs1Yom66c/1mm/zta9oKRpNs
Qhm7aua5cqQcVQOh6sR17f76KrQAriXHYUm5r1FUZrlRvFoeGBSH8uZTYsJB+l0v
TFP+CrSMW2L5P6DtlpPUCFbx9UeJEY6mQFc5c6ErATbqq0sMg1Fz+xDHq2BBLr7L
qrpGIwKAk182AQXsZQK6Gg3hJx5Jw3PXfWRN4vLAaOD+aKLz3hgMIeM0NR0Ca9l1
QIlZoLvVEhzRm7ovCLj2vFk8guqGOW7DJ4UVliDjzIdlsE9FmBnexHknixsZnU4Q
Rqk4vRrP50PaLxX1P4i+0khUTeHRpqh0amqDlH22kvMMlT7gmhMxY/SVKaTjGOyJ
EWt+U1vNrUUBgCVKoDU5sZNtjpzy+3ikpIAxnTHWodkDTVvqn2MfOTBsUngYmWVz
RCsNGBQHbADzOjy4GucuzetJYSsKbrkUe6xS9BcR7SlIMqpNjPSLmQoIikEjDTB1
AS/51GBBeLzZs89h4hM4UVCKqb84XtK7t8gqEgMAQW1CCL6dXx3pWYyKEuGXQSfi
A7jm1QJmGrxIWUGwseCtGwGrVb2X41uESJyl6I+UPcxsoxFtAEd+/WozWv7muwWB
+gkN0LF93ZqG3Fd6MzgF
=KPHB
-----END PGP SIGNATURE-----

--T00SJCwEtviL3KiPugIvvT6TEkXvmqGvP--

