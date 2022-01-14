Date: Fri, 14 Jan 2022 08:02:21 +0100 (CET)
Message-Id: <202201140702.20E72LNA021755@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220113101434.30223-1-a@...2181...>
References: <20220113101434.30223-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: sig.c: define signal_handler on
 non-windows only
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

"makes sense".  Have not tested this.

(The result is still not pretty... maybe a better approach would be
to have all the "not win32" signal stuff in a single #ifdef, and
add empty do-nothing pre_init_signal_catch() etc. functions for WIN32
- but that's another patch for another day)

Your patch has been applied to the master branch.

commit 508ee74a9671d0175afeeb1711ba0f18d538cfb2
Author: Antonio Quartulli
Date:   Thu Jan 13 11:14:34 2022 +0100

     sig.c: define signal_handler on non-windows only

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220113101434.30223-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23530.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


