Date: Mon, 11 Jul 2016 21:40:21 +0200 (CEST)
Message-Id: <201607111940.u6BJeLOm097141@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1467149635-9726-1-git-send-email-steffan@...1856...>
References: <1467149635-9726-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add client-side support for
	cipher negotiation
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

Another ACK from me.  Stared at the code for another while, still looks 
reasonable.  Passes my t_client tests, t_server tests, and does not 
break Android :-)

Your patch has been applied to the master branch.

commit 97894360fa537945e07fd6a85d0659e094b693a5
Author: Steffan Karger
Date:   Tue Jun 28 23:33:55 2016 +0200

     Add client-side support for cipher negotiation

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1467149635-9726-1-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/12007
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


