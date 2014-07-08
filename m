Date: Tue, 8 Jul 2014 21:22:07 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140708192207.GV1118@...1296...>
References: <1402244175-31462-5-git-send-email-steffan@...1856...>
	<201407072009.s67K9YQ0010531@...1295...>
	<53BAFFD3.2070207@...1856...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S6lVrJQMb5zD9/0X"
Content-Disposition: inline
In-Reply-To: <53BAFFD3.2070207@...1856...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Extend t_lpback tests to
	test all ciphers reported by --show-ciphers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--S6lVrJQMb5zD9/0X
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jul 07, 2014 at 10:15:15PM +0200, Steffan Karger wrote:
> On 07-07-14 22:09, Gert Doering wrote:
> > Your patch has been applied to the master branch.
>=20
> Thanks. These are actually bugfixes for stuff that should just work in
> 2.3 too, so I suggest to apply these patches, including the preceding
> OFB/CFB fix by Heiko (be46a2c083a6bd77754bc1674249eab583d25dac) to the
> release/2.3 branch too. That will close trac ticket #89.

OK.  Patch series cherry-picked to release/2.3 as well, git log below.

Will be pushed in a minute, as soon as "make check" succeeded.

gert


$ git log --pretty=3Dshort
commit 9ce3670aee49d8c4407983af014663dc6185f166
Author: Gert Doering <gert@...1296...>

    Fix t_lpback.sh platform-dependent failures

commit e97aa06dc058dd099cf3a5facde73aa92d61277c
Author: Steffan Karger <steffan@...1856...>

    Extend t_lpback tests to test all ciphers reported by --show-ciphers

commit d66ba9b212e95cdd1880be58036e62d59e5dbb6a
Author: Steffan Karger <steffan@...1856...>

    Improve --show-ciphers to show if a cipher can be used in static key mo=
de

commit deff485f85e0eb9502f1ed2cdda2dd41a429fe58
Author: Steffan Karger <steffan@...1856...>

    Add proper check for crypto modes (CBC or OFB/CFB)

commit f71a780fa5224c5de0859aad1a34ebd8a92165a0
Author: Steffan Karger <steffan@...1856...>

    Rename ALLOW_NON_CBC_CIPHERS to ENABLE_OFB_CFB_MODE, and add to configu=
re.

commit f1b532d5646143897e291a6c0d3842badf6cc677
Author: Heiko Hund <heiko.hund@...1489...>

    refine assertion to allow other modes than CBC


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--S6lVrJQMb5zD9/0X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU7xE36kuBuNlUUl1AQKpZwQAg1w6UtiwZTQeh5T/ug8+CcY7DCuHaXx4
TBZE9IhOIwbxG9x/2U1pyhmV3lz1zxiUx1uvI70otKcWs/yO3GrfQWFVYYBd48pU
AfRUY+QubTtdP7733T1BL6A4Na9p/gZBhHJVHUSthi+6Ly1zq4rw4uvcOLDObrpK
R4eo6WPbQGg=
=rwuy
-----END PGP SIGNATURE-----

--S6lVrJQMb5zD9/0X--

