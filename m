Date: Fri, 31 Jan 2025 16:56:54 +0100 (CET)
Message-Id: <202501311556.50VFusau055536@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250131154135.32169-1-gert@...1296...>
References: <20250131154135.32169-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: route.c: improve
 get_default_gateway() logic on Windows
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Tested a local windows build with this with various nasty questions
("--show-gateway 127.0.0.1", ON_LINK and not, etc) and v5 now gets us
the expected results for all my and Lev's tests.  Plus, the code is much
more efficient on a system with many routes than "get all the tables
from Windows, and walk through them ourselves" - just ask Windows.

The patch looks a bit larger because it reuses the IPv6 logic, extracting
the common parts into get_best_route().

Your patch has been applied to the master branch.

commit 1f6b6b5b589bfb519b09b1b4e99086d64a2c8fc4
Author: Lev Stipakov
Date:   Fri Jan 31 16:41:35 2025 +0100

     route.c: improve get_default_gateway() logic on Windows

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250131154135.32169-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30769.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


