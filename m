Date: Wed, 5 Dec 2018 22:41:34 +0100 (CET)
Message-Id: <201812052141.wB5LfYCK070831@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <777939F9-A753-4A66-B40E-1346AFD588DE@...1918...>
References: <777939F9-A753-4A66-B40E-1346AFD588DE@...1918...>
Subject: [Openvpn-devel] [PATCH applied] Re: Adds support for setting the
 default IPv6 gateway for routes using the route-ipv6-gateway option.
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
To: James Bekkema <james@...1918...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

Thanks for not just enabling the option but for also showing a valid
use case (which was mostly the reason why this got never implemented,
I couldn't see a case where this was really useful).

commit d24e1b179b95a57b81d9802c13426b5cde66de10 (master)
Author: James Bekkema
Date:   Mon Jul 23 13:28:31 2018 +1000

     Adds support for setting the default IPv6 gateway for routes using the route-ipv6-gateway option.

     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <777939F9-A753-4A66-B40E-1346AFD588DE@...1918...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17290.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


