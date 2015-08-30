Date: Sun, 30 Aug 2015 22:35:18 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150830203518.GV34798@...1296...>
References: <20150830002336.32791c7b.movrax-dev@...2061...>
	<20150830115444.GU34798@...1296...>
	<20150830162534.4ee0c9f2.movrax-dev@...2061...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ONmcTkPhtkbQYSLg"
Content-Disposition: inline
In-Reply-To: <20150830162534.4ee0c9f2.movrax-dev@...2061...>
Subject: Re: [Openvpn-devel] [PATCH] Privileges not being dropped if the
 first connection is not successful
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Lukasz K." <movrax-dev@...2061...>
Cc: openvpn-devel@lists.sourceforge.net

--ONmcTkPhtkbQYSLg
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Aug 30, 2015 at 04:25:34PM +0200, Lukasz K. wrote:
> > Which OpenVPN version is this about?  2.3.x up to 2.3.5, or
> > 2.3.6/.7/.8, or git master?
[..]
>=20
> Affected versions that I've checked so far:
> 2.1.3, 2.2.1, 2.3.4, 2.3.6, 2.3.7, 2.3.8, git (OpenVPN 2.3_git
> [git:master/291c227d2ccecaa9+])

Thanks, this is way more than I expected :-) - and it seems that we did
not fiddle with this part of the code yet, so it's time to do so.

On a first glance this v2 version looks good to me, but I need to look
a bit more into details at the surrounding code to check whether it
might have interesting side effects (we're good at that).

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ONmcTkPhtkbQYSLg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVeNpBakuBuNlUUl1AQK5pAQAk4zXURvHicEzepnq0/pZc3eawwwoBgPB
2AFhvFUqLPrPF+zVWEfAvhMyPB+TF6asqWoXx4Xfia54KzLFhVIfxjkYE9rQVGgw
Nh5uTwL03F2WEJgkkOyNDxMaCfNcZsmo9wQEdZDODfSu5O1m6r3neoimCy5A2LR1
dqeZ1mX7u9I=
=Kwi6
-----END PGP SIGNATURE-----

--ONmcTkPhtkbQYSLg--

