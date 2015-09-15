Date: Tue, 15 Sep 2015 13:15:52 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150915111552.GO34798@...1296...>
References: <1441985627-14822-1-git-send-email-gert@...1296...>
	<1441985627-14822-8-git-send-email-gert@...1296...>
	<55F7FC94.6060708@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c6397Mob2532IpCX"
Content-Disposition: inline
In-Reply-To: <55F7FC94.6060708@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 07/10] Implement '--redirect-gateway
	ipv6'
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--c6397Mob2532IpCX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Sep 15, 2015 at 12:10:12PM +0100, Arne Schwabe wrote:
> > +  if ( options->routes_ipv6->flags & RG_REROUTE_GW )
> > +    {
> > +      char *opt_list[] =3D { "::/3", "2000::/4", "3000::/4", "fc00::/7=
", NULL };
> > +      int i;
> > +
> >
> I cannot judge how good or bad this default list is. I usually have don
> the the ::/1 and 8000::/1 stuff.

I have seen "2000::/3" used in the wild - some older CentOs boxes just
did not like ::/0 as default.  This is why...

4::/4 to e::/4 are not covered right now, as this is not IPv6 unicast space
(it is very likely to eventually be, but then this is easily extended).

Technically, 0::/4 and 1::/4 are not either, but I have seen those used
internally.

We could go for ::/1, 8000::/1 plus 2000::/4 to cover the 2000::/3
case *and* all the address space available, no matter which weird
networks are used...  or be totally correct and remove the ::/3, to cover
*only* the officially designated space.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--c6397Mob2532IpCX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVff956kuBuNlUUl1AQK7RQP9EcuVklCRILiNkxteSfGubrFMKiEHcDbg
7aTRpn9TNC0dsrh9oBXh1Hq0xc0fpbGlo46q+o57+x695GM4mJvpp0VRodKL7mAF
wCJmW6+Std8la+hZQsUwWyym1Dj04TUPqvp05cDVgAAyd3+10L323J6+XOpm0d0o
kc+6aPhE9YU=
=NGrU
-----END PGP SIGNATURE-----

--c6397Mob2532IpCX--

