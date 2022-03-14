Date: Mon, 14 Mar 2022 20:06:06 +0100 (CET)
Message-Id: <202203141906.22EJ66YD084164@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220314162048.22955-1-a@...2181...>
References: <20220314162048.22955-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: remove unused sitnl.h file
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

Lev beat me to ACKing it :-) (I'm fairly sure I did notice sitnl.h and 
remark on this before, during the sitnl review, but it still slipped
through... sneaky AI!).

Did a "make distcheck" for good measure.  Disappearing files tend to
upset packaging - but it seems this was just there, not referenced from
anything, ever...

Your patch has been applied to the master and release/2.5 branch.

commit c697febbc2f445981a6042bb8deb9ed49beb5b73 (master)
commit 69138960d391565994200b24f36215cf3f143fd7 (release/2.5)
Author: Antonio Quartulli
Date:   Mon Mar 14 17:20:48 2022 +0100

     remove unused sitnl.h file

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20220314162048.22955-1-a@...2181...>
     URL: https://www.mail-archive.com/search?l=mid&q=20220314162048.22955-1-a@...2181...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


