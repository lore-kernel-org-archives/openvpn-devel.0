Message-ID: <4C6E8859.5000903@...1114...>
Date: Fri, 20 Aug 2010 15:51:21 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1282143987-24356-1-git-send-email-dazo@...384...>
In-Reply-To: <1282143987-24356-1-git-send-email-dazo@...384...>
Subject: Re: [Openvpn-devel] [PATCH] More t_client.sh updates - exit with
 SKIP	when we want to skip
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 18/08/10 17:06, David Sommerseth wrote:
> Several places we exited with 0 instead of 77 when we want to indicate
> that we should skip this test.
> 
> Signed-off-by: David Sommerseth <dazo@...384...>

Late response, but it got applied to bugfix2.1, merged into allmerged
and beta2.2.

commit 30e37820dcb8a0549cc68ed17f1684c4bac1530b
Author: David Sommerseth <dazo@...384...>
Date:   Wed Aug 18 17:05:09 2010 +0200

    Signed-off-by: David Sommerseth <dazo@...384...>
    Acked-by: Gert Doering <gert@...1296...>


Kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkxuiFkACgkQDC186MBRfrp9agCgofQ3PB7JoA/f+Tsn/S1xyxoy
ZRIAniFS0CNJFKl6JJByHKz5zV9+4kXf
=exS9
-----END PGP SIGNATURE-----

