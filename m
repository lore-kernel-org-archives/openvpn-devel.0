Date: Sat, 21 Jun 2025 14:30:23 +0200 (CEST)
Message-Id: <202506211230.55LCUNVL038618@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250621121301.27509-1-gert@...1296...>
References: <20250621121301.27509-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dns: add updown script for macOS
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

I have not tested this myself, just stared a bit at the code if
there are surprises lurking ("unquoted eval" and such).

Arne has tested "all DNS via VPN" (was broken in v2) and "split DNS"
and both work.  So here we go, more test reports welcome.

Your patch has been applied to the master branch.

commit a4db3c6e22fd48b83cc38a644762e33e0894b69b
Author: Heiko Hund
Date:   Sat Jun 21 14:12:54 2025 +0200

     dns: add updown script for macOS

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20250621121301.27509-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31942.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


