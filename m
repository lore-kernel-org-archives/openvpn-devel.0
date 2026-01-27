Date: Tue, 27 Jan 2026 23:07:06 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <aXk3ClJBS9_vsHpo@...1296...>
References: <0054b4ff-731a-4a23-b8e6-2cd312ae5557@...2722...>
 <CAEsd45TAbZGL2nifwf=Ex_1K1w=spTcjgca0Aqb760=s94EPLA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Mek6QWkcQOaYEzUw"
Content-Disposition: inline
In-Reply-To: <CAEsd45TAbZGL2nifwf=Ex_1K1w=spTcjgca0Aqb760=s94EPLA@...278...>
Subject: Re: [Openvpn-devel] IRC community meeting summary
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--Mek6QWkcQOaYEzUw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jan 27, 2026 at 02:23:38PM -0500, Jonathan K. Bullard wrote:
> Thanks, Johan, for these meeting summaries. They're very helpful.
>=20
> Can anyone make a ( non-binding : ) guess about the timing of the 2.6.18
> release and/or the 2.7 release?
>=20
> OpenSSL just released an update and I'd like to do a Tunnelblick release
> soon (within the next few days) but if 2.2.18 and/or 2.7 are also coming
> "soon" I might wait and include it/them, too.

The original plan was to avoid adding more patches to 2.7_rc5, and
release it "as 2.7.0" tomorrow(-ish).  Unfortunately people kept finding
bugs...

My current plan is 2.7_rc6 tomorrow or thursday(-ish), and 2.7.0 in
two weeks, with hopefully only very little changes between rc6 and .0.

As for 2.6.18, we could do that "in between", like, Wednesday next week
- there's quite a bit of goodness in that branch, so it makes sense to
use the opportunity.  I haven't looked at the OpenSSL release - is this
something urgent?  Or just using the opportunity?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Mek6QWkcQOaYEzUw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEti5qK05WVwt73GvgHYKe/spWKBIFAml5NwgACgkQHYKe/spW
KBI9LQwAlZ7/KZWlu4zqbmXRIZO5hfKUNo352T15JH8c0Vst2X+7zfd0h7y7v4Ho
hU40swyX56PEwWoFKHGKKKeKz6tssABdx61BXPYy9w8aFSBCq1D0cARgx9GZKs+S
7tripTW9emLuVX8b5uNJ8CxGRMnVaYV/CpRV3BwxHXarUajy21PRdifNY8PqZbdX
lMzvpK7/3MwKVcsM9rsie/b7bIr64Br5DPMEgjR2vytwEmGAXN/Zr0TKBi2Ydd1c
QVWucKKpt5sJmBROBfYZtcVQFy9MdbCv1YUT69AKaR93dtzEKMrZbBzmIFyBeBR8
ZHc4uxuOCAVi6X7Na+4wERDHfH7ve0AellkGuGiyy6ijIBm8Rea0dds/YJew2tRe
05dDKdXhBpidZ0+iErho+MbqbQa9sjVnH/T4GBCHNhDj6Fuq+Dys24xjIUApcN40
o+uuWUY2J60lBslrsXiFcjqTWC2EaJmJiH+J8h/WShyRImorHCV+e8QfEMq/yDb/
fg6HXCdy
=zyWt
-----END PGP SIGNATURE-----

--Mek6QWkcQOaYEzUw--

