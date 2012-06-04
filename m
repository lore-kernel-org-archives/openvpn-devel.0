Message-ID: <4FCC9C7B.4040100@...1114...>
Date: Mon, 04 Jun 2012 13:31:07 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz0aMBvtfzHRU1RUKWtAwKirGJ-U5__yf4uQO4s0XM2FYQ@...278...>
	<1338651109-15806-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1338651109-15806-1-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] build: support platforms that does not
 need explicit tun headers
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

On 02/06/12 17:31, Alon Bar-Lev wrote:
> Both "generic" and Darwin have no special headers to use tap.
> 
> Fixes commit 7cacdfd4b7.
> 
> Reported-by: Arne Schwabe <arne@...1227...> Signed-off-by: Alon
> Bar-Lev <alon.barlev@...277...> --- configure.ac |    2 ++ 1 files
> changed, 2 insertions(+), 0 deletions(-)

ACK.  Applied to master branch.


commit 05f16e84314d83d81aa341ad2c6ea706603befd6
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Sat Jun 2 18:31:49 2012 +0300

    build: support platforms that does not need explicit tun headers

    Reported-by: Arne Schwabe <arne@...1227...>
    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1338651109-15806-1-git-send-email-alon.barlev@...277...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6659
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/MnHsACgkQDC186MBRfrp4ewCfUQkyPawHIAuOuKPLmJ0TGvPU
D/EAnRsKHThzGVmkSYvVfxFQ1FpQTjhB
=/UN6
-----END PGP SIGNATURE-----

