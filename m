References: <96d637db-5213-9bd6-8628-a89bd755010d@...277...>
	<f55a40ec-830c-ce21-d096-c52738f6c2ff@...277...>
	<21b41a9e-c3b6-b0a7-a492-1e8cf4b2258e@...515...>
	<95a192d1-940b-99e3-0ef1-957d113e6c9a@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <93db226d-6a48-faf7-5b35-3c5ca1880779@...2080...>
Date: Wed, 26 Apr 2017 12:12:19 +0200
MIME-Version: 1.0
In-Reply-To: <95a192d1-940b-99e3-0ef1-957d113e6c9a@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="p26E4sHSqq1bV6i26jLAIvQc3tbIQAH24"
Subject: Re: [Openvpn-devel] For Windows: DHCP Client dependency
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, debbie10t <debbie10t@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p26E4sHSqq1bV6i26jLAIvQc3tbIQAH24
Content-Type: multipart/mixed; boundary="R6t2osksN70glDRgXQX27svq2FGkHvaqs";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>,
	debbie10t <debbie10t@...277...>, "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>
Message-ID: <93db226d-6a48-faf7-5b35-3c5ca1880779@...2080...>
Subject: Re: [Openvpn-devel] For Windows: DHCP Client dependency
References: <96d637db-5213-9bd6-8628-a89bd755010d@...277...>
	<f55a40ec-830c-ce21-d096-c52738f6c2ff@...277...>
	<21b41a9e-c3b6-b0a7-a492-1e8cf4b2258e@...515...>
	<95a192d1-940b-99e3-0ef1-957d113e6c9a@...515...>
In-Reply-To: <95a192d1-940b-99e3-0ef1-957d113e6c9a@...515...>

--R6t2osksN70glDRgXQX27svq2FGkHvaqs
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 26/04/17 10:32, Samuli Sepp=E4nen wrote:
>=20
> So I made the anchor visible:
>=20
> <https://community.openvpn.net/openvpn/wiki/FAQ>
>=20
> Not necessarily very pretty, but should help users figure out which FAQ
> item they should click on.

It's not too ugly.  But I spotted something far more crucially
important.  Lots of the information is aged, not necessarily correct and
some needs to be updated.

Like, RPM packaging.  Using rpmbuild on tar.gz packages might work.
However, the openvpn.spec(.in) file we have is basically unmaintained.
It does not tackle the new world of systemd specifics (which impacts at
least RHEL/Fedora and SUSE).  There are also more RPM based distros,
which I have little knowledge of.  I would rather suggest we skip
providing this file.  Each distro have their own packaging guidelines
and preferences how to do things.  We should rather point users at those
maintained .spec files instead.

The IPv6 entry is also in desperate need of an update.

The bridging entries can be unified (at least have a common entry point,
where to dive deeper).  And it should also include a pointer to
http://community.openvpn.net/openvpn/wiki/BridgingAndRouting ... And we
really should as much as possible lead people away from bridging; it is
really not the right solution for most of our (community) users.

We should probably also have another group of entries, "Networking" ...

That's just the 5 minutes review of this page .... It's a good starting
point, but I think we should improve it a lot.   And I call for help
from the community! ;-)

Join the #openvpn IRC channel on FreeNode ... and we can discuss these
entries and how to organize things there.  (Nicks to really pay
attention to are: ecrist, krzee, danhunsaker, ordex, plaisthos, syzzer,
cron2, dazo - probably a few more, but those are at least a starting point)


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--R6t2osksN70glDRgXQX27svq2FGkHvaqs--

--p26E4sHSqq1bV6i26jLAIvQc3tbIQAH24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZAHKTAAoJEIbPlEyWcf3yUW8P/2ySn00NDj+hE/F1MEQgChiy
rWT2mThfkaF3qPWBKd6WZLC4iCtX8d8UqTkGKwztvb9P1S9ePXm4XKcbxCt1Xgku
QV0qPcsqwEcuX1kYDyVXSN8Em3fDD90/CU7hAVLfUBng/Zeh2SUMIpNr1xYGMWGZ
grMIq+aBQ7+6dXfcwUoz/J8xGUc3LvR3XQ9FxhDugbyhbFsW2bYaOEm+b+kxbIWO
28G7Jlt5rKJwVAgAWPI3fNyonJBvkyZMAwIsaSK5T0n/QY2eo575w+/IdCNczyiG
X2S/2GaqUfNWSpntLRotLg2+RlXBrYBIvZrVhQfmtAlFn2PruekUWWBJxU2jUutz
JSnHsvIW74sC91ELUTQ/8ygfewYHnADFO3+qxbrqZokPVWcgdMEUpb8wz+TFUI6p
Syde+8nW7P+q5YEscOFIxemi2XnJC71qIGvEKReOhjr5mz9Gl0W3kpbOlXJMlVs/
wZh9dWtc+3DDvqYtQ8d7VZxcCJZPP41UkoUePW64UoJXrKT1tuQpIJ9eBeW9RA+L
5ANZT+A5twxEux80VLOeFjUFL3jk3UkU7XAxtjUptlbnEv35xCvpDXM5gYGHHYxJ
BftqX93LOJ+kh9mftcOjnOtUOVWFQ1jq02L7aY+IW9a8B0N9olmSQYKuCwxVJSFe
Q75HC7AOCBCZFpkit+3L
=U6Hg
-----END PGP SIGNATURE-----

--p26E4sHSqq1bV6i26jLAIvQc3tbIQAH24--

