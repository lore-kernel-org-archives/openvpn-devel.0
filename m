Date: Mon, 1 Jun 2015 21:19:38 +0200 (CEST)
Message-Id: <201506011919.t51JJcYY023072@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1433185487-9724-1-git-send-email-gert@...1296...>
References: <1433185487-9724-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use configure.ac hack to apply
	serial_test AM option only if supported.
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

Patch has been applied to the master and release/2.3 branch.

(Also tested by using buildbot on the "experimental" branch, plus building
windows release from that - so we're fairly confident that it will not
blow up stuff this time - sorry for the noise on the list)

commit c615835aa93701c764c23fc2579d97757c1a9970 (master)
commit d378850ab70af4c967d099627f0a19ad42ecbdcb (release/2.3)

Author: Gert Doering
Date:   Mon Jun 1 21:04:47 2015 +0200

     Use configure.ac hack to apply serial_test AM option only if supported.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: David Sommerseth <davids@...1347...>
     Message-Id: <1433185487-9724-1-git-send-email-gert@...1296...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/9769


--
kind regards,

Gert Doering


