Reply-To: openvpn-devel@lists.sourceforge.net
References: <b775444a-aaf6-4e93-5f9c-338ec105eaee@...515...>
 <88a33ea9-ef60-0378-b39e-ffb5c945e4ae@...515...>
 <2aa343af-c8bb-ce25-82bf-b092c8cd8556@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <430676a4-9358-bf5b-0a42-6f0f4fddeb35@...2080...>
Date: Wed, 13 Sep 2017 01:59:32 +0200
MIME-Version: 1.0
In-Reply-To: <2aa343af-c8bb-ce25-82bf-b092c8cd8556@...515...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="E0hsgC2KS21bviTr0JahSimKKoR01xUxh"
Subject: Re: [Openvpn-devel] Summary of today's (Wed,
 12th Sep 2017) community meeting
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
--E0hsgC2KS21bviTr0JahSimKKoR01xUxh
Content-Type: multipart/mixed; boundary="61xM6kfUpxsHkSQc7LKgT278CHQb7J7mR";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <430676a4-9358-bf5b-0a42-6f0f4fddeb35@...2080...>
Subject: Re: [Openvpn-devel] Summary of today's (Wed, 12th Sep 2017) community
 meeting
References: <b775444a-aaf6-4e93-5f9c-338ec105eaee@...515...>
 <88a33ea9-ef60-0378-b39e-ffb5c945e4ae@...515...>
 <2aa343af-c8bb-ce25-82bf-b092c8cd8556@...515...>
In-Reply-To: <2aa343af-c8bb-ce25-82bf-b092c8cd8556@...515...>

--61xM6kfUpxsHkSQc7LKgT278CHQb7J7mR
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 12/09/17 21:50, Samuli Sepp=E4nen wrote:
> Hi,
>=20
> Here's the summary of today's IRC meeting.
>=20
> ---
>=20
> COMMUNITY MEETING
>=20
> Place: #openvpn-meeting on irc.freenode.net
> Date: Wednesday 12th Sep 2017
> Time: 20:00 CET (19:00 UTC)
>=20
> Planned meeting topics for this meeting were here:
>=20
> <https://community.openvpn.net/openvpn/wiki/Topics-2017-09-12>
>=20
> The next meeting has not been scheduled yet.
>=20
> Your local meeting time is easy to check from services such as
>=20
> <http://www.timeanddate.com/worldclock>
>=20
> SUMMARY
>=20
> chipitsine, cron2, dazo, mattock ordex and syzzer participated in this
> meeting.
>=20
> Discussed tls-crypt-v2. Ordex has implemented this on the OpenVPN 3
> side. Syzzer is still working on it on the OpenVPN 2 side.
>=20
> --
>=20
> Discussed having a regular meeting schedule again. Agreed that having a
> one-hour meeting every Wednesday at 19:00 CEST makes sense. We will
> start the meetings next week (20th September).
>=20
> --
>=20
> Discussed the upcoming 2.4.4 release. We have enough commits for a
> maintenance release, but there is one security fix in the pipeline, as
> well as a fix to the NSI installer. It was agreed that the security fix
> should have a CVE. The release date was set to 25th September.

Just a slight correction here.  We will attempt to have the git tree
signed with the proper tags by September 25.  But aiming for the release
to happen soon after this have happened.

As we need to co-ordinate this with both CVE assignment and the PR team,
we need to have a somewhat flexible schedule to ensure everyone is aligned.

And for those wondering about the severity of this CVE; it is considered
to have a really low impact and not being critical at all.  This
requires a special option to be used, which is also believed to be very
seldom used.  But as it can be more critical if this option is used, we
decided to request a CVE for it.

[...snip...]
> Briefly discussed dazo's lz4 v2 patch. Cron2 promised to review it in
> the next few days.

The patch which was referenced is this one:
<https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15396.=
html>


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--61xM6kfUpxsHkSQc7LKgT278CHQb7J7mR--

--E0hsgC2KS21bviTr0JahSimKKoR01xUxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZuHTkAAoJEIbPlEyWcf3yPf8P/0HfxLKc8aSA+WM+I9K1OVnS
pDeNZ3FvITDmG1grHBoBDt4ku/Dh2RL3j495PWnUIY4lJTbMhE6Es6h9mL+lKzK4
XT6yl9+Ix/nPgJmPKMQSXj6ZvdeTplcAGs3QWTXwl4/7TAPa4fZb6qhDL/1bvtiS
uaYiqQ34f13LRJIeRWqfT2Qod4paWsgE9JRH9Oli+o1BsAsiGM06uIXU42az+m9q
nGoDXZG9hELTn0udezztKN7vdOfrZbbG1JquW4Av61mnpV07JUftkUwpPRvOplAc
KokA9GP5fA4Vw8G/FqzJc591uoKdahGdp8351l3OwfYaTOa21NKK8Ll4nd4bDqjY
YaejPSaFAIQDTLmgYy/Yi/w3G8K02bNQby4HJbw6wKGMsRM3E+AEjnJ7XeGtwoGk
4F6Sj/DGboXiENnGC3llyTsgQcvvzwqtof6VT9zhYOtW+HYJVG1kTMAFs7j4Nt98
05pBdqlU07JMjQm4wKR6tHYLNoQt53+AEBwnobXiLGS7r8S80KfZ5a/3lSjzI5kA
NKSvEzEZONW/2rv0U1guy7ZsLtF2qCqef6Npki3X6VG9cLx+Vv8KJXombeJQkX8B
Xt7BEGHgZSjA8DQcLYr/RCj2KO1sK2TzPCE6+1rVzehLU/mWRH4ubQxqFL7AlyQ0
ukVIBU7tPMEBL5jMcOTU
=Gxuf
-----END PGP SIGNATURE-----

--E0hsgC2KS21bviTr0JahSimKKoR01xUxh--

