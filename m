Date: Wed, 18 Dec 2019 20:50:44 +0100 (CET)
Message-Id: <201912181950.xBIJoiSd014465@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191218061818.1504-1-simon@...2293...>
References: <20191218061818.1504-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: wintun: set adapter properties
 via interactive service
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

Your patch has been applied to the master branch.

(This is a bit of a weird one, as the "v3" of 6/7 was sent by Simon,
fixing the strcpy() part, but having "From: Lev" in it... I cannot
technically accept the acked-by: in such a patch because it would be
from the same person that send the new version.  *But* I verified that
it's really the same patch minus the strcpy() part, and "Lev as author,
Simon as ACKer" is fine under these circumstances)


Code-wise I'm not exactly happy with "do_route_ipv4_service_tun()" 
- we do have a function called add_route_connected_v6_net(), so if 
we need the same functionality for IPv4, it should be called 
"add_route_connected_v4_net()" or whatever, not "something completely
different"...  also I don't think it should hook right into 
do_route_ipv4_service(), which is (was...) an *internal* function in 
route.c for a reason - the well-defined API between tun.c and route.c 
is "add_route()".

Finally the patch breaks indentation rules, so might have been 
coded in a nicer way *or* fix the indent right away - now we have 
another uncrustify patch coming which has to changes code without 
it being what the underlying change was.


Test built on Ubuntu 1604/mingw, not tested further.


commit 1c4a47f796639da45ec7c9bf5f38a9f0bb6aa9b2
Author: Lev Stipakov
Date:   Wed Dec 18 07:18:18 2019 +0100

     wintun: set adapter properties via interactive service

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Simon Rozman <simon@...2293...>
     Message-Id: <20191218061818.1504-1-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19253.html
     Signed-off-by: Gert Doering <gert@...1296...>

--
kind regards,

Gert Doering


