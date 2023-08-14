Date: Mon, 14 Aug 2023 11:31:40 +0200 (CEST)
Message-Id: <202308140931.37E9VeB5054077@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230814060409.50742-1-gert@...1296...>
References: <20230814060409.50742-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Make received OCC exit messages
 more visible in log.
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Tested, of course :-) - with a 2.5 client, I now have

2023-08-14 11:26:27 client25 OCC exit message received by peer
2023-08-14 11:26:27 client25 SIGUSR1[soft,remote-exit] received, client-instance restarting

in my server logs.

With a 2.6 client, this becomes:

2023-08-14 11:29:01 client26 CC-EEN exit message received by peer
2023-08-14 11:29:01 client26 Delayed exit in 5 seconds
2023-08-14 11:29:06 client26 SIGTERM[soft,delayed-exit] received, client-instance exiting

(interesting that one does SIGUSR1 and the other does SIGTERM - but for
the multi server side it ends up in the same code path "clean up client
instance, done")

Patch has been applied to the master and release/2.6 branch.

commit 5f910a42b86e90f1893a668ee280422b6587ada1 (master)
commit 6e68d8c5d5304d56de588f4584e2dc6266d2f129 (HEAD -> release/2.6)
Author: Gert Doering
Date:   Mon Aug 14 08:04:09 2023 +0200

     Make received OCC exit messages more visible in log.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20230814060409.50742-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26949.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


