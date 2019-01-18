Date: Fri, 18 Jan 2019 20:55:53 +0100 (CET)
Message-Id: <201901181955.x0IJtrHZ003824@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181219202611.2144-3-simon@...2293...>
References: <20181219202611.2144-3-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: Uncrustify tapctl and
 openvpnmsica
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

Acked-by: Gert Doering <gert@...1296...>

Thanks :-) (while I sometimes can't make up my mind whether uncrustify
makes the mode more ugly or less, at least the extra braces { ... } 
really help make the code more explicit in some places - even if it
eats up screen real estate).

Interesting enough, uncrustify doesn't care about "label with;",
and also doesn't wrap long comment lines.  It *does* convert C++ 
comments into C, which is nice :-)

Glanced over the changes and test compiled on Ubuntu 16.04 / mingw.

Your patch has been applied to the master branch.

commit 6280d3d5536174934ee22d3840457d61896e0e3a
Author: Simon Rozman
Date:   Wed Dec 19 21:26:10 2018 +0100

     Uncrustify tapctl and openvpnmsica

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20181219202611.2144-3-simon@...2293...>
     URL: https://www.mail-archive.com/search?l=mid&q=20181219202611.2144-3-simon@...2293...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


