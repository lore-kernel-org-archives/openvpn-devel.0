Date: Thu, 1 Apr 2021 15:36:35 +0200 (CEST)
Message-Id: <202104011336.131DaZlS084546@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210401131337.3684-4-arne@...1227...>
References: <20210401131337.3684-4-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Rename
 tunnel_server_udp_single_threaded to tunnel_server_udp
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

"Because it makes sense".  There's no threads here, and with DCO and
all the asyncness, there might never be... so, admit that fact :-)

Lightly client-side tested on linux.

Your patch has been applied to the master branch.

commit bdc11ae462d61f0cdee5f539c7f028f58513a914
Author: Arne Schwabe
Date:   Thu Apr 1 15:13:26 2021 +0200

     Rename tunnel_server_udp_single_threaded to tunnel_server_udp

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210401131337.3684-4-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21955.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


