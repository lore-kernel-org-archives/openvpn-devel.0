Date: Fri, 27 Feb 2015 17:20:13 +0100 (CET)
Message-Id: <201502271620.t1RGKCx8016577@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1406667144-17674-1-git-send-email-steffan@...1856...>
References: <1406667144-17674-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix frame size calculation for
	non-CBC modes.
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

ACK, after discussion on #openvpn-devel.  For CBC (which are the default
modes so far) this is only refactoring, so no compatibility issues are
to be expected.

Your patch has been applied to the master and release/2.3 branches.

commit 669f898b8fcaf7a8d43825fa0255c2791cc0ef89 (master)
commit 6f0ab30d7f034d4f8d7c2ca872cfef066b16c7f0 (release/2.3)

Author: Steffan Karger
Date:   Tue Jul 29 22:52:24 2014 +0200

     Fix frame size calculation for non-CBC modes.

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1406667144-17674-1-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8952
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


