Date: Tue, 2 Sep 2025 19:07:07 +0200 (CEST)
Message-Id: <202509021707.582H77bQ071864@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250902163514.22339-1-gert@...1296...>
References: <20250902163514.22339-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: management: stop bytecount on
 client disconnection
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
To: Ralf Lici <ralf@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

"Does what it says on the lid".

Tested on Linux+DCO client - without the patch, with "bytecount 1",
after management client disconnect the log would happily show 
more "dco_get_peer()" calls, one per second.  With the patch, these
properly stop (as with "bytecount 0", so that one also still works).

Your patch has been applied to the master branch.

commit fccdb21733d2826bcdc080fdfa93b0283b5231b8
Author: Ralf Lici
Date:   Tue Sep 2 18:35:09 2025 +0200

     management: stop bytecount on client disconnection

     Signed-off-by: Ralf Lici <ralf@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250902163514.22339-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32765.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


