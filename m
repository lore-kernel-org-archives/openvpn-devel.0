Date: Mon, 7 Jul 2014 20:20:56 +0200 (CEST)
Message-Id: <201407071820.s67IKuPh022706@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1402409073-54067216-4-git-send-email-gert@...1296...>
References: <1402409073-54067216-4-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: implement adding/deleting
	routes on AIX, for IPv4 and IPv6
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
To: Gert Doering <gd@...1505...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

(A followup patch will have to come, making use of count_netmask_bits(), 
and drop the netmask_to_netbits2() helper again)

commit b4b92ae5dca218325dfbe16992922716ea83e261
Author: Gert Doering
Date:   Tue Jun 10 16:04:32 2014 +0200

     implement adding/deleting routes on AIX, for IPv4 and IPv6

     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <1402409073-54067216-4-git-send-email-gert@...1296...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8785
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


