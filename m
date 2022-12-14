Date: Wed, 14 Dec 2022 09:01:48 +0100 (CET)
Message-Id: <202212140801.2BE81mhF043107@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221213225430.1892940-2-arne@...1227...>
References: <20221213225430.1892940-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Trigger a USR1 if
 dco_update_keys fails
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

This looks like a good way to recover out of "we are all confused
about state" situations.  We should never get there, but then, well-
defined recovery is certainly a plus.

So far I've only stared-at-code, and done compile tests, but the
change is sufficiently platform-independent (also taking --disable-dco
into account) that I expect no breakage.

Your patch has been applied to the master and release/2.6 branch.

commit 419051c96e9fb1f3202fd67733aa3b6a4bbc3181 (master)
commit 238ac1785f08e4cde4c095629c94f2b9bcc977fa (release/2.6)
Author: Arne Schwabe
Date:   Tue Dec 13 23:54:29 2022 +0100

     Trigger a USR1 if dco_update_keys fails

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20221213225430.1892940-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25679.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


