Date: Mon, 17 Mar 2014 20:12:36 +0100 (CET)
Message-Id: <201403171912.s2HJCaS4003327@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1395060345-30870-1-git-send-email-arne@...1227...>
References: <1395060345-30870-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix warning for max-routes: do
	not quit when parsing an old configuration. Format the
	message to be more like the other deprecated options
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

ACK. Patch has been applied to the master branch (no reason to apply to 2.3
as it fixes a change introduced in master only).

commit 4affd9c98636e6c83aad4f0e7859a29f66898b72 (master)

Author: Arne Schwabe
Date:   Mon Mar 17 13:45:45 2014 +0100

     Fix warning for max-routes: do not quit when parsing an old configuration. Format the message to be more like the other deprecated options

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1395060345-30870-1-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8354
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


