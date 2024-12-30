Date: Mon, 30 Dec 2024 18:31:51 +0100 (CET)
Message-Id: <202412301731.4BUHVpkw065944@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241230162338.21401-1-gert@...1296...>
References: <20241230162338.21401-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Adapt socket handling to
 support listening on multiple sockets
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

Detailed discussion, review, etc. is all on gerrit (and linked in this
thread).  So not repeating all the details.

Stared at the code and the incremental patches long and hard, and gave
it a thorough test on the client/server testbed (which broke on v10),
but now it succeeds.

Your patch has been applied to the master branch.

commit 94b391d7ef5cb4cdac34a0d122fb9cbd11d82f75
Author: Antonio Quartulli
Date:   Mon Dec 30 17:23:37 2024 +0100

     Adapt socket handling to support listening on multiple sockets

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20241230162338.21401-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30309.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


