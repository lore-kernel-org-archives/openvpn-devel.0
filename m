Date: Wed, 17 Aug 2022 21:12:57 +0200 (CEST)
Message-Id: <202208171912.27HJCv2o044850@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220815223941.26839-1-a@...2181...>
References: <20220815223941.26839-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: don't pass VPN IPs to
 NEW_PEER API in P2P mode
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

This goes hand in hand with commit 383a897a5cb040d065689 in the ovpn-dco
repo ("require peer VPN IPs only in multipoint mode").  If the kernel does
no longer want this from us, no need to have it here.

Also, the kernel change fixes the edge case I found (ipv4-only without
route-gateway = breaks DCO setup).

So, upgraded the kernel, old openvpn -> "3a" fixed

New openvpn with this patch -> all tests still pass :-)  (that is: client
side DCO tests = p2p mode, and also server side DCO tests = p2mp mode - 
which are not touched by this code, but by the new kernel code)

This also takes care of the older patch from Frank Lichtenheld
("do not warn about missing default gw", PW ID 2646) as this rips out 
much more than just the warning - very good :-)

Your patch has been applied to the master branch.

commit da758e6d7f4298d835ceadd60e60309acc032ee7
Author: Antonio Quartulli
Date:   Tue Aug 16 00:39:41 2022 +0200

     dco: don't pass VPN IPs to NEW_PEER API in P2P mode

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220815223941.26839-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24940.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


