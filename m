Date: Fri, 14 Oct 2016 14:42:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20161014124202.GM28918@...1296...>
References: <38d71c0a-e3f8-437c-12f9-f654e91682b7@...2080...>
	<1476377656-3150-1-git-send-email-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h3LYUU6HlUDSAOzy"
Content-Disposition: inline
In-Reply-To: <1476377656-3150-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [Patch v5] Remove tun-ipv6 Option. Instead
 assume that IPv6 is always supported.
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

--h3LYUU6HlUDSAOzy
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Oct 13, 2016 at 06:54:16PM +0200, Arne Schwabe wrote:
> Patch V5: Assume generic OS in tun.c is also IPv6 capable. Add changes to=
 man page. Fix typos/change message as suggest by David.

Patch still looks reasonable.  Since David tested Linux, I gave NetBSD 5.1
a run for the money (other platforms have no platform-specific code that
might be broken).

What can I say?  This stuff works :-)

 Test sets succeded: 1 1a 2 2b 2c 3 4 5.
 Test sets failed: 2a.

(That I actually ran 2a is an oversight - it's the IPv4 --multihome test
which I know is broken on NetBSD, unrelated to this patch)

So, throw in an ACK from me, too.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--h3LYUU6HlUDSAOzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWADSmqkuBuNlUUl1AQKl7QQAsrAJslOagAKXGd+yHxHJlltGH+OwzYGF
pv5jMtnJYALo6fb8KUG4dN/AFbm5o07aKIaD6jUeSdMGkAeYc0uPgt8ZWMoyR9PU
48o3FMZx2ybnxkYvmpvKHrTuF3tGiIyOvTU1pJRcvFvLqLSH5xL1cDV+BZNSvpxZ
YnjmZeJz2qQ=
=CeWF
-----END PGP SIGNATURE-----

--h3LYUU6HlUDSAOzy--

