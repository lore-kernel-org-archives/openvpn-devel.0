Date: Sat, 25 Apr 2026 22:30:46 +0200 (CEST)
Message-Id: <202604252030.63PKUkiF027033@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260424161840.5767-1-gert@...1296...>
References: <20260424161840.5767-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fixup: prompting password from
 management
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

I have verified the original problem in GH #1021 (as soon as
--management-query-passwords is active, username+password passed in via
file or inline is ignored and the mgmt interface is queried instead
- which can actually be tested from t_client.rc, so I have proper
regression tests for this now).

I have *also* tested (this time) that with the patch, all the "credentials
on file" functionality still works, and also that querying from the
management interface *also* still works.  We should really stop breaking
these...

Your patch has been applied to the master and release/2.7 branch.

commit 9ac9a41b82aecdb5cb17a3746a7fa50878ec7ee0 (master)
commit 8d512db3fcfceed73cd302f27c2c7849764c33f6 (release/2.7)
Author: Selva Nair
Date:   Fri Apr 24 18:18:33 2026 +0200

     Fixup: prompting password from management

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1638
     Message-Id: <20260424161840.5767-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36739.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


