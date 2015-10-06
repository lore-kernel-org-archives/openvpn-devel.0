Date: Tue, 6 Oct 2015 12:40:55 +0200 (CEST)
Message-Id: <201510061040.t96AetD3097749@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1442953884-54602-1-git-send-email-gert@...1296...>
References: <1442953884-54602-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add custom check for
	inet_pton()/inet_ntop() on MinGW/WIN32
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Lazy-ACK rules have been applied ("nobody screamed for two weeks", and it
got tested on various mingw versions plus cygwin).

Patch has been applied to the master branch.

commit f96baabc6cf10edddedda1819a27a6927f274d8e
Author: Gert Doering
Date:   Tue Sep 22 22:31:24 2015 +0200

     Add custom check for inet_pton()/inet_ntop() on MinGW/WIN32

     Signed-off-by: Gert Doering <gert@...1296...>
     Lazy-ACK-by: Gert Doering <gert@...1296...>
     Tested-by: Heiko Hund <heiko.hund@...1489...>
     Tested-by: Samuli Seppänen <samuli@...515...>
     Message-Id: <1442953884-54602-1-git-send-email-gert@...1296...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10165


--
kind regards,

Gert Doering


