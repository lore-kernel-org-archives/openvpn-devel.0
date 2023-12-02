Date: Sat, 2 Dec 2023 16:58:58 +0100 (CET)
Message-Id: <202312021558.3B2FwwMD085269@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231121170603.886801-1-arne@...1227...>
References: <20231121170603.886801-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add missing check for
 nl_socket_alloc failure
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

Took us long enough for such a simple fix... :-)

I have no easy way to trigger this, so only compile tested.

Your patch has been applied to the master and release/2.6 branch.

commit d1c31e428120bb0fc9488c62c1691c92a37d94c3 (master)
commit aa19a6a90f7ef24df12eed205663f3cfbb7d8174 (release/2.6)
Author: Arne Schwabe
Date:   Tue Nov 21 18:06:03 2023 +0100

     Add missing check for nl_socket_alloc failure

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20231121170603.886801-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27541.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


