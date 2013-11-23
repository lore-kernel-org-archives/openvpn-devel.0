Date: Sat, 23 Nov 2013 13:59:50 +0100
Message-Id: <201311231259.rANCxoSB028643@...1729...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1385210434-28364-1-git-send-email-arne@...1227...>
References: <1385210434-28364-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix compile error in
	ssl_openssl introduced by polar external-management patch
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

Thanks.  ACKed on #openvpn-devel and on the list (and this time, actually 
compile-tested locally before pushing).

Patch has been applied to the master and release/2.3 branches.

commit 20fe5561dfe7a6f1da3aac07b38d0773c2758e5e (master)
commit 816ccf2666a2de6b7098c4b28d931ea378c278ea (release/2.3)

Author: Arne Schwabe
Date:   Sat Nov 23 13:40:34 2013 +0100

     Fix compile error in ssl_openssl introduced by polar external-management patch

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1385210434-28364-1-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8039
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


