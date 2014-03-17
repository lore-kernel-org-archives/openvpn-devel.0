Date: Mon, 17 Mar 2014 20:12:42 +0100 (CET)
Message-Id: <201403171912.s2HJCgt6027162@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1395017376-24554-1-git-send-email-james@...515...>
References: <1395017376-24554-1-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: Set SSL_OP_NO_TICKET flag in
	SSL context for OpenSSL builds,
	to disable TLS stateless session resumption.
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
To: James Yonan <james@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.3 branches.

commit 25f4d4b49bff342fd9dd54cd22f14c9de49e9f8b (master)
commit 058e889d186c616c648802da2eadf0380086bd6e (release/2.3)

Author: James Yonan
Date:   Sun Mar 16 18:49:36 2014 -0600

     Set SSL_OP_NO_TICKET flag in SSL context for OpenSSL builds, to disable TLS stateless session resumption.

     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <1395017376-24554-1-git-send-email-james@...515...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8346
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


