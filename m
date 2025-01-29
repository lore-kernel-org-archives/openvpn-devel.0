Date: Wed, 29 Jan 2025 10:56:39 +0100 (CET)
Message-Id: <202501290956.50T9udx3052116@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250129095038.19056-1-gert@...1296...>
References: <20250129095038.19056-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: route.c: change the signature
 of get_default_gateway()
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

As discusssed on IRC, this is the first patch of a series to improve
the IPv4 gateway lookup, aka, "make it as good as the IPv6 implementation".

The problem today is that the IPv4 code only looks for "the default route",
which is not the right answer for "which route and interface is used to
reach the VPN server?" in case of more-specific routes - arguably not the
most common case, but if we can get it right, we should.

This patch does not change anything but add an (unused) "in_addr_t host"
argument to all the get_default_gateway() calls & implementations.  Further
patches will enhance the per-platform implementations to use this info
(if possible).

So the thing to test here is "was any of our platforms overlooked, and
compilation fails" - and the anwswer is "it compiles, ship it!" ;-)

Your patch has been applied to the master branch.

commit 0fcfc8381f60d9f7b4a53afaea223dfee5e18835
Author: Lev Stipakov
Date:   Wed Jan 29 10:50:38 2025 +0100

     route.c: change the signature of get_default_gateway()

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250129095038.19056-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30685.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


