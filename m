Date: Mon, 22 Jan 2024 13:46:34 +0100 (CET)
Message-Id: <202401221246.40MCkYOf002795@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240122092122.8591-1-gert@...1296...>
References: <20240122092122.8591-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: --http-proxy-user-pass: allow
 to specify in either order with --http-proxy
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

Stared at code, stared at manpage (+changes), patch makes sense.

Haven't tested "for real" beyond "passes t_client tests", which do use
http-proxy, but which do not use an authenticated proxy (yet -> TBD!).

Your patch has been applied to the master and release/2.6 branch
("make behaviour consistent" counts as "bugfix", and it's only a small
and localized change).

commit a634cc5eccd55f1d14197da7376bb819bdf72cb6 (master)
commit 1141e7505747dd6029ac7cf19b6c2de99a685ccc (release/2.6)
Author: Frank Lichtenheld
Date:   Mon Jan 22 10:21:22 2024 +0100

     --http-proxy-user-pass: allow to specify in either order with --http-proxy

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240122092122.8591-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28099.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


