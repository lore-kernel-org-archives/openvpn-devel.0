Message-ID: <4FA23577.6090406@...1114...>
Date: Thu, 03 May 2012 09:36:23 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1335637741-15721-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1335637741-15721-1-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] build: windows: convert resources to
 UTF-8
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

On 28/04/12 20:29, Alon Bar-Lev wrote:
> Visual Studio 2010 editor supports UTF-8 files, we can store files
> in standard encoding.
> 
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> --- 
> src/openvpn/openvpn_win32_resources.rc   |    4 +++- 
> src/openvpnserv/openvpnserv_resources.rc |    4 +++- 2 files
> changed, 6 insertions(+), 2 deletions(-)
> 

ACK, based on discussion.  Applied to master branches on -testing and
- -stable trees.

commit a0e8911bf3ce72178e72784f744556bef20727b3
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Sat Apr 28 21:29:01 2012 +0300

    build: windows: convert resources to UTF-8

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1335637741-15721-1-git-send-email-alon.barlev@...277...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6380
    Signed-off-by: David Sommerseth <davids@...1347...>



kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+iNXcACgkQDC186MBRfrreGQCgpWfny+sCr9B/9wHc7wb+qB+w
UvUAn1XCQx+hN6S5q1EGmpDV7uTZ22Ed
=aq4f
-----END PGP SIGNATURE-----

