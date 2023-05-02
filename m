Date: Tue, 2 May 2023 16:27:10 +0200 (CEST)
Message-Id: <202305021427.342ERAXb069743@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230430172202.206528-1-arne@...1227...>
References: <20230430172202.206528-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove unused variable line
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

Acked-by: Gert Doering <gert@...1296...>

Trivial enough.  Looks like a leftover from The Great Pool Rewrite for 2.5

Test compiled on Linux.

Your patch has been applied to the master and release/2.6 branch.

commit f9d0994584cd8f42c013db3e8ea2d6ab3e3d7c62 (master)
commit 6f72df316daed5e8f7a1b4b432265e01954dbac3 (release/2.6)
Author: Arne Schwabe
Date:   Sun Apr 30 19:22:02 2023 +0200

     Remove unused variable line

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230430172202.206528-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26612.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


