Message-ID: <50AE039A.8080205@...1114...>
Date: Thu, 22 Nov 2012 11:51:06 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1353348737-21920-1-git-send-email-arne@...1227...>
In-Reply-To: <1353348737-21920-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Error message if max-routes used
	incorrectly
Reply-To: openvpn-users@lists.sourceforge.net
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

On 19/11/12 19:12, Arne Schwabe wrote:
> the route/route-ipv6/redirect-gateway options allocate the route
> structe with max_routes number of routes. A max-routes after any of
> this commands has no effect. This can be problematic
> (http://code.google.com/p/ics-openvpn/issues/detail?id=101)
> 
> Signed-off-by: Arne Schwabe <arne@...1227...> --- 
> src/openvpn/options.c |    5 +++++ 1 file changed, 5 insertions(+)

Applied to master and beta/2.3 branches.

commit f83ccec6525179968b68696acb6ccf22182fc6de (master)
commit cb8c4efde0d7c26c2e2cd71bc419169ffb14f935 (beta/2.3)
Author: Arne Schwabe <arne@...1227...>
Date:   Mon Nov 19 19:12:17 2012 +0100

    Error message if max-routes used incorrectly

    Signed-off-by: Arne Schwabe <arne@...1227...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: 1353348737-21920-1-git-send-email-arne@...1227...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/7131
    Signed-off-by: David Sommerseth <davids@...1347...>


- -- 
kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlCuA5oACgkQDC186MBRfrqbYgCeJkTKA10X9ifnTg8tDrFxBZig
Ef8An00qW7PQk93CBvAAABkly8g+WyzH
=xGnv
-----END PGP SIGNATURE-----

