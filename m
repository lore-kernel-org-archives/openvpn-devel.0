Message-ID: <50169195.5050302@...1114...>
Date: Mon, 30 Jul 2012 15:52:21 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1343639122-8658-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1343639122-8658-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH] fix regression with --http-proxy[-*]
 options
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

On 30/07/12 11:05, Heiko Hund wrote:
> Commit af1bf85a introducing the --management-query-proxy option 
> broke the initialization of HTTP proxy options by not assigning the
> allocated object to the options element in the function 
> init_http_proxy_options_once().
> 
> Signed-off-by: Heiko Hund <heiko.hund@...1489...> --- 
> src/openvpn/init.c    |    3 +-- src/openvpn/options.c |    8
> ++++---- src/openvpn/proxy.c   |   12 ++++++------ 
> src/openvpn/proxy.h   |    2 +- 4 files changed, 12 insertions(+),
> 13 deletions(-)
> 

Applied to master.

commit 4f879daeb9b1b709c80d01e4872b30e23747c4a8
Author: Heiko Hund <heiko.hund@...1489...>
Date:   Mon Jul 30 11:05:22 2012 +0200

    fix regression with --http-proxy[-*] options

    Signed-off-by: Heiko Hund <heiko.hund@...1489...>
    Acked-by: Arne Schwabe <arne@...1227...>
    Message-Id: 1343639122-8658-1-git-send-email-heiko.hund@...1489...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6913
    Signed-off-by: David Sommerseth <dazo@...384...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAWkZMACgkQDC186MBRfroVPQCfUbhvHxx9O+TqdCJ7suLK5c5f
3ZgAnjlNdrw9oxJPN5AtEoBTcUtC+ZCD
=rKlw
-----END PGP SIGNATURE-----

