Date: Sun, 22 Dec 2019 19:50:13 +0100 (CET)
Message-Id: <201912221850.xBMIoDUG087935@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191220161117.1434-1-simon@...2293...>
References: <20191220161117.1434-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun.c: make Windows device
 lookup functions more general
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

Lev: if there is a whole new v2 series, it would be good to have a bit
more verbose ACKs on the v2 patches than just "it's nearly the same as 
v1, so ACK" - if you haven't read the v1 thread (because "oh, a v2 is 
coming, so I can wait") this means you actually have to go back if you're 
interested...

Compile tested on Ubuntu 1604 and lightly stared at code.

commit be78706830f02b095392ff063c9490da27b6faa1
Author: Simon Rozman
Date:   Fri Dec 20 17:11:11 2019 +0100

     tun.c: make Windows device lookup functions more general

     Signed-off-by: Simon Rozman <simon@...2293...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20191220161117.1434-1-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19280.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


