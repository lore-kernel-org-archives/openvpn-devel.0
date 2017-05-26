Date: Fri, 26 May 2017 18:56:06 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170526165606.GQ97029@...1296...>
References: <8737brk7vm.fsf@...2274...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T/5gogCFEf4tDWvL"
Content-Disposition: inline
In-Reply-To: <8737brk7vm.fsf@...2274...>
Subject: Re: [Openvpn-devel] Alignement crash on sparc64
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, Stefan Sperling <stsp@...2273...>

--T/5gogCFEf4tDWvL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, May 26, 2017 at 04:30:53PM +0200, Jeremie Courreges-Anglas wrote:
> I am the maintainer of openvpn in the OpenBSD ports tree.  Here's
> a report from Stefan Sperling (Cc'ed).
>=20
> > An openvpn server running on OpenBSD/sparc64 6.1 crashes when a client
> > connects and starts doing traffic. Is anyone else seeing this?

Thanks for the report.  I'll look into it.

Copying around the IP header doesn't feel like the proper solution,=20
though - it's basically replacing an unaligned access somewhere with
a larger (unaligned!) mem copy, where most likely changing a word
access to 2x byte access (etc) might achieve the same thing without
copying.

> To work around this, the patch below (also written by Stefan) was
> committed in our ports tree.  TARGET_FREEBSD and TARGET_DRAGONFLY seem
> to be affected too.

FreeBSD/Sparc64 traps unaligned memory accesses and handles them=20
kernel-side.  So you'll see a slowdown, but no signal.

Linux/Sparc64 has the same restrictions (unaligned access causing a
signal), but nobody has reported that yet, so maybe the underlying
memory alignment of the allocated buffer happens to be good enough=20
there.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--T/5gogCFEf4tDWvL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZKF4mAAoJEB2Cnv7KVigSysoMAKeqb/8QpJqAftw2oQhLECq3
QuXgOOzWCCR02kB/6wsJsge2sGdUs+TTxX7vF9e0fV/+kG+VJX0jigzq2XkXxH0c
LryL/1w6CVXGjay5VHQURZa0R9v0Du1NFRfqUx4u68nZB1yfPyx2CmYlKHZY+u19
gwyarfaFUrCYSd/SchhpR4N4pw7ztJDnzq1smoQVpoLQ+6qe6z0+Mpcv6reNbEYd
vxTmor+7OXtuVKZnJRxaFCg/7vFJmJiljpJguw5+xPJHatCg8K1F9iEiMjKAJ4YU
Zcdy8W6Ak602qQgo81lwY6p/IqNY0js1Z0kcqJ+5xWTvB3oI5ZoO59xa6ignuCAt
880TeUJ6govt/4evla6FtgfAqjfkpzu1Rusjkhx5FbF3E+W1VD8xx1uF+po5E+ZE
Sk6c/8EJ7NIrancSA7n2fT0wCw54x7zys8/879cfAiiNN0ELTm96g+GjmN5SoRdc
AEMvLY1aVMOJxNeUu+vMq+gD5AYkDl8DHhFgwdPoUg==
=32kI
-----END PGP SIGNATURE-----

--T/5gogCFEf4tDWvL--

