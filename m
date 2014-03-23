Date: Sun, 23 Mar 2014 20:12:00 +0100 (CET)
Message-Id: <201403231912.s2NJC0TW022195@...1295...>
From: Gert Doering <gert@...1296...>
Subject: [PATCH applied] Re: Introduce an option to resolve dns names in advance for =?unknown-8bit?b?4oCUcmVtb3RlLCDigJRsb2NhbA==?= and http-proxy
In-Reply-To: <1395576786-17507-1-git-send-email-arne@...1227...>
References: <1395576786-17507-1-git-send-email-arne@...1227...>
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

ACK, with some whitespace fixes (undoing spurious changes, cleaning up 
others), and swapping the if/else branches in socket.c/do_preresolve_host()
for easier readability (no functional change) as agreed on IRC.

t_client tested OK (without --preresolve).

Patch has been applied to the master branch.

commit e719a0535345db8f0781c0b80408ca5417597469

Author: Arne Schwabe
Date:   Sun Mar 23 13:13:06 2014 +0100

     Introduce an option to resolve dns names in advance for âremote, âlocal and http-proxy

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1395576786-17507-1-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8386
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


