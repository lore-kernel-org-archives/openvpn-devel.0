Message-ID: <4F396431.8040800@...1114...>
Date: Mon, 13 Feb 2012 20:27:45 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1323280731-26083-1-git-send-email-heiko.hund@...1489...>
	<1328883222-25300-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1328883222-25300-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCHv2] handle Windows unicode paths
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
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/02/12 15:13, Heiko Hund wrote:
> Openvpn for Windows is not compiled as a Unicode binary and thus
> cannot handle paths which contain non-ASCII characters using the argv
> vector. Characters that are not present in the system codepage are
> simply replaced with a question mark, e.g. if started as 'openvpn
> --config домой.ovpn' the file '?????.ovpn' is tried to be opened as
> configuration.
> 
> The same applies to paths in config files which need to be UTF-8 
> encoded if they contain non ASCII characters. The option line 'key
> лев.pem' will lead to openvpn trying to open 'Ð»ÐµÐ².pem' on a system
> with codepage 1252.
> 
> This patch makes openvpn read the command line in UCS-2 and convert it
> to UTF-8 internally. Windows stores names in the filesystem in UCS-2. 
> When using a paths openvpn converts it from UTF-8 to UCS-2 and uses
> the wide character Windows API function.
> 
> Signed-off-by: Heiko Hund <heiko.hund@...1489...> ---
> 
> This version of the patch was rebased to current master. It also
> handles the access(2) calls introduced in commit 0f2bc0dd by David
> correctly.
> 
> buffer.c             |    3 +- crypto.c             |    6 +- error.c
> |   17 +- manage.c             |    2 +- misc.c               |   41
> ++++- misc.h               |   31 ++++ options.c            |   37
> ++++- packet_id.c          |    6 +- pf.c                 |    2 +- 
> plugin.c             |    3 +- ps.c                 |    2 +- 
> ssl_openssl.c        |  459
> +++++++++++++++++++------------------------------- ssl_verify.c
> |    2 +- ssl_verify_openssl.c |    6 +- status.c             |   48
> ++---- syshead.h            |    1 + win32.c              |   60
> ++++++-- win32.h              |    3 + 18 files changed, 367
> insertions(+), 362 deletions(-)
> 

ACK and applied to master for -stable and -testing trees.

commit 71bbbd76c62630c88441237d72fe5b61f0b45b2a
Author: Heiko Hund <heiko.hund@...1489...>
Date:   Fri Feb 10 15:13:42 2012 +0100

    handle Windows unicode paths

    Signed-off-by: Heiko Hund <heiko.hund@...1489...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk85ZCwACgkQDC186MBRfrqGJQCdHMudYYgOM/ZT9trN4eNimO6i
yeMAoIijsO70hmkaq+OeAWXV7Xn7cv2o
=68zX
-----END PGP SIGNATURE-----

