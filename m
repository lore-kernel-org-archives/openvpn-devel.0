Date: Sat, 28 Nov 2015 14:21:13 +0100 (CET)
Message-Id: <201511281321.tASDLDAX011843@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1448707105-10753-1-git-send-email-steffan@...1856...>
References: <1448707105-10753-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: openssl: properly check return
	value of RAND_bytes()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

ACK2.

Your patch has been applied to the master and release/2.3 branch.

Note: crypto_msg() was changed to msg() for 2.3

commit 756602e7da11362f25be04743cd09f798b6f528a (master)
commit ee714263892068171181e683aef9bc5e9dcac54a (release/2.3)

Author: Steffan Karger
Date:   Sat Nov 28 11:38:24 2015 +0100

     openssl: properly check return value of RAND_bytes()

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1448707105-10753-1-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10637
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


