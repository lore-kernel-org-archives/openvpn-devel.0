Date: Mon, 20 Mar 2023 18:22:08 +0100 (CET)
Message-Id: <202303201722.32KHM8mq067126@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230301134455.2810114-1-arne@...1227...>
References: <20230301134455.2810114-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Only update frame calculation
 if we have a valid link sockets
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

Acked-by: Gert Doering <gert@...1296...>

This is not really "high priority critical NULL pointer crash bug"
important, because due to lucky circumstances the result from
get_link_socket_info(c) on a NULL pointer is still NULL (because
&->info is the first member of the struct) - so later consumers
of *lsi will not crash ("if (lsi && lsi->...)").

It's still undefined behaviour, so let's not rely on this, and
instead only update frame parameters *here* in the modes that have
a link_sock available.  Notable exception is "UDP child", but in this
case there is another call chain from multi_connection_established()
-> tls_session_update_crypto_params_do_work() -> frame_calculate_dynamic()
which will do the updating later.  (Discussed at lenght with Arne on IRC):

I still find the whole session setup thing confusing (like, why is
the TCP link_socket initialized before init_instance(), and UDP child
only afterwards, leading to this situation in the first place?) - but
this is not "bugfix, 2.6" land, more "refactor for 2.7".


I have lightly tested this with GHA and the server test framework
- which does not really *verify* all these frame / overhead, just
"clients can still connect just fine, nothing crashes/fails".

Your patch has been applied to the master and release/2.6 branch.

commit 2d17869f8d9d8e27f64f1a7cd1514fbbb768807b (master)
commit 75cc2fa6e15ce806415aed33d7608b8d9cc00e36 (release/2.6)
Author: Arne Schwabe
Date:   Wed Mar 1 14:44:55 2023 +0100

     Only update frame calculation if we have a valid link sockets

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230301134455.2810114-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26318.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


