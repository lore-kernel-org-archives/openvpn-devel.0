Date: Tue, 26 Nov 2013 16:59:49 +0100
Message-Id: <201311261559.rAQFxm8o027680@...1729...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1385382680-5912-3-git-send-email-arne@...1227...>
References: <1385382680-5912-3-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove the ip-remote-hint
	option.
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

ACK.  

Feature-ACK agreed in Munich, on the assumption that it will eventually 
come back as an alias of "--resolve-remotes-at-startup <ip>".  Right now,
the feature just gets in the way of the dual-stack changes.

Code-ACK.  Looks simple enough, and passes my t_client tests :-)

Patch has been applied to the master branch.

commit bb9026a60a8ebdf20fdf9a99e16c0d8afc658747 (master)

Author: Arne Schwabe
Date:   Mon Nov 25 13:31:14 2013 +0100

     Remove the ip-remote-hint option.

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1385382680-5912-3-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8057
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


