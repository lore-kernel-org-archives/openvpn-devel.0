Date: Sun, 14 Sep 2025 14:07:42 +0200 (CEST)
Message-Id: <202509141207.58EC7gcA086051@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250912131056.42342-1-frank@...2641...>
References: <20250912131056.42342-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix multi-socket and dco-win
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

So, we discussed the background of this on IRC for quite a bit - with
the multisocket patch, there is a disconnect between ce->proto
("reflects the global 'proto' setting in the config") and the
ce->local_list->array[*]->proto values ("one for each 'local' statement").

For servers, it depends a bit on how the server config is set up, but
if you do

  --proto udp (default)
  --local * 443 tcp

the "tcp" part will not be visible in ce->proto.

If there is *no* "local" statement (just lport + bind), the code will
synthesize local_list->array[0] from the config settings provided - so
whatever happens, for a server config, array[0]->proto contains the
protocol for the first listening socket requested.

Lev has actually tested this, while I've discussed it at length to
understand the subtle differences - written up for the benefit of
the archives.


Again, mail-archive.org refuses to acknowledge that this mail was ever
sent, so referencing sf.net + gerrit.

Your patch has been applied to the master branch.

commit 864bb498ef7a15eb256cbe6013350e76ae96c32b
Author: Gianmarco De Gregori
Date:   Fri Sep 12 15:10:56 2025 +0200

     Fix multi-socket and dco-win interaction

     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20250912131056.42342-1-frank@...2641...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59232442/
     URL: https://gerrit.openvpn.net/c/openvpn/+/1173
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


