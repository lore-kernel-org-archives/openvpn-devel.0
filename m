Date: Fri, 10 Oct 2025 16:42:41 +0200 (CEST)
Message-Id: <202510101442.59AEgf0n088184@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251009182855.18712-1-gert@...1296...>
References: <20251009182855.18712-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: PUSH_UPDATE server: check
 IV_PROTO before sending the message to the client
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
To: Marco Baffo <marco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Tested on a system with 3 clients, 2 of them capable, 1 incapable of
receiving PUSH_UPDATE messages.  Both "push-update-broad" and
"push-update-cid" now (with 1264) do what it says - "send to all who
can receive" or "send, if possible, error message otherwise".

Your patch has been applied to the master branch.

commit 855094893e8cd808ddc74d2e6d392cf04bd06a65
Author: Marco Baffo
Date:   Thu Oct 9 20:28:49 2025 +0200

     PUSH_UPDATE server: check IV_PROTO before sending the message to the client

     Signed-off-by: Marco Baffo <marco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1255
     Message-Id: <20251009182855.18712-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59244566/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


