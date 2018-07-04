From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <67cb5e5c-cc62-b1ad-69e0-be5aaa6a03aa@...515...>
Message-ID: <a9874dc2-975c-96e8-69a8-5d7cd59eb64b@...515...>
Date: Wed, 4 Jul 2018 14:05:53 +0300
MIME-Version: 1.0
In-Reply-To: <67cb5e5c-cc62-b1ad-69e0-be5aaa6a03aa@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8gtPzsrdbVil3hEEDIWFupgoMwjLefrFy"
Subject: [Openvpn-devel] Summary of the community meeting (Wed,
 4th July 2018)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8gtPzsrdbVil3hEEDIWFupgoMwjLefrFy
Content-Type: multipart/mixed; boundary="sDMG2pir1k3VuEjieyvfrGZbijhKt6F45";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <a9874dc2-975c-96e8-69a8-5d7cd59eb64b@...515...>
Subject: Summary of the community meeting (Wed, 4th July 2018)
References: <67cb5e5c-cc62-b1ad-69e0-be5aaa6a03aa@...515...>
In-Reply-To: <67cb5e5c-cc62-b1ad-69e0-be5aaa6a03aa@...515...>

--sDMG2pir1k3VuEjieyvfrGZbijhKt6F45
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 4th July 2018
Time: 11:30 CET (9:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2018-07-04>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock, plaisthos and syzzer participated in this meeting.

--

Discussed tap-windows6 release and HLK testing. Jkunkee is fixing the
issues identified in the HLK tests. Once that's done mattock will test
the updated driver in our HLK testing environment an submit the results
to Microsoft. If we're lucky MS will provide us with a signature. That
said, MS documentation seems to indicate that we'd need to run the tests
on a physical Windows Server 2016 instance. But the only way to be sure
is to try.

If MS disapproves our HLK submission mattock will either outsource the
testing to the company he's been in talks with. Or else build the
necessary infrastructure into the OpenVPN intranet and run test
pre-submission tests himself.

--

Discussed Reed's proposal to arrange a demo of Hackerone. Cron2, syzzer
and syzzer expressed interest in it. Mattock setup a Doodle poll for this:

https://doodle.com/poll/445bphsd9a4q9shs

--

Discussed Microsoft's OpenVPN fork on GitHub:

<https://github.com/microsoft/openvpn>

Agreed that some parts of it (dialer in particular) are interesting to
us. The author of the fork (Kevin) is now on openvpn-devel mailing list,
so we will follow up there.

--

Full chatlog attached.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--sDMG2pir1k3VuEjieyvfrGZbijhKt6F45--

--8gtPzsrdbVil3hEEDIWFupgoMwjLefrFy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAls8qhEACgkQKVhNn0CG
RXimVwf/eiyCPXDK5VvqsliJ2j1h3i9zEkBQHHGgQWr3Tp2lkbtJntxja3pWkZzz
RkkoTsvG5HT0RnLik682TgJpEO6rUt+ARuh5xtWNvIgmPL5dKLMBmwy03ZRbAeiq
O299q/e8XsMAa8/2Y5Q6au+NSqUiI6fw/cUQWpI+JnEBA+TGTj0GJWRFjM0F/CPN
8ApA/l7L5IBRFt8gMPfRLA4cjDp3+ibSgYTX3elYIWjuRHiUCUPhM6Wv1X1w8KW2
2x4vjrmWKL6XCbnL0O7Moo7lz70FE08QtvMZJIJYoD0xsXzMus1H2G1VqgATOmLU
rGgdYoobfzEQCEp62F7dqR9cuSj+lQ==
=VnL7
-----END PGP SIGNATURE-----

--8gtPzsrdbVil3hEEDIWFupgoMwjLefrFy--

