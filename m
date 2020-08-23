Date: Sun, 23 Aug 2020 21:34:29 +0200 (CEST)
Message-Id: <202008231934.07NJYTgb026839@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200820014258.38377-1-eric@...1918...>
References: <20200820014258.38377-1-eric@...1918...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fixes a bug in
 management_callback_send_cc_message, should be strlen instead of sizeof
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
To: Eric Thorpe <eric@...1918...>
Cc: openvpn-devel@lists.sourceforge.net

I have not tested this, but the change is definitely "obviously correct" :)

Your patch has been applied to the master and release/2.5 branch.

commit 62560e2a29144ffefec231ae7147eb4e9c7dfebf (master)
commit 6e1fccaa47c9376cf862219d98678345408c9a54 (release/2.5)
Author: Eric Thorpe
Date:   Wed Aug 19 18:42:58 2020 -0700

     Fixes a bug in management_callback_send_cc_message, should be strlen instead of sizeof

     Signed-off-by: Eric Thorpe <eric@...1918...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20200820014258.38377-1-eric@...1918...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20783.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


