Date: Tue, 13 Jan 2026 08:23:08 +0100 (CET)
Message-Id: <202601130723.60D7N8Na091158@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260112180304.8742-1-gert@...1296...>
References: <20260112180304.8742-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: socks: Fix wrong success check
 in socks_username_password_auth
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

"Ooops".  Change makes sense.

Basically auth success is "(buf[0] == 5 && buf[1] == 0)", so auth fail
needs to properly negate that...  and this patch does.

Not tested beyond BB socks proxy t_client uses - which do not excercise
the "auth fail" case, and the "auth succeed" case still works.

Your patch has been applied to the master branch.

commit d104917e34be43890a86c532329780037e419085
Author: Frank Lichtenheld
Date:   Mon Jan 12 19:02:56 2026 +0100

     socks: Fix wrong success check in socks_username_password_auth

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1466
     Message-Id: <20260112180304.8742-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35219.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


