Date: Tue, 24 Nov 2015 21:11:35 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151124201135.GM24952@...1296...>
References: <564BA6DB.4070703@...2070...>
	<564DE8B3.9030803@...2070...>
	<20151124083944.GY24952@...1296...>
	<5654A314.3080607@...2070...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zxhbmr+fMFEUWeNp"
Content-Disposition: inline
In-Reply-To: <5654A314.3080607@...2070...>
Subject: Re: [Openvpn-devel] [PATCH v4-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <iam@...2070...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Zxhbmr+fMFEUWeNp
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 24, 2015 at 08:49:08PM +0300, ValdikSS wrote:
> I can't figure out why Thunderbird corrupts my patches.

Because you're not using git send-email :)

 $ git send-email --to=3Dopenvpn-devel@lists.sourceforge.net -1

will magically do everything perfectly (added options available to set=20
in-reply-to: to make threading work, etc., and you can configure it via=20
.git/config to use the right SMTP server with authentication etc).

It's mostly there because clients are just too brain damaged to leave
patches alone.  *Attachment* sometimes works, and sometimes not
(supposedly thunderbird gets that part right, but gmail for example
fails even this)

> Please use the attached version.

I'll see if that applies...

> I still need help with 2.3 build system. If somebody willing to help me, =
please use the attached version.

Well, the 2.3 version would need all the #ifdefs around the code if not
running at VISTA level, and *no* changes to the build system part (so,
2.3 out of the box would simply not "see" this code at all).=20=20

Samuli would then have to change part of his build system to enable VISTA=20
API level and add these extra libraries - but that would have to be an=20
out-of-tree patch applied only to the Vista-and-up installers.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Zxhbmr+fMFEUWeNp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVlTEdqkuBuNlUUl1AQJdrgP9EwGGyFVhSi/uHJD0rmAbCJLgz8Mc6hrh
/wiiX5vLW5+Oy3BD77N4HHtODbBnlnOLjAEm3X1ps/9Ey2CHIbCGTWcZ/eJkkk0I
mu11nQHgeU+oMcY+DBJ2MHEmWUYmKuw152rcHxWoe3oVwbWqmPZln6JlE/tEHxYJ
FBR2C0ZqdGg=
=/x4a
-----END PGP SIGNATURE-----

--Zxhbmr+fMFEUWeNp--

