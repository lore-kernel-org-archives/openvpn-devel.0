Date: Tue, 15 Mar 2022 16:37:32 +0100 (CET)
Message-Id: <202203151537.22FFbWrd003048@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220313193154.9350-2-openvpn@...2080...>
References: <20220313193154.9350-2-openvpn@...2080...>
Subject: [Openvpn-devel] [PATCH applied] Re: sample-plugin: New plugin for
 testing multiple auth plugins
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Diffing the patch against the previous one only circulated on the
seclist shows no differences except "mail headers", and I have reviewed
and tested that plugin for my "multiple deferred auth" (draft) patch.

So, today only tested that it builds on both branches (it does).

If someone wants to spend a bit more time working on this plugin, I
think it could be improved by having the "how much delay?" "direct
or deferred?" and "fail or succeed?" behaviour controlled by 
UV_$prefix_VAR variable settings that can be "--push-peer-info"'ed 
from the client - so fully automated testing of all combinations
without modifying the server config and restarting.  But this is an
enhancement / feature wish, not a showstopper.

Your patch has been applied to the master and release/2.5 branch.

commit 79a111c7e16d157278495cb5f4c52eab2229b68e (master)
commit 08c6d9b016f9e8cf3f917e83bcd96f5a26345989 (release/2.5)
Author: David Sommerseth
Date:   Sun Mar 13 20:31:52 2022 +0100

     sample-plugin: New plugin for testing multiple auth plugins

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20220313193154.9350-2-openvpn@...2080...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23932.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


