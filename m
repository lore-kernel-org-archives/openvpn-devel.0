Date: Tue, 29 Jul 2025 16:53:10 +0200 (CEST)
Message-Id: <202507291453.56TErAsR003916@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250729104110.27704-1-gert@...1296...>
References: <20250729104110.27704-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: PUSH_UPDATE: Added
 update_option() function.
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
To: Marco Baffo <marco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

.. and the last one in the series, with similar text leading to it...
(so just look at 808+809).

Tested on the t_client/t_server framework, which exercises many of those
options where the handling even in the "normal path" is now changed (due
to moving the syntax check into smaller helper functions).

I'm still not convinced that we really need to do all these syntax checks
for "remove an option", but that message was not really heard... also, I'm
not really sure the current behaviour is that useful outside fairly limited
OpenVPN Corp scenarios ("why would a PUSH_UPDATE route statement remove
all routes I have in my config file, not only those sent by PUSH_REPLY?"),
but we all agreed that this is the beginning of a journey, also expecting
incremental improvements ("not reopen the tun device if there is no reason
for it", for example, because the server just pushes extra routes).

Your patch has been applied to the master branch.

commit dd9c6978ec851213deece9229e413d44d0289cad
Author: Marco Baffo
Date:   Tue Jul 29 12:41:01 2025 +0200

     PUSH_UPDATE: Added update_option() function.

     Signed-off-by: Marco Baffo <marco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250729104110.27704-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32408.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


