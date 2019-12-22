Date: Sun, 22 Dec 2019 20:05:49 +0100 (CET)
Message-Id: <201912221905.xBMJ5n8H088231@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191220161117.1434-3-simon@...2293...>
References: <20191220161117.1434-3-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun.c: make
 wintun_register_ring_buffer() non-fatal on failures
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
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

Compile-tested on Ubuntu1604, stared a bit at the code.

commit 9a8966c2cbe796a51aa971e83850a2de8f4531ec
Author: Simon Rozman
Date:   Fri Dec 20 17:11:13 2019 +0100

     tun.c: make wintun_register_ring_buffer() non-fatal on failures

     Signed-off-by: Simon Rozman <simon@...2293...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20191220161117.1434-3-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19283.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


