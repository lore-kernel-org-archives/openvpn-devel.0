Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170906235202.26551-1-davids@...515...>
 <20170907061646.GD70062@...1296...>
 <79762b44-c8c8-b765-1711-22ba3f210af0@...515...>
 <1e1b1ed5-5a4e-5234-1e57-06a609a6f2b9@...515...>
 <20170907081340.GG70062@...1296...>
 <8f028968-1263-af79-4b49-863a202b9d93@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <188385e3-e632-5ae4-4b16-4c724bcec6b1@...2080...>
Date: Thu, 7 Sep 2017 15:16:45 +0200
MIME-Version: 1.0
In-Reply-To: <8f028968-1263-af79-4b49-863a202b9d93@...515...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7qN039pAjK2Ooof7RP0bjSFvb2e06Lffh"
Subject: Re: [Openvpn-devel] [PATCH] systemd: Enable systemd's auto-restart
 feature for server profiles
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net, David Sommerseth <davids@...515...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7qN039pAjK2Ooof7RP0bjSFvb2e06Lffh
Content-Type: multipart/mixed; boundary="5paicIk0cuKLW9cNbnJ81D0ONM9RppwQ6";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>,
 Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net, David Sommerseth <davids@...515...>
Message-ID: <188385e3-e632-5ae4-4b16-4c724bcec6b1@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Enable systemd's auto-restart
 feature for server profiles
References: <20170906235202.26551-1-davids@...515...>
 <20170907061646.GD70062@...1296...>
 <79762b44-c8c8-b765-1711-22ba3f210af0@...515...>
 <1e1b1ed5-5a4e-5234-1e57-06a609a6f2b9@...515...>
 <20170907081340.GG70062@...1296...>
 <8f028968-1263-af79-4b49-863a202b9d93@...515...>
In-Reply-To: <8f028968-1263-af79-4b49-863a202b9d93@...515...>

--5paicIk0cuKLW9cNbnJ81D0ONM9RppwQ6
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 07/09/17 14:17, Samuli Sepp=E4nen wrote:
> On 07/09/2017 11:13, Gert Doering wrote:
>> Hi,
>>
>> On Thu, Sep 07, 2017 at 11:04:01AM +0300, Samuli Sepp=E4nen wrote:
>>> "Note that units which are configured for Restart=3D and which reach the
>>> start limit are not attempted to be restarted anymore; however, they may
>>> still be restarted manually at a later point, from which point on, the
>>> restart logic is again activated."
>>
>> Which is not what I hoped for... "turn it off and leave it so" is non
>> helpful (it might be a transient error preventing the startup).
>>
>=20
> Good point. Systemd seems to be able to adjust its restart behavior
> depending on exit code of the main service process (i.e. OpenVPN) using
> "RestartForceExitStatus" and "RsstartPreventExitStatus"[1]. Perhaps
> these could be helpful in our case...

Okay, lets try to align what OpenVPN does in various scenarios and
compare it how we want restarts to happen.

First, have a look at the man page:
<https://www.freedesktop.org/software/systemd/man/systemd.service.html#Rest=
art=3D>

Then realise that OpenVPN (AFAIK) only operates with two exit codes:

#define OPENVPN_EXIT_STATUS_GOOD                    0
#define OPENVPN_EXIT_STATUS_ERROR                   1
#define OPENVPN_EXIT_STATUS_USAGE                   1
#define OPENVPN_EXIT_STATUS_CANNOT_OPEN_DEBUG_FILE  1
(from error.h)

So the RestartForceExitStatus/RestartPreventExitStatus is not going to
be helpful if all graceful errors results in 1, which is the most common
way OpenVPN stops - through the M_FATAL.  So that leaves us with
SIGSEGV, SIGABRT and similar unclean exit signals.

To avoid restarts on faulty configurations or if we can define scenarios
where we do not want OpenVPN to be restarted automatically, we need to
introduce more exit codes.  This way we can implicitly tell systemd if
it should restart OpenVPN or not.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--5paicIk0cuKLW9cNbnJ81D0ONM9RppwQ6--

--7qN039pAjK2Ooof7RP0bjSFvb2e06Lffh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZsUa9AAoJEIbPlEyWcf3yr5UQAIF2X3N7FTlIVkiUmhfOteoR
ASjwbjp9Dh6h1gUQYkgVQQBxDo+GgLJZ6t9DukvG3//QLt8G4XvVUTlfVnGT2jW4
gFzVkgaae08QsuVvunELiOOFpcGxn1xX/WicG5CXKeIJNNfZU2aUE9Cl0M7xVSqq
n1z0/aMXsc29RtFbJjGvWmyWAjrtRxjomjw1eAEpRcsC4yHuFFBgPLlu3ZBi4SsQ
S2HlQxz12fcrgAXY3i3f7bsNuzeDbriO5xj6Vi875JERerx+go3P0U5NJLqtE1lc
8F5uFxoDYNsjrJqklUvorYt5CVkQbwH8ePSz8mZts64Qf/WqdkRlO6mnRxdNJYOt
0AE6JnivQREbASIj9e7z0udk54zcQd79xhPUSQFt97mWLeF6KgpVAk3GO7j1cQSu
MA1NgesxXwiHJv2SuRjhc1CNXJZ7JaEInjj5B77xB7BWd2ZI8zD7OWvUvGS1egin
KXtuBpx5QnXL+mvaI+/0d8DrV4DfKxEs9gvgvv3ay3SttrGHKv/zgLD4+PRTEkZB
czrIv49Hz2aybkdPEG802wK4RhL1z2C+2UmeccJFbY0ACa24JdIzv5pfqtbKB3TV
xphaqc23/WOMZJGqnobs6BtMlXg8lRw5yR1CtWEa8jMB2S2CFtO0rKGDz5pZEMvX
g1B725nOCW7eEkxKpCXM
=XEwp
-----END PGP SIGNATURE-----

--7qN039pAjK2Ooof7RP0bjSFvb2e06Lffh--

