Date: Tue, 12 Mar 2013 13:43:02 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20130312124302.GS953@...1296...>
References: <C673F57BE2DD3148AC2DD4AF464686F901BBDB56@...1815...>
	<1363032625-23311-1-git-send-email-gert@...1296...>
	<513E4DEB.7000403@...1227...>
	<20130312100706.GN953@...1296...>
	<C673F57BE2DD3148AC2DD4AF464686F901BEBFC7@...1815...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cQYPpkLLLIn+TToK"
Content-Disposition: inline
In-Reply-To: <C673F57BE2DD3148AC2DD4AF464686F901BEBFC7@...1815...>
Subject: Re: [Openvpn-devel] [PATCH v2] Repair "tcp server queue
	overflow"	brokenness, more <stdbool.h> fallout.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Peter Caprioli <petercap@...530...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--cQYPpkLLLIn+TToK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 12, 2013 at 11:08:29AM +0000, Peter Caprioli wrote:
> I'll ACK the bool -> int patch, it resolves the issue in ticket 263.

Thanks for bisecting this, and for verifying that the patch indeed fixes
the original problem (besides being "obviously correct" :) ).

Committed and pushed to master and release/2.3 branch.

commit 0eb398501fab9c016b9b6008682c43873c4a6188 (master)
commit 80b4b1e740de60a7f94132ac4bebcd9474fbe182 (release/2.3)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--cQYPpkLLLIn+TToK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUT8i1qkuBuNlUUl1AQLHHwQAhAyfO0FHCH3iNRsx3JgEMN7tWAaq53yy
W5kBkuGRhE/Ro0iwwnib/qBTKDyxk55DkOgxe/YJMWr5gyT9MvDarIGyTnk+GQa4
oeeCGTMyw8rB998beIQAl92vjY5TJHnQkoE2KoPXLkG/f6Zps6iZ9QgPW+rEfdyP
NE5vej10V84=
=NlRA
-----END PGP SIGNATURE-----

--cQYPpkLLLIn+TToK--

