Date: Sat, 14 Mar 2020 13:43:09 +0100 (CET)
Message-Id: <202003141243.02ECh9Pt099400@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200310094822.588-1-simon@...2293...>
References: <20200310094822.588-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun.c: reorder IPv6 ifconfig on
 Windows
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

I did a cursory review and the changes look good (the ACK is Lev's, 
though :-) ).  Test compiled on Ubuntu 16.04/MinGW for good measure.

commit f3ef6ced23b659855ac8b957e147fa8b58578098
Author: Simon Rozman
Date:   Tue Mar 10 10:48:21 2020 +0100

     tun.c: reorder IPv6 ifconfig on Windows

     Signed-off-by: Simon Rozman <simon@...2293...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20200310094822.588-1-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19541.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


