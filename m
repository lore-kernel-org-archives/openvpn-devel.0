Date: Sat, 6 Sep 2014 13:59:25 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140906115925.GZ1118@...1296...>
References: <1409930731-15263-1-git-send-email-davids@...1347...>
	<1409930731-15263-2-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1GVJVyXpDjW/I2t4"
Content-Disposition: inline
In-Reply-To: <1409930731-15263-2-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH 1/4] Don't let openvpn_popen() keep
	zombies around
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: davids@...1347...
Cc: openvpn-devel@lists.sourceforge.net, fcrozat@...1519...

--1GVJVyXpDjW/I2t4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Sep 05, 2014 at 05:25:28PM +0200, davids@...1347... wrote:
> From: David Sommerseth <davids@...1347...>
>=20
> Commit 9449e6a9eba30c9ed054f57d630a88c9f087080f introduced the
> openvpn_popen() function to support retrieving passwords via systemd.
>=20
> It was discovered that the child processes openvpn fork()ed would
> be lingering around until openvpn stopped.  This was due to the lack
> of a wait() call.
>=20
> This patch also cleans up a few minor white-space issues in the same
> code segment.
>=20
>  [v2 proper initialisation of status variable]

ACK.=20=20

(As a side note: not that the initialization of "status" makes any sense=20
here :-), as even if waitpid() wouldn't set it due to some freak incident,=
=20
it will never be used afterwards.  But the general introduction of wait()
in one of its forms is needed here, yes)

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--1GVJVyXpDjW/I2t4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVAr3HakuBuNlUUl1AQKkZAQAn1OGJ+6Z3fmRH1ep4elz41eB4x8EqfQ8
KHZPd5v/mTtj7m/kXARTsPK7ud8xDZM4HvgKIoy2fhJZc3zS73WU2xEyFlPoRMr2
tVcw9IEGacJsck4XTgPUc0QTWl+lLTXpzEMyQrdYbseCbmQhQkx3plbTJq/s/k6e
xE7EO4MphUM=
=Qfaa
-----END PGP SIGNATURE-----

--1GVJVyXpDjW/I2t4--

