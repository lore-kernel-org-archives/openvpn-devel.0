Date: Thu, 17 Jun 2021 10:22:30 +0200 (CEST)
Message-Id: <202106170822.15H8MUcX000184@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210602194739.29488-1-selva.nair@...277...>
References: <20210602194739.29488-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Apply the connect-retry backoff
 to only one side of a connection
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks.  Change makes sense.  Code looks good.  

Lightly tested on TCP/--client, UDP/--client, TCP/--tls-client, 
UDP/--tls-client (same behaviour as without the patch).

Plus t_client test rig.

Tested on p2p "server" according to #1384 (--ping-restart, --secret, 
--proto udp, no --remote) - could reproduce #1384 without the patch, 
server does not go into backoff with the patch.  Consequently, this 
will also affect a "p2p --secret client", as the only difference is 
"is there a remote?" (but for such setups, this is likely the right
thing to do - to avoid restart loops, just do not use --ping-restart
in p2p mode, use --ping alone to keep NAT sessions open)


Your patch has been applied to the master, release/2.5 and release/2.4
branch (bugfix).  Not sure we'll ever do another 2.4 release, but if
we do, it's in :-)

commit 063d55afeea723fc6df0af29a19df257a8ab6920 (master)
commit d8dee82f1129ac6d3e4bcdc867726f5d64798dc7 (release/2.5)
commit 7029cece844d9324aff687981b8b6c33b099db2d (release/2.4)
Author: Selva Nair
Date:   Wed Jun 2 15:47:39 2021 -0400

     Apply the connect-retry backoff to only one side of a connection

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210602194739.29488-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22485.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


