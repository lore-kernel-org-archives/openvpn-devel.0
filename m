Date: Wed, 27 Aug 2025 21:00:04 +0200 (CEST)
Message-Id: <202508271900.57RJ04wg015052@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250826183902.21252-1-gert@...1296...>
References: <20250826183902.21252-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: route: Make sure various route
 flags are treated as unsigned
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

One more that is fairly straightforward :-) - with small values, well
below any interesting sign extensions.  BB says everthing still works!

Your patch has been applied to the master branch.

commit 3671c420f60004d694ce4970cf333db79a4aed29
Author: Frank Lichtenheld
Date:   Tue Aug 26 20:38:41 2025 +0200

     route: Make sure various route flags are treated as unsigned

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20250826183902.21252-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32684.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


