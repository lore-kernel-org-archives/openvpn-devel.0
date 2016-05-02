Date: Mon, 2 May 2016 14:02:17 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160502120217.GZ53051@...1296...>
References: <20160502094733.GQ53051@...1296...>
	<CAFHpkQFoch_tEXiQjd5RgSQOokU7093rpNbtt_0nwaGK7=B5Vw@...278...>
	<20160502100924.GR53051@...1296...>
	<CAFHpkQE5EavzNgumLVC8Mg6HjSqDx2RgDWR+w=c-pALuRjm=qA@...278...>
	<20160502105615.GW53051@...1296...>
	<CAFHpkQFVFs8hvq-tdFXWOuw9azJfV9MZPfVVKsOcR7OVUefeyw@...278...>
	<20160502105957.GX53051@...1296...>
	<CAFHpkQGk-D1RL9=Fq8goiTbKaqpjn5QYR3qrT0AXSOtbiaU0gQ@...278...>
	<20160502111748.GY53051@...1296...>
	<CAFHpkQHwS0R3eWsCf3jKMJXqC9a55-mQnp_b=5zRg9kAW3qimw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3d1h++6StbrqEHAg"
Content-Disposition: inline
In-Reply-To: <CAFHpkQHwS0R3eWsCf3jKMJXqC9a55-mQnp_b=5zRg9kAW3qimw@...278...>
Subject: Re: [Openvpn-devel] CI for openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--3d1h++6StbrqEHAg
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, May 02, 2016 at 04:23:40PM +0500, ???????? ?????????????? wrote:
> and, there's no point in having variables uninitialized actually. you
> depend on vary strange issues like OS decision to initialize them with NU=
LL
> or whatever.

Well, there's a C standard, and that *requires* variables in BSS or DATA
segment to be initialized with 0.  So if a global (or static local) variabl=
e=20
ever ends up uninitialized, it's a C compiler or runtime bug.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--3d1h++6StbrqEHAg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVydByakuBuNlUUl1AQInnAQAjEFM1WPx20Gi6b/HV24zQPWSklYJoec1
pf/VEXGEHiAaIND/D1pZ2e1oyXbrz4+htG6yCiBW88YpPsCf1Au1Z6uUyO1Dw/2Z
OLghwzO+WmeSfEu3EDJ2P9niS5BK8+6kxtllIqIi3Y39IW2+BnIKB4BNuFJnxZdN
tmbjlHo+aZs=
=aenF
-----END PGP SIGNATURE-----

--3d1h++6StbrqEHAg--

