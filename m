Date: Mon, 22 Mar 2021 22:14:21 +0100 (CET)
Message-Id: <202103222114.12MLEKmC025259@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210322103957.1234-1-simon@...2293...>
References: <20210322103957.1234-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: Cache last error
 before it is overridden
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

Acked-by: Gert Doering <gert@...1296...>

Explanation and code make sense.  Test compiled on Ubuntu18/MinGW.

Your patch has been applied to the master and release/2.5 branch (bugfix).

And I managed to unmess the From: line before pushing :-) (and I *do*
have a pre-push-hook in place now that wakes me up next monday morning)

commit 1e938c50930f29124909e120a29fb116d4c46576 (master)
commit 24c1fc2a0ab5fa113d6769ab090de12e3719ab6b (release/2.5)
Author: Simon Rozman
Date:   Mon Mar 22 11:39:57 2021 +0100

     openvpnserv: Cache last error before it is overridden

     Signed-off-by: Simon Rozman <simon@...2293...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210322103957.1234-1-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21789.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


