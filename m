Date: Sat, 30 May 2020 10:25:43 +0200 (CEST)
Message-Id: <202005300825.04U8PhV1056797@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200530000600.1680-2-a@...2181...>
References: <20200530000600.1680-2-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: pool: prevent IPv6 pools to be
 larger than 2^16 addresses
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

This was an oversight by me, when initially implementing this - the
intention was always "cap the IPv6 pool size at 2^16", not "let it
grow until 2^31 and then cap to 2^16 thereafter".  It did no harm, 
as the IPv6 pool was always limited by IPv4 pool size (which is capped
to 2^16) - but with the "there can can be an IPv6-only pool now" 
work, this could lead to interesting malloc() explosions.

Your patch has been applied to the master and release/2.4 branch (bugfix).

commit 81d66a1f14d4be3282dd648ecc2049658e3a65ed (master)
commit fc0297143494e0a0f08564d90dbb210669d0abf5 (release/2.4)
Author: Antonio Quartulli
Date:   Sat May 30 02:05:54 2020 +0200

     pool: prevent IPv6 pools to be larger than 2^16 addresses

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200530000600.1680-2-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19945.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


