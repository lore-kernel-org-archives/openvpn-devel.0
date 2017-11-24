Date: Fri, 24 Nov 2017 15:28:07 +0100 (CET)
Message-Id: <201711241428.vAOES7Wa039800@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1511531903-19349-1-git-send-email-steffan.karger@...1435...>
References: <1511531903-19349-1-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use P_DATA_V2 for
 server->client packets too
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  Patch looks good and passes t_server tests (2.2, 2.3, 2.4 clients).

(Also registering Antonios ACK, as the v2 code was technically working,
and this is just getting it fully right)

Since the patch is fairly trivial I've let myself be convinced that it's
a long-term support thing to have this in 2.4 (namely: get rid of P_DATA_V1
as soon as everyone has migrated to 2.4, not having to wait until after
2.5).

Your patch has been applied to the master and release/2.4 branch.

commit 3b9cce657b0ba876c56ee6f14664a8a77f5b82d5 (master)
commit 6232c7b3827f90d9b25135c523703204bc2095c0 (release/2.4)
Author: Steffan Karger
Date:   Fri Nov 24 14:58:23 2017 +0100

     Use P_DATA_V2 for server->client packets too

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1511531903-19349-1-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/search?l=mid&q=1511531903-19349-1-git-send-email-steffan.karger@...1435...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


