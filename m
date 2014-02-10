Date: Mon, 10 Feb 2014 10:35:43 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140210093543.GX16637@...1296...>
References: <52F6E3AF.1080400@...1030...>
	<20140209115057.GT16637@...1296...>
	<CAAbSJMUyKqqup1-nBuUsXNVuaaj93YWg0JxcqeBicU1QhtTrkw@...278...>
	<20140209151951.GU16637@...1296...>
	<52F7A006.4010302@...1227...>
	<CAAbSJMWyDjSNdXM6AZPDeevAtR=bBg8C1sbUBY+64hLri2oOLg@...278...>
	<52F7AB7E.7000502@...1227...> <52F8981A.7030603@...1030...>
	<CAAbSJMUE4rkDbuTQ=zzY1pg8v4d7eC2TZ58pTAJC6k-N3yM0gw@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xU0InBYDQy8cK3qi"
Content-Disposition: inline
In-Reply-To: <CAAbSJMUE4rkDbuTQ=zzY1pg8v4d7eC2TZ58pTAJC6k-N3yM0gw@...278...>
Subject: Re: [Openvpn-devel] --local, --lport and --bind
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Mickael Chazaux <mickael.chazaux@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--xU0InBYDQy8cK3qi
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Feb 10, 2014 at 10:30:25AM +0100, Mickael Chazaux wrote:
> > So, can I use this undocumented option to allow the OS to determine a
> > random port for me?
> It works at least on version 2.2.1.

Then it will also work in 2.3.x, but it might have been broken by the
changes introduced by the dual stack patches in git master (-> 2.4).  We
need to test this.

And then document :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--xU0InBYDQy8cK3qi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUvidb6kuBuNlUUl1AQLPtgP/Wz9lhX3x91b25Jn05Zi6Mvk4+mHRKDz0
sXStmwnf/My39jY8st4DY3RQbURwZ6ASlJcHsoapdzqy/S/2LDQJTbB0GeQLrlV1
vdLlQ+xGeE3pWWuBWWOBzEuIY9H0wgz5u3LTivod9HeIqf11lKnwr2VW4Xq2bGbT
UQYoaGLys8s=
=tsFf
-----END PGP SIGNATURE-----

--xU0InBYDQy8cK3qi--

