Date: Tue, 5 Mar 2024 22:01:58 +0100 (CET)
Message-Id: <202403052101.425L1wZb097933@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240304161556.2036270-1-frank@...2641...>
References: <20240304161556.2036270-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: samples: Remove tls-*.conf
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Indeed, outdated and partially overlapping sample configs help nobody...
(especially doing ifconfig via -up is like the 1990s calling :-) ).

Your patch has been applied to the master and release/2.6 branch.

commit f8a8c7879556d2a5d7231eaa911b1a0ad82730a6 (master)
commit 2f20a03b1dc7c6a0d01f7b9eb5dd5dd435abe6b5 (release/2.6)
Author: Frank Lichtenheld
Date:   Mon Mar 4 17:15:56 2024 +0100

     samples: Remove tls-*.conf

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20240304161556.2036270-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28316.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


