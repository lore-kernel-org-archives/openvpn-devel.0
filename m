Date: Sat, 9 Jun 2018 20:37:36 +0200 (CEST)
Message-Id: <201806091837.w59Ibaul018971@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20180419112313.1013-1-simon@...2293...>
References: <20180419112313.1013-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add Interactive Service
 developer documentation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.4 branch.

As suggested by Selva, I've added the new document to dist_noinst_DATA
in doc/Makefile.am - this will pack it into the tarball, but will not
"make install" it into $docdir (because *that* is really "what happens
on unix" where you do not need this for "installed packages").

commit 62b1cc161c53d900b6fe56f6924ef2ec1c1b8a00 (master)
commit 9e1800da5782be2b23202997d40ea37a1dfcd4e9 (release/2.4)
Author: Simon Rozman
Date:   Thu Apr 19 13:23:13 2018 +0200

     Add Interactive Service developer documentation

     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20180419112313.1013-1-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16794.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


