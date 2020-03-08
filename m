Date: Sun, 8 Mar 2020 20:38:18 +0100 (CET)
Message-Id: <202003081938.028JcIEV064813@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200205175556.1877-1-simon@...2293...>
References: <20200205175556.1877-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun.c: refactor driver
 detection and make it case-insensitive
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

And, indeed, thanks for that :-) - I do remember complaining about the
old code - technically correct but very hard to read.  The new code is
much easier to read (and should do the same, except for the case 
insensitivity).

Test compiled on Ubuntu 16.04 / MinGW.

commit 0b8714f627b2d740be7f8ff6f42cd276030e6d67
Author: Simon Rozman
Date:   Wed Feb 5 18:55:56 2020 +0100

     tun.c: refactor driver detection and make it case-insensitive

     Signed-off-by: Simon Rozman <simon@...2293...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20200205175556.1877-1-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19365.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


