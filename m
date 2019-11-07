Date: Thu, 7 Nov 2019 23:02:41 +0100 (CET)
Message-Id: <201911072202.xA7M2fDD036665@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191009143422.9419-6-a@...2181...>
References: <20191009143422.9419-6-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: is_ipv_X: add support for
 parsing IP header inside a 802.1q frame
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Stared at code, and ran the full t_client/t_server test suite, but
mostly for completeness.  Since we do not have tagged packets yet
(with the appropriate ether type), this code does not change anything.

Again, only TAP code paths are touched.

Your patch has been applied to the master branch.

commit def3f32d216d16c3bf5a203a2162256203686a34
Author: Antonio Quartulli
Date:   Wed Oct 9 16:34:18 2019 +0200

     is_ipv_X: add support for parsing IP header inside a 802.1q frame

     Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20191009143422.9419-6-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18916.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


