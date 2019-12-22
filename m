Date: Sun, 22 Dec 2019 20:00:47 +0100 (CET)
Message-Id: <201912221900.xBMJ0lIl088107@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191220161117.1434-2-simon@...2293...>
References: <20191220161117.1434-2-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun.c: upgrade
 get_device_guid() to return the Windows driver type
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

Compile tested on Ubuntu 1604 and stared at code.

As a side note: the granularity of this one is a bit too fine-grained 
for my taste - it changes the function, but none of the callers make
use of it, so it's somewhat of a no-op and hard to test.

commit 9db385f2d179bbc578112e7526b51d424a62aac5
Author: Simon Rozman
Date:   Fri Dec 20 17:11:12 2019 +0100

     tun.c: upgrade get_device_guid() to return the Windows driver type

     Signed-off-by: Simon Rozman <simon@...2293...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20191220161117.1434-2-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19277.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


