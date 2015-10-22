Date: Thu, 22 Oct 2015 19:49:24 +0200 (CEST)
Message-Id: <201510221749.t9MHnOeb061834@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1445500282-23129-1-git-send-email-lstipakov@...277...>
References: <1445500282-23129-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Generate openvpn-plugin.h for
	MSVC build
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  I have no idea what it does in particular, but as it does only
touch files for MSVC build and this basically affects only you and
(possibly) James, I just trust you :-)

Your patch has been applied to the master branch.

commit dd8d351dbc92ede6726b7090ed4eceb9b95318c6
Author: Lev Stipakov
Date:   Thu Oct 22 10:51:22 2015 +0300

     Generate openvpn-plugin.h for MSVC build

     Signed-off-by: Lev Stipakov <lstipakov@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1445500282-23129-1-git-send-email-lstipakov@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10360
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


