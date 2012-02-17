Date: Fri, 17 Feb 2012 13:06:50 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120217120650.GU7024@...1296...>
References: <1329478233-20295-1-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OmL7C/BU0IhhC9Of"
Content-Disposition: inline
In-Reply-To: <1329478233-20295-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Makefile.am was missing ssl_common.h
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

--OmL7C/BU0IhhC9Of
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Feb 17, 2012 at 12:30:33PM +0100, David Sommerseth wrote:
> In commit 9a160b796e1a40f9635231e5533ce40d46dba25f ssl_common.h
> was introduced, but never listed as a source file in Makefile.am

ACK, together with the other one.

(Side remark: buildbot should do "make distcheck", at least on one of
the instances - so we see this right away when moving around files)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--OmL7C/BU0IhhC9Of
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTz5C2qkuBuNlUUl1AQL9JwP/X42XESUl2W2BhZYjc0WDmzoNnYLsy4TZ
mkm6+rhXRhEkAPF8zVJxgIT57a/cxFs2nDBqi2bcmoS0GV9WvWNSEyoJ23YuYWdx
Bq1RBPD4TF+GPA6Yi5EnM7guwnlSfw3nmObaSPoY6f7kUZA81xdnlxrtFFdu6X37
o80ZRZBUbRg=
=poOU
-----END PGP SIGNATURE-----

--OmL7C/BU0IhhC9Of--

