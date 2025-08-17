Date: Sun, 17 Aug 2025 16:43:47 +0200 (CEST)
Message-Id: <202508171443.57HEhlsX077225@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250817143922.17988-1-gert@...1296...>
References: <20250817143922.17988-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Collect trivial conversion fixes
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

The first three are really outright trivial.  The fourth I felt a bit
unsure about, so tested various combinations of --ifconfig-pool <start>
and it's indeed correct.

Your patch has been applied to the master branch.

commit acc8f82fca61ea5478ab0bd16c16fff5c07ec9af
Author: Frank Lichtenheld
Date:   Sun Aug 17 16:39:15 2025 +0200

     Collect trivial conversion fixes

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250817143922.17988-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32611.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


