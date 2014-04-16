Date: Wed, 16 Apr 2014 15:56:26 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140416135626.GC16637@...1296...>
References: <1397645317-20116-1-git-send-email-Holger.Kummert@...1516...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t7XDmRjSUGJtXe31"
Content-Disposition: inline
In-Reply-To: <1397645317-20116-1-git-send-email-Holger.Kummert@...1516...>
Subject: Re: [Openvpn-devel] Fixes for HTTP proxy authentication with NTLM
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Holger Kummert <Holger.Kummert@...1516...>
Cc: openvpn-devel@lists.sourceforge.net

--t7XDmRjSUGJtXe31
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Apr 16, 2014 at 12:48:35PM +0200, Holger Kummert wrote:
> Any opinions?

First of all, a big thank you for taking this on :-) - there have been
a couple of bugs in our trac related to NTLM, but since none of the
developers really understand NTLM auth or have means to test it, nothing
ever happend.

I'll give the patch a thorough review in the next days and come back with
questions...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--t7XDmRjSUGJtXe31
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU06MCqkuBuNlUUl1AQLAQAP+J30z2V3oilmneQ2y/Pw2AfMc8LuaCBiX
H5GOtCWX6gAvSoTNYqE5ZTAkeTEiGHiwlI2/DYaLs0fjbPP6xdWJCrgeXDJtMFU+
M8zbNkCha9urEcotvD9NMNAt4mUtk8xoVeQNmRfbHPGliUbV1PSAOk29ADoPN/Ei
VFMuBoGcNxQ=
=q2cR
-----END PGP SIGNATURE-----

--t7XDmRjSUGJtXe31--

