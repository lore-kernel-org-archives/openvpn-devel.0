Date: Fri, 31 Jan 2025 10:40:10 +0100 (CET)
Message-Id: <202501310940.50V9eANI044344@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250131084707.24905-1-gert@...1296...>
References: <20250131084707.24905-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: get_default_gateway():
 implement platform support for Linux/IPROUTE2
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Tested on a gentoo system with "configure --enable-iproute2" and then
asking the usual "--show-gateway ..." questions.

The actual code change is quite trivial - throw out old code, rely on
the (by now) really well-tested and proven sitnl code.

Your patch has been applied to the master branch.

commit d83afe0e0c878164886d83f3ffddbc63680a6310
Author: Gert Doering
Date:   Fri Jan 31 09:47:07 2025 +0100

     get_default_gateway(): implement platform support for Linux/IPROUTE2

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20250131084707.24905-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30748.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


