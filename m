Date: Sat, 3 Dec 2011 11:28:30 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111203102830.GI8496@...1296...>
References: <1322823755-18052-1-git-send-email-davids@...1347...>
	<20111203100926.GE8496@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6FF8uHqHuTyeKjm"
Content-Disposition: inline
In-Reply-To: <20111203100926.GE8496@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Provide an access() wrapper for Windows
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

--d6FF8uHqHuTyeKjm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Dec 03, 2011 at 11:09:26AM +0100, Gert Doering wrote:
> On Fri, Dec 02, 2011 at 12:02:35PM +0100, David Sommerseth wrote:
> > Commit 0f2bc0dd92f43c91e33bba8a66b06b98f281efc1 adds extra file and
> > directory checks at startup.  However, this patch makes use of some
> > features not directly available in Windows.
> >
> > This patch avoids #include <unistd.h> on Windows and provides a
> > wrapper for the needed access() function.
>=20
> ACK.

... reading up further mails related to this patch, I like Alon's idea
to do this with autoconf/compat.h/compat.c - this looks like it would
save us much work in the long run, instead of coming up with hacks of
our own every time a function is missing.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--d6FF8uHqHuTyeKjm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTtn5zqkuBuNlUUl1AQIOgAP/aIvTecx6e0YeLHPqZkKEF7K2mC12k+E8
JFJ53yrxcFAFXJXRNG4HRuEd0luWRrEQnPW9Csm/nxjX0/2SLD2sLhtsisbAFu3U
Y6rvbnBzaRbHmGAs5ProSANA28gLOQW/fV1GC6t1g6XVEqFiBxjlBew/NAvorMi0
pAEubipUC10=
=6DUA
-----END PGP SIGNATURE-----

--d6FF8uHqHuTyeKjm--

