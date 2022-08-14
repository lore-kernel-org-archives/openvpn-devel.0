Date: Sun, 14 Aug 2022 11:06:48 +0200 (CEST)
Message-Id: <202208140906.27E96mSY066974@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220813204224.22576-7-a@...2181...>
References: <20220813204224.22576-7-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: properly name variables
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

Thanks for that.  This really helps understanding which address is which.

Mechanical rename, so "trivial", but still tested on the Linux DCO test rig :-)

Interesting enough, uncrustify did not catch this whitespace error

+        vpn_ip4.s_addr =  htonl(c->c2.push_ifconfig_local);

"two blanks before htonl()" -> fixed.

Your patch has been applied to the master branch.

commit cea978bcb60a3b18be6d227466702fb14d6bc490
Author: Antonio Quartulli
Date:   Sat Aug 13 22:42:24 2022 +0200

     dco: properly name variables

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220813204224.22576-7-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24916.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


