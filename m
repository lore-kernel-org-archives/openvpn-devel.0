Date: Fri, 4 Apr 2025 13:07:20 +0200 (CEST)
Message-Id: <202504041107.534B7KPG054244@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250402153250.4764-1-gert@...1296...>
References: <20250402153250.4764-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: GHA: Pin version of CMake for
 MinGW build
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Fairly straightforward backport of the master commit da65c4fd (master
has Android build, so that commit is longer).  Tested via GHA push that
built fine.

Your patch has been applied to the release/2.6 branch.

commit ca61164a10580baca96b2be8c53883023151aca5
Author: Frank Lichtenheld
Date:   Wed Apr 2 17:32:44 2025 +0200

     GHA: Pin version of CMake for MinGW build

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250401170420.29808-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31299.html
     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250402153250.4764-1-gert@...1296...>
     URL: https://www.mail-archive.com/search?l=mid&q=20250402153250.4764-1-gert@...1296...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


