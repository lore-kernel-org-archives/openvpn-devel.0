Message-ID: <55487227.3050001@...515...>
Date: Tue, 05 May 2015 10:32:55 +0300
From: =?windows-1252?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <554756EE.6030407@...515...>
In-Reply-To: <554756EE.6030407@...515...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="reshQjrefN6SGQ6Jqo11IKua1Ea91i0kT"
Subject: Re: [Openvpn-devel] Topics for today's (Monday,
 4th May 2015) community meeting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--reshQjrefN6SGQ6Jqo11IKua1Ea91i0kT
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Monday 4th May 2015
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2015-05-04>

The next meeting was scheduled to two weeks from this meeting:

<https://community.openvpn.net/openvpn/wiki/Topics-2015-05-18>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock and syzzer participated in this meeting

---

Discussed the Access Server and OpenVPN Connect tickets in Trac, for
which mattock had created a custom report:

<https://community.openvpn.net/openvpn/report/18>

Earlier today mattock managed to close about 25% of the tickets and
informed James and other OpenVPN Technologies guys about the remainder.
The tickets should eventually get the attention they deserve.

---

Discussed the OpenVPN man-page. It was agreed that splitting it into
more manageable segments would make sense. Some examples of more modern
man-pages were mentioned:

- http://www.freedesktop.org/software/systemd/man/systemd.html
- http://linux.die.net/man/8/sssd

The latter (sssd) has a summary man-page and more detailed pages on
specific aspects of sssd - an approach we could possibly also use.

It was agreed that the same documentation should be made available both
as man- and web-pages. It was also noted that on the current man-page
there are omissions and part of the content has only historical value.

Mattock will ask for volunteers amongst our users for this man-page
cleanup project.

---

Talked about our OpenVPN doxygen documentation. Mattock will publish the
documentation on build.openvpn.net or similar suitable place. Agreed
that doxygen documentation should be added for all non-obvious functions
as part of normal development practice.

---

Talked about the active tickets with no associated milestone:

<https://community.openvpn.net/openvpn/report/19>

Mattock agreed to start reviewing these slowly but surely (5 per workday).

---

Reviewed tickets with the release-2.3.7 milestone:

<https://community.openvpn.net/openvpn/wiki/Topics-2015-05-04>

Assigned the tickets to various people and moved some to milestone 2.3.8.

---

Discussed the option of marking tickets with "we could use some help
with this". This would make it easier for people to know how to help the
project. It was agreed that this is generally a good idea, but the
technical implementation was not chosen. Mattock agreed to do some
research on the best technical approach.

---

Discussed the "Reworking the interface for querying users" patchset:

<http://thread.gmane.org/gmane.network.openvpn.devel/9232>

It was agreed that the approach taken in the patchset is sane. The
author (dazo) will provide an updated patchset with some fixes, after
which the code can be reviewed.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



--reshQjrefN6SGQ6Jqo11IKua1Ea91i0kT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlVIcigACgkQwp2X7RmNIqMuHACgktxaEQYfcuU9p2LXidDZr675
QCsAn0yc+dX7AD+I/mLJFTOQuvam25rs
=CDQ4
-----END PGP SIGNATURE-----

--reshQjrefN6SGQ6Jqo11IKua1Ea91i0kT--

