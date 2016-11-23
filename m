Date: Wed, 23 Nov 2016 19:43:21 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161123184321.GA28918@...1296...>
References: <20161121091013.imxgfilt3byyqu7u@...30...>
	<1479896418-16190-1-git-send-email-gert@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j2h4gSmLcbDT9SXs"
Content-Disposition: inline
In-Reply-To: <1479896418-16190-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Refactor setting close-on-exec for
 socket FDs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--j2h4gSmLcbDT9SXs
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 23, 2016 at 11:20:18AM +0100, Gert Doering wrote:
> The existing code can leak socket FDs to the "--up" script, which is
> not desired.  Brought up by Alberto Gonzalez Iniesta, based on debian
> bug 367716.

I'm not sure if that patch is good enough yet.

Arne brought up "port-share" - where we fork processes, so it needs to
be ensured that whatever that process needs is still working.

In addition to that, we have "TCP server" processes, which create new
sockets not by calling socket() but by calling accept() on the listening
socket, which is not in one of thew set_cloexec() paths - but watch out,
*these* might be the ones needed for port-share.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--j2h4gSmLcbDT9SXs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWDXjSKkuBuNlUUl1AQJRlAQAqoc2/wbpmPOL7AxLPpfAWAc+f7W6sOOU
CmUkxYEkSysF9uZugW6Nm4pQZj+LOqAPVk/P2vpgh+HvRSr8ePBWFH+yqawtT6gm
KsPl47Wz0UVx0PK0oxwdzogMVOmpynITJEgyrT6m/syO2m8FyoLTKJ1GKuDaXA65
K7Lhm5EGv+4=
=bz+s
-----END PGP SIGNATURE-----

--j2h4gSmLcbDT9SXs--

