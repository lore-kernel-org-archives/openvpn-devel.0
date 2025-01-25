Date: Sat, 25 Jan 2025 10:57:20 +0100 (CET)
Message-Id: <202501250957.50P9vKZw061362@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250124205135.18765-1-gert@...1296...>
References: <20250124205135.18765-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: mroute: adapt to new protocol
 handling and hashing improvements
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

This is also basically only "adding infrastructure" - the mroute hashing
is used to find a peer based on IP address, and with UDP+TCP sockets
in use at the same time, a collision "same remote IP+Port, different
proto" is possible.

Now, the hashing is not strictly needed for incoming packets on a
TCP connection ("there is only one client on that socket"), but the
currently-existing infrastructure is not using the "socket -> mi"
shortcut, at least not everywhere (e.g. multi.c: multi_close_instance()
which is agnostic on UDP/TCP, and crashed nicely on 765 #v16...).

Thus, we need this ;-)

Stared a lot at this code from v1...v17, Gian/Antonio reworked the
patch quite a bit, and the server side testbed found more issues... but
now we're at a point where the code looks good and all the test instances
are well-behaved.  In it goes.

Your patch has been applied to the master branch.

commit dda93f30411eec3457a48e94ef599e3f034c87e5
Author: Gianmarco De Gregori
Date:   Fri Jan 24 21:51:35 2025 +0100

     mroute: adapt to new protocol handling and hashing improvements

     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250124205135.18765-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30579.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


