Date: Thu, 12 Mar 2026 17:20:36 +0100 (CET)
Message-Id: <202603121620.62CGKakE047463@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260312153329.4700-1-gert@...1296...>
References: <20260312153329.4700-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add siphash reference
 implementation
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

In itself, this does not actually *do* anything, just adds two files
(and Max has ACKed that "this is right implementation").  A future
commit can then add Makefile handling, compat handling, etc.

Your patch has been applied to the master branch.

commit ea3b48f6758acdd5b9d001139b6237c7f913bb8b
Author: Arne Schwabe
Date:   Thu Mar 12 16:33:23 2026 +0100

     Add siphash reference implementation

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: MaxF <max@...2606...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/29
     Message-Id: <20260312153329.4700-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36072.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


