Message-ID: <4FC8C08A.2060707@...1114...>
Date: Fri, 01 Jun 2012 15:15:54 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4FAE87C1.6000509@...277...>
In-Reply-To: <4FAE87C1.6000509@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Properly detect OpenSSL version strings
 with numbers only
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
To: Simon Deziel <simon.deziel@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/05/12 17:54, Simon Deziel wrote:
> whichopensslcnf failed to return the right cnf for:
> 
> $ openssl version OpenSSL 1.0.1 14 Mar 2012
> 
> Signed-off-by: Simon Deziel <simon.deziel@...277...> --- 
> easy-rsa/2.0/whichopensslcnf |    6 +++--- 1 files changed, 3
> insertions(+), 3 deletions(-)
> 

Thank you very much for your contribution.  Your patch has been
applied to the brand new easy-rsa.git repository.


commit a812fed7fbc39d4936c348d4a1a9c0e07e6d65f6
Author: Simon Deziel <simon.deziel@...277...>
Date:   Sat May 12 11:54:41 2012 -0400

    Properly detect OpenSSL version strings with numbers only

    Signed-off-by: Simon Deziel <simon.deziel@...277...>
    Acked-by: Alon Bar-Lev <alon.barlev@...277...>
    Message-Id: 4FAE87C1.6000509@...277...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6534
    Signed-off-by: David Sommerseth <davids@...1347...>



kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/IwIkACgkQDC186MBRfrqHQQCeP5K4OkTAuGaZb6L9z5IMVVAT
p3MAoKT2EHHsidSbY2sAMH8ZfeN/Qp+u
=8HSr
-----END PGP SIGNATURE-----

