Date: Mon, 14 Apr 2025 20:04:41 +0200 (CEST)
Message-Id: <202504141804.53EI4fGY014810@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250410215037.11878-1-gert@...1296...>
References: <20250410215037.11878-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix dco_win and multisocket
 interaction
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
To: Gianmarco De Gregori <gianmarco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Stared at the code for a bit, and fed this to the Linux DCO server
testbed (excercising multisocket only lightly).

Some of the changes are really straightforward (like not calling
socket_set_listen_persistent() for dco_win, where the socket lives
in kernel space), or just not calling (windows-only) wait_signal()
for servers where win-DCO needs different handling.

The change to multi_tcp_process_outgoing_link() feels wrong, though
- yes, "what we do there" should obviously not been done for a DGRAM
packet, but why is the function then called in the first place?  So
I guess there are a few more acts coming in this multisocket/event
drama...

Anyway, this does not really affect Linux/FreeBSD DCO, and testing
says it's not breaking anything - and it fixes Win/Server DCO, so
one step forward at a time.

Your patch has been applied to the master branch.

commit 831c585e96587e28d1390d165d89b4152ba03bd3
Author: Gianmarco De Gregori
Date:   Thu Apr 10 23:50:29 2025 +0200

     Fix dco_win and multisocket interaction

     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20250410215037.11878-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31419.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


