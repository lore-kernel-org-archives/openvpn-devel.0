From: "Daniel O'Connor" <doconnor@...351...>
Subject: Re: [Openvpn-devel] OpenVPN patch to load tun/tap dynamically
References: <200502101302.31213.doconnor@...351...> <20050210034342.GB26410@...352...>
In-Reply-To: <20050210034342.GB26410@...352...>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1139773.WxGlGajVyi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200502101433.21019.doconnor@...351...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Feb  9 20:05:38 2005
To: Waldemar Brodkorb <wbx@...270...>
Cc: openvpn-devel@lists.sourceforge.net, matthias.andree@...83...

--nextPart1139773.WxGlGajVyi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thu, 10 Feb 2005 14:13, Waldemar Brodkorb wrote:
> > I have a patch for OpenVPN to attempt to load if_tun.ko/if_tap.ko when
> > the first open attempt fails with either ENOENT or ENXIO. It's FreeBSD
> > only at the moment but I imagine it would work on (at least) NetBSD and
> > OpenBSD too.
>
> No need on OpenBSD. It is in GENERIC and kernel modules are not
> used. (most off the time, 99%)

It's the 1% that is annoying to debug in my experience :)

--=20
Daniel O'Connor software and network engineer
for Genesis Software - http://www.gsoft.com.au
"The nice thing about standards is that there
are so many of them to choose from."
  -- Andrew Tanenbaum
GPG Fingerprint - 5596 B766 97C0 0E94 4347 295E E593 DC20 7B3F CE8C

--nextPart1139773.WxGlGajVyi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (FreeBSD)

iD8DBQBCCt0I5ZPcIHs/zowRAnffAJ9cmEwWtdw8dGQgCBfYh/LrS3IbsgCfb9Jo
2ZWcLPRGvx52x7hdHX1QuuQ=
=dNsf
-----END PGP SIGNATURE-----

--nextPart1139773.WxGlGajVyi--

