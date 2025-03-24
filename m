Date: Mon, 24 Mar 2025 08:19:49 +0100 (CET)
Message-Id: <202503240719.52O7JneO072415@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250323211359.14117-1-gert@...1296...>
References: <20250323211359.14117-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix incorrect condition for
 checking password related check
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

Yeah, sorry for not noticing when reviewing db48cea.  In retrospective
this is quite obviously the correct fix.

Added Github: reference, and URLs to sf.net mail archive & gerrit - the
archive at mail-archive.org is broken again :-(

Your patch has been applied to the master branch.

commit 15e663c898fe7a2350c35f5263cbad116cd5b61a
Author: Arne Schwabe
Date:   Sun Mar 23 22:13:53 2025 +0100

     Fix incorrect condition for checking password related check

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...2726...>
     Message-Id: <20250323211359.14117-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59164222/
     URL: http://gerrit.openvpn.net/c/openvpn/+/912
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


