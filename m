Date: Tue, 15 Mar 2022 16:48:36 +0100 (CET)
Message-Id: <202203151548.22FFmaIb003250@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220313193154.9350-4-openvpn@...2080...>
References: <20220313193154.9350-4-openvpn@...2080...>
Subject: [Openvpn-devel] [PATCH applied] Re: plugins: Remove defer/simple.c
 sample plugin
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

This one does not need much brains to review - "does it apply" and
"does it break 'make distcheck'" (yes, and no).

The reason why this plugin is deleted is because the new multi-auth
plugin does mostly the same thing, "but more" - and it's 90% the same
code, so not much to be learned from the older one anymore.

For 2.5 and 2.4 branches, after some discussion on IRC, it makes sense
to leave defer/simple alone - it still has "PF" support, which 
defer/auth-multi does not have (and does not need).  So, unlike 
master, there is something to be learned from having both plugins,
and someone might even make use of the "simple" feature set...

Your patch has been applied to the master branch.

commit d816207bc2fe1ee5a04c394b215d50123cb25aad (master)
Author: David Sommerseth
Date:   Sun Mar 13 20:31:54 2022 +0100

     plugins: Remove defer/simple.c sample plugin

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20220313193154.9350-4-openvpn@...2080...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23933.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


