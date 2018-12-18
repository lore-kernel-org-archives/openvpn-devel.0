Date: Tue, 18 Dec 2018 14:48:50 +0100 (CET)
Message-Id: <201812181348.wBIDmoAG041237@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181207123303.70827-1-gert@...1296...>
References: <20181207123303.70827-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add 'printing of port number'
 to mroute_addr_print_ex() for v4-mapped v6.
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Patch has been applied to the master and release/2.4 branch (as I see
this as a bugfix).  Uncrustify applied, tabs are spaced.

"Print port numbers on v6 addresses" landed on my agenda again, need
to make up my mind on address format and then come up with a proposal.

commit 4543b13b8540836f6faf67a03b5358bb8bb94a4a (master)
commit c2f7058700bc12858a74c53266534c567d1b05f2 (release/2.4)
Author: Gert Doering
Date:   Fri Dec 7 13:33:03 2018 +0100

     Add 'printing of port number' to mroute_addr_print_ex() for v4-mapped v6.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20181207123303.70827-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17996.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


