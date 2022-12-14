Date: Wed, 14 Dec 2022 09:12:52 +0100 (CET)
Message-Id: <202212140812.2BE8Cq0h047533@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221213225430.1892940-3-arne@...1227...>
References: <20221213225430.1892940-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Set DCO_NOT_INSTALLED also for
 keys not in the get_key_scan range
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

I've done a quick read over ssl_common.h to be sure the indexes are
valid, and fed this to a light test run (client-side only, for the
start).  Looks good, passes.

I can see why Antonio grumbles, but then, ensuring stuff is in a really
well-known state if we suspect it might not always be is a valid line
of defense.

Your patch has been applied to the master and release/2.6 branch.

commit 4cf7409e82580f2890c391372d60ed713ba4650c (master)
commit 5c26918f482f21484527f4b065818863c459b226 (release/2.6)
Author: Arne Schwabe
Date:   Tue Dec 13 23:54:30 2022 +0100

     Set DCO_NOT_INSTALLED also for keys not in the get_key_scan range

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20221213225430.1892940-3-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25681.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


