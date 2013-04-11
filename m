Date: Thu, 11 Apr 2013 16:03:29 +0200
Message-Id: <201304111403.r3BE3TYH014880@...1729...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1365687278-3921-1-git-send-email-arne@...1227...>
References: <1365687278-3921-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Print client id only if
	compiled with man agent support. Otherwise print an empty string.
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

ACK.  After a long and tiring discussion on ways to make this less
ugly, without completely overengineering this simple function at the
same time...

Patch has been applied to the master branch and pushed.

commit 01cfa61a41e5162ba2f61383e03ff66741511d3a (master)

Author: Arne Schwabe
Date:   Thu Apr 11 15:34:38 2013 +0200

     Print client id only if compiled with man agent support. Otherwise print an empty string.

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1365687278-3921-1-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/7498
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


