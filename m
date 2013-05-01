Date: Wed, 1 May 2013 12:41:41 +0200 (CEST)
Message-Id: <201305011041.r41AffAb003354@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1367006045-13576-2-git-send-email-arne@...1227...>
References: <1367006045-13576-2-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: 2/3] add ability to
	send/receive file descriptors via management interface,
	only used in android so. For now under #ifdef ANDROID
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

ACK from me.

Patch has been applied to the master branch (with some whitespace fixes).

commit ad2df7b983eadbdc81fe0cf92543cad27b8f8882
Author: Arne Schwabe
Date:   Fri Apr 26 21:54:04 2013 +0200

     Add ability to send/receive file descriptors via management interface

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1367006045-13576-2-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/7557
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


