Date: Tue, 21 Mar 2023 16:15:43 +0100 (CET)
Message-Id: <202303211515.32LFFhqx092683@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230321102842.10780-1-a@...2181...>
References: <20230321102842.10780-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: multi: don't call DCO APIs if
 DCO is disabled
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

I have not tested this extensively (as in "instrument the functions
not called anymore if --disable-dco is in use"), just ran some basic
tests on FreeBSD 14 with DCO, and "counters with DCO" still work,
as does --inactive (with a "this many bytes" specification).

Your patch has been applied to the master and release/2.6 branch.

commit 891c71db5e26291b19885b9a5ae5c72011b86658 (master)
commit 8f503708ed954ff3ae43357bd9f59809581a1381 (release/2.6)
Author: Antonio Quartulli
Date:   Tue Mar 21 11:28:42 2023 +0100

     multi: don't call DCO APIs if DCO is disabled

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20230321102842.10780-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26458.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


