Date: Wed, 23 Oct 2024 14:38:41 +0200 (CEST)
Message-Id: <202410231238.49NCcfKF029793@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241023083444.27951-1-gert@...1296...>
References: <20241023083444.27951-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: pass link_socket object to i/o
 functions
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

Tested on the server testbed, which has all the relevant operations here -
UDP/TCP client, UDP/TCP servers, ... - all works fine.

The code change itself touches many places, but is actually quite 
straightforward here - "c->c2.link_socket->..." gets replaced by
"sock->...", with "sock" passed in as "c->c2.link_socket" (as of now).

.. making many of these functions easier to read, which is nice ;-)

(On the renaming of "struct link_socket *ls" to "... *sock" bit, I should
have paid more attention earlier in the review process - this is basically
an fairly large and unrelated change which makes the code different
to 2.6, for no really good reason - maybe keeping the original patch
with "struct link_socket *ls" everywhere else would have been nicer, as
it's more than "just a socket" anyway)

Your patch has been applied to the master branch.

commit 490d1324c87446b48462da18cfde1b755c9883e8
Author: Antonio Quartulli
Date:   Wed Oct 23 10:34:44 2024 +0200

     pass link_socket object to i/o functions

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20241023083444.27951-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29603.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


