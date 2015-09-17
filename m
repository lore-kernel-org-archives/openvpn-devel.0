Date: Thu, 17 Sep 2015 20:16:26 +0200 (CEST)
Message-Id: <201509171816.t8HIGQn9095968@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1442485438-15704-1-git-send-email-arne@...1227...>
References: <1442485438-15704-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Do not install a host route for
	the VPN on Android
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

ACK (as expected - since this code will not do useful things on 
Android, just #ifndef it away)

Your patch has been applied to the master branch.

commit 1ff39cff4e644103607f0266cd4666dab18716c5
Author: Arne Schwabe
Date:   Thu Sep 17 12:23:58 2015 +0200

     Do not install a host route for the VPN on Android

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1442485438-15704-1-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10135
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


