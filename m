Date: Fri, 3 Jun 2011 19:22:24 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110603172224.GC8496@...1296...>
References: <1307102025-18627-1-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IjidByZJ9GyRdto8"
Content-Disposition: inline
In-Reply-To: <1307102025-18627-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Remove support for Linux 2.2
	configuration fallback
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

--IjidByZJ9GyRdto8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 03, 2011 at 01:53:45PM +0200, David Sommerseth wrote:
> Considering that the last Linux 2.2 update was released 25-Feb-2004
> and the first Linux 2.4 release came 04-Jan-2001, there are no
> reasonable reasons to help users to stay on outdated kernels.
> I consider this extra code path just waste of bytes ... so lets make
> the world simpler.

Basically, I agree on the idea, but I think there's more that should
be thrown out...

#if defined(TARGET_LINUX)

#ifdef HAVE_LINUX_IF_TUN_H      /* New driver support */

...

#else
=20=20=20=20=20=20=20=20=20=20
void=20=20
open_tun (const char *dev, const char *dev_type, const char *dev_node, stru=
ct tu
ntap *tt)
{=20=20=20=20=20
  open_tun_generic (dev, dev_type, dev_node, false, true, tt);
}=20=20=20=20=20
=20=20=20=20
#endif /* HAVE_LINUX_IF_TUN_H */

...

/*
 * This can be removed in future
 * when all systems will use newer
 * linux-headers
 */
#ifndef TUNSETOWNER
#define TUNSETOWNER     _IOW('T', 204, int)
#endif
#ifndef TUNSETGROUP
#define TUNSETGROUP     _IOW('T', 206, int)
#endif


and of course...

#if LINUX_IPV6 =3D=3D 0
  if ( tt->ipv6 )
    msg (M_WARN, "NOTE: explicit support for IPv6 tun devices is not provid=
ed fo
r this OS");
#endif


... so: consider this an ACK, but there's more to do :-)


Now, what did we agree was the oldest linux distribution that we wanted
to support?  Need to setup a VM with that, and then rip out stuff, and
verify that things still compile, ...

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--IjidByZJ9GyRdto8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTekYUKkuBuNlUUl1AQKdewP/VP1J6AeHYg5bZUHC7Hmupntb6DhrMEHL
H50GiHDxs4WHmZsy0WDMIkt2R5/HGCNs01n+VZRkKP6ZtM2UkplLGzEFROSUhfok
ayZDMEgG9cs2/R75EPD6BrhoYT9PGuM3tvdDTMemtMrVrsBxeLW+jCbxi+TZrXy4
CvGfU5hq/ME=
=/HFs
-----END PGP SIGNATURE-----

--IjidByZJ9GyRdto8--

