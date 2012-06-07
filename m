Message-ID: <4FD090F7.3010506@...1114...>
Date: Thu, 07 Jun 2012 13:31:03 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz3gNKF8OmTjm+rb_8-Wi0pzuihwh5u_85X-3sgsb3Bqfw@...278...>
	<1339061824-16542-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1339061824-16542-1-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] build: support =polarssl-1.1.0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/06/12 11:37, Alon Bar-Lev wrote:
> Repoted-by: Samuli Sepp=C3=A4nen <samuli@...515...> Signed-off-by:
> Alon Bar-Lev <alon.barlev@...277...> --- configure.ac |    2 +- 1
> files changed, 1 insertions(+), 1 deletions(-)
>=20

Applied to the master branch.  I fixed a typo in the commit message
and made the the subject clearer.


commit 9eb058556d3e550e9b811a3ddc30be66635d4221
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Thu Jun 7 12:37:04 2012 +0300

    build: do not support <polarssl-1.1.0

    Reported-by: Samuli Sepp=C3=A4nen <samuli@...515...>
    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Samuli Sepp=C3=A4nen <samuli@...515...>
    Acked-by: Adriaan de Jong <dejong@...1435...>
    Message-Id: 1339061824-16542-1-git-send-email-alon.barlev@...277...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6686
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/QkPQACgkQDC186MBRfrpiJACgsXg16hYEmH8D/npFrTem7dGT
SYcAmwZKgwMHB/nfxpUA//SbFs9ZTzCW
=3Dg5eZ
-----END PGP SIGNATURE-----

