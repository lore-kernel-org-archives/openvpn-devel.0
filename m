Date: Thu, 29 Dec 2016 21:57:33 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161229205733.GQ78624@...1296...>
References: <20161228130721.683-1-list@...1798...>
	<20161228185700.GJ78624@...1296...>
	<20161228203748.3ef54708@...1799...>
	<20161228210345.GM78624@...1296...>
	<9fd38acf-0f65-427c-e6f6-15d5aa425578@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XO56YmfyBH8vAq+5"
Content-Disposition: inline
In-Reply-To: <9fd38acf-0f65-427c-e6f6-15d5aa425578@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] fix timeout in non-TLS mode with
 systemd
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: Christian Hesse <mail@...1798...>

--XO56YmfyBH8vAq+5
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Dec 28, 2016 at 11:49:24PM +0100, David Sommerseth wrote:
> On 28/12/16 22:03, Gert Doering wrote:
> > nothing else but a subset of Linux distributions use systemd today,
>=20
> If including the "millions" of various Linux distributions on
> DistroWatch, you might very well be right.
>=20
> But a far better measuring point would be which Linux distributions the
> majority of Linux users do use.  And in my experience, the list which is
> gathered on wikipedia [1] covers what the vast majority of Linux users
> installs.  At least the majority of users I have met on various
> conferences over the last few years.
>=20
> [1] <https://en.wikipedia.org/wiki/Systemd#Adoption_and_reception>

My point was not whether it's "many" or "few" Linux distributions, but
it's "a (large) subset of Linux-only".  Even if it reaches 99% one day,=20
it's still "Linux", which makes it a more of a platform-dependent thing=20
for me, and not a "feature", when regarding "where do we want to have these
#ifdef".

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--XO56YmfyBH8vAq+5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYZXi8AAoJEB2Cnv7KVigSilML/j2jftV/bnossxURVP33WtY1
fm7YWhQVNg4hHc/sf7uK5DaWeEHE3MzRCEQCRKMRIR1TNYg3y8TBtpU0lBetWPM5
M+uF9M1ci6847vrWwao3FK9k+nHQPhIQ9vJvUZY2MQA5eD1EzHwRRRhiM6P+ultL
ngjzIMhifkECFm89PE4nOFVWh6v7CYoERLY8SJuslSMRhMlOI3vcU6lDtGajAsuy
3qclct89wqw6UQyQ2iKh36daPfeWOeOmoeQghRSGplsjhLt6SqEYt3HPUg26wFYI
iKKzx/06YH7LpV29Ztmr9MJJw/sXrKmRnwq3uocrDPcfcVRzfl0Hmx1MKNVPQ/tH
qw0t5ZuZK6GV5GRMquOvbRHm9JjwbNZcBXdSEjAlHtb7I0yAOrfyjmQsRFmWS6xK
r0a721IznLNk1Qnk4yb7I2epAe8TzelN5jzl6FiofgcJADlh7zpEJQfVPXHZJF8I
lRh+LgmbrbL699I1dYv2YLtRQMLWd1ZWAqmcMYpbFQ==
=/St7
-----END PGP SIGNATURE-----

--XO56YmfyBH8vAq+5--

