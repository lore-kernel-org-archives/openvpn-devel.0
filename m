Message-ID: <4DA80200.1020105@...1114...>
Date: Fri, 15 Apr 2011 10:29:52 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1302792220-9173-1-git-send-email-samuli@...515...>
In-Reply-To: <1302792220-9173-1-git-send-email-samuli@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Fixed copying of tapinstall.exe to
 dist/bin when using prebuilt TAP-drivers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 14/04/11 16:43, Samuli Seppänen wrote:
> Signed-off-by: Samuli Seppänen <samuli@...515...>
> ---
>  win/make_dist.py |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

ACK.  Applied to master and beta2.2

commit f71233577e573c5d1dc0cd711b7b78867a7853be (beta2.2)
commit 343037a99708bd7785de10cc5be37a150609bd01 (master)
Author: Samuli Seppänen <samuli@...515...>
Date:   Thu Apr 14 17:43:40 2011 +0300

    Fixed copying of tapinstall.exe to dist/bin when using prebuilt
    TAP-drivers

    Signed-off-by: Samuli Seppänen <samuli@...515...>
    Acked-by: David Sommerseth <dazo@...384...>
    Signed-off-by: David Sommerseth <dazo@...384...>


Kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2oAf8ACgkQDC186MBRfrrK6ACfQsgyQvYG2jgqrE6jFpqXQljw
i0MAn3kYpyswjRu0SutaBVimF/XQ90X4
=gmLp
-----END PGP SIGNATURE-----

