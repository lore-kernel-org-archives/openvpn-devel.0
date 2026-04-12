Date: Sun, 12 Apr 2026 16:43:52 +0200 (CEST)
Message-Id: <202604121443.63CEhq7b077356@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260412125356.32261-1-gert@...1296...>
References: <20260412125356.32261-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Optimise iterating over all
 clients by remembering highest peer id
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

Stared at code, all makes sense :-) - plus ACK from Frank, plus successful
passing of the t_server tests...

Technically, there is one wart, though:

+    uint32_t max_peerid;               /**< highest currently allocated peer-id
+                                        * and maximum allocated/valid index in
+                                        * instances */

we start with "0", and that is not technically correct for "no peers
are allocated, no valid index in the table".  In practice, this does
not really matter - since the array can have holes, every walk always
verifies that the elements are valid, so the "there is nothing here"
situation leads to a single look at m->instances[0], which is not 
active, so nothing happens.  It's consistent, though, as the decreasing
algorithm also stops at max_peerid == 0 (no underruns).

Your patch has been applied to the master branch.

commit ab3ba0cab7c38699c38898457f403b9b9a40eb3f
Author: Arne Schwabe
Date:   Sun Apr 12 14:53:50 2026 +0200

     Optimise iterating over all clients by remembering highest peer id

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1557
     Message-Id: <20260412125356.32261-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36577.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


