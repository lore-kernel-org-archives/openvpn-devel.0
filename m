From: Hubert Kario <hkario@...1347...>
Date: Wed, 04 Jan 2017 13:41:53 +0100
Message-ID: <1798300.SLzIvfLzrO@...2232...>
In-Reply-To: <20161207120430.GY78624@...1296...>
References: <CAFHpkQFgmWBhUb6YZOGFeR7Eyz34tFbN5BQEzafj0tpqtbmwyQ@...278...>
	<CAFHpkQGqHrFwCLMEvu9tEAQg3heWaAWcEQDyidG5z0ZLNgkL_Q@...278...>
	<20161207120430.GY78624@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13491097.HzGvSmHBsU";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] fuzz testing by google ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--nextPart13491097.HzGvSmHBsU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday, 7 December 2016 13:04:30 CET Gert Doering wrote:
> Hi,
>=20
> On Wed, Dec 07, 2016 at 04:51:36PM +0500, ???????? ?????????????? wrote:
> > it used to crash on simple tcp connect (after immediate disconnect), it
> > was
> > reproducible to running login/password authentication mode
> >=20
> > it might have been caught by fuzz testing.
>=20
> I should point out that this was not a "crash" but an "openvpn detects
> invalid input and ASSERT()s out -> well-defined program exit".
>=20
> Not exactly *friendly* behaviour (and stupid, in this case), but not
> a *crash*.
>=20
> But that's exactly why fuzzing openvpn is hard: we detect bad stuff, and
> in doubt, we ASSERT() - which is well-defined behaviour, not "crashing
> randomly, possibly in a way that can be exploited to get access to
> security critical bits"

It still results in a denial of service. Yes, far less severe than private =
key=20
leak or remote code execution, but a severe vulnerability none the less.

--=20
Regards,
Hubert Kario
Senior Quality Engineer, QE BaseOS Security team
Web: www.cz.redhat.com
Red Hat Czech s.r.o., Purky=C5=88ova 99/71, 612 45, Brno, Czech Republic=

--nextPart13491097.HzGvSmHBsU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJYbO2RAAoJEJKo0bgB0vX1doMP/iTpTCcK0lPeX5JnsWuqwXhd
tIIZlkSQpiNYQ8HjYUBeJjvP+fvZIjD8gQp1QfmBsvWMI576K9EdNosuf/T75UnH
s9MPzsDCiISFdjxgkLKN9TAeoiGtcHmiztcoxOTVoyH4pk0cGmN5Ibgb3k+KLpVE
+HiJETBpT3eCZfcwkwp3/kpbET8iMt6OOoxFhnWsj4F482nNFvJne9Eqb6DDuG9W
tbFmBpKUA57gMUE+qTyEupmstiEpUmT+uRpCtkaRpp/GcsieDnLJGiTMdtz0xHtK
P7CcUxTZPGwQmzxxRTiTcH3ol41HeSN1VSC0UuhCBCBUCiWKQMDO6OJ90aivGSfw
hPZ5H5aR63dKel0L3/2YRFp7C4t8G+07dIz3MdksVqhZ3jHsf/7SoYFCNQRYPMxf
TbERzVbNtcM/7OilULF4piyiNn/VIOVXUeXbucS01Z9eI/bmXa51EKpPTVJVSfnA
S1oqUHkr+pW0l8/9CjG6ARbLUsKalYGzA55ZqEWAB16lt15avha2XcZK5K5hsUzu
H4SyVurH7P12Z+Fd81DFC8Lgnn/R24BWAQ3W8BZbK6FI6kNiSolVJ3SocZV4dCnU
UyO5T5dKIEx0jPeM0q6MR//stkqGAI/CJ19sjiQ7RiJWXzDP8Cg8YcKMWWWEUHuM
IvDMjg79Z/xJAmxnkMON
=FwOt
-----END PGP SIGNATURE-----

--nextPart13491097.HzGvSmHBsU--


