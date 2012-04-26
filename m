Message-ID: <4F999F09.4000801@...1114...>
Date: Thu, 26 Apr 2012 21:16:25 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1334213412-10048-1-git-send-email-dejong@...1435...>
In-Reply-To: <1334213412-10048-1-git-send-email-dejong@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Ensure sys/un.h autoconf detection
 includes sys/socket.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/04/12 08:50, Adriaan de Jong wrote:
> This is required to build an Android binary.
> 
> Signed-off-by: Adriaan de Jong <dejong@...1435...> --- configure.ac
> |    4 ++-- 1 files changed, 2 insertions(+), 2 deletions(-)

Applied to master on -testing and -stable trees.


commit a2d747bb0397c5837ec2c80ae9a3c3267acbdb2c
Author: Adriaan de Jong <dejong@...1435...>
Date:   Thu Apr 12 08:50:12 2012 +0200

    Ensure sys/un.h autoconf detection includes sys/socket.h

    Signed-off-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: Alon Bar-Lev <alon.barlev@...277...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+ZnwkACgkQDC186MBRfrrdOgCfV9iH6r3UfSJllao6AnKXMGNf
qyMAn3dwIgCiDTNY5G3k4ZrTBToo6VWo
=dtCQ
-----END PGP SIGNATURE-----

