Date: Thu, 19 Feb 2026 17:14:52 +0100 (CET)
Message-Id: <202602191614.61JGEqwp036531@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260216212805.7808-1-gert@...1296...>
References: <20260216212805.7808-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix various loop index types to
 avoid sign-compare issues
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

Changes make sense... BB confirms everything still works, in it goes.

Arguably, we could have changed dhcp->dns*_len and rgi.n_addrs to size_t
instead, but in the end it does not matter much.

(This only goes to master - it's code cleanup, and unless we find actual
bugs in that process, no reason to backport these to 2.7)

Your patch has been applied to the master branch.

commit 25af0b222facf1169f1d27e29cb2ac0de0279286
Author: Frank Lichtenheld
Date:   Mon Feb 16 22:27:56 2026 +0100

     Fix various loop index types to avoid sign-compare issues

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1491
     Message-Id: <20260216212805.7808-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35682.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


