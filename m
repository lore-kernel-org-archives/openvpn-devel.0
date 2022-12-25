Date: Sun, 25 Dec 2022 16:35:23 +0100 (CET)
Message-Id: <202212251535.2BPFZNFT051080@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221224194253.3202231-7-arne@...1227...>
References: <20221224194253.3202231-7-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Do not set nl socket buffer size
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

"Trivial enough", removing code that we're not sure why we have it
in the first place.  Tested on Linux/DCO, client and server, and 
all is well behaved (for normal operations, did not test gremlins -
but my gremlins never hit sitnl queue limits either).

Your patch has been applied to the master and release/2.6 branch.

commit b2ca179ce2678115c3a61fd3f843c64c1d059fbc (master)
commit fa2a330f72d29a5ce630327ca288ed520aa2d697 (release/2.6)
Author: Arne Schwabe
Date:   Sat Dec 24 20:42:50 2022 +0100

     Do not set nl socket buffer size

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221224194253.3202231-7-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25789.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


