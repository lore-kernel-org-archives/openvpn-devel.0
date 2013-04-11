Date: Thu, 11 Apr 2013 15:27:57 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130411132757.GV569@...1296...>
References: <1346422753-19520-1-git-send-email-arne@...1227...>
	<201304110933.r3B9XwPT011987@...1729...>
	<20130411105202.GA26778@...1296...>
	<5166B459.9020801@...515...>
	<20130411131748.GR569@...1296...> <5166B9BE.80201@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jTlsQtO0VwrbBARu"
Content-Disposition: inline
In-Reply-To: <5166B9BE.80201@...515...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add the client id (CID) to
	the output of the status command
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--jTlsQtO0VwrbBARu
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 11, 2013 at 04:25:18PM +0300, Samuli Sepp=E4nen wrote:
> As long as nobody is actually using the staging repo rewriting history
> should not be an issue. Perhaps one could just do
>=20
> $ git reset --hard HEAD^1
> $ git push origin master
>=20
> and be done with it?

Will that un-push already-pushed commits?  Or just have "one commit less
than $remote" in your local repo?

(You see that I still do not understand all of the subtleties of git)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--jTlsQtO0VwrbBARu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUWa6XKkuBuNlUUl1AQKA1gP/UePCUxClzcW62YyXwmzc3JyWwmuH2Vfa
+LAG+Gy63/u2nVZdJHrGuAgw63AxGlNKInwhw9QP3pLe7tMIOUHhCCEr5kSwMcio
wmDBPG4dI2ZkCZb+ty6GiRZTSVzHOD0TCg1e5X3aL6us5vK1eZ0UeAUgLQrAcQXg
9ahg8FWnkpE=
=y453
-----END PGP SIGNATURE-----

--jTlsQtO0VwrbBARu--

