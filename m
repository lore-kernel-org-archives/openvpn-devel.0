Date: Tue, 29 Apr 2014 23:06:17 +0200 (CEST)
Message-Id: <201404292106.s3TL6HHE020255@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1391873629-14388-1-git-send-email-dt@...1411...>
References: <1391873629-14388-1-git-send-email-dt@...1411...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix is_ipv6 in case of tap
	interface.
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
To: Dmitrij Tejblum <dt@...1411...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  Sorry for the long delay.  

Tested against reference tap server with "--mssfix 1000", verified with 
tcpdump without/with the patch and IPv4 and IPv6 TCP SYNs.

Your patch has been applied to the master and release/2.3 branches.

commit db037c20086587a609ef33127c15de080270f2cb (master)
commit 7227af1131a5d7ae2ea4d8d1cd3cba3001440326 (release/2.3)

Author: Dmitrij Tejblum
Date:   Sat Feb 8 19:33:49 2014 +0400

     Fix is_ipv6 in case of tap interface.

     Signed-off-by: Dmitrij Tejblum <dt@...1411...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1391873629-14388-1-git-send-email-dt@...1411...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8259
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


