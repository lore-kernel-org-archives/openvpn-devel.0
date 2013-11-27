Date: Wed, 27 Nov 2013 20:34:58 +0100 (CET)
Message-Id: <201311271934.rARJYvuJ006013@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1385382680-5912-5-git-send-email-arne@...1227...>
References: <1385382680-5912-5-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: When resolving fails print the
	error message from socket layer
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

Patch has been applied to master branch.  It looks useful for 2.3 as 
well, but the code is different enough already that it wouldn't apply
as is, so it would be a separate patch.

commit aa162d44edae8530391775b55e7b4f149548537e (master)

Author: Arne Schwabe
Date:   Mon Nov 25 13:31:16 2013 +0100

     When resolving fails print the error message from socket layer

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1385382680-5912-5-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8059
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


