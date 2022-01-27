Date: Thu, 27 Jan 2022 18:13:36 +0100 (CET)
Message-Id: <202201271713.20RHDaQR089979@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220101162532.2251835-2-arne@...1227...>
References: <20220101162532.2251835-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Deprecate link-mtu
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

The change is mostly documentation, and it makes sense, for the reasons
given.  The actual code change just reduces the connection between
--ifconfig and --link-mtu, which is confusing at best.

Have not tested beyond a simple compile check.

(For reference: this was 02/21 in v2 of the patchset, and did not see 
an ACK there)

Your patch has been applied to the master branch.

commit 29453c37c1f3aa420a894996dd7be4a4f8393c5a
Author: Arne Schwabe
Date:   Sat Jan 1 17:25:19 2022 +0100

     Deprecate link-mtu

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220101162532.2251835-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23496.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


