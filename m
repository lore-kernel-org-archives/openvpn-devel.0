Date: Thu, 20 Jun 2013 20:55:26 +0200 (CEST)
Message-Id: <201306201855.r5KItQZT014998@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1366059999-31731-1-git-send-email-arne@...1227...>
References: <1366059999-31731-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: PATCHv3 Remove unused variables
	or put them to the defines they are being used in
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

ACK.  Lightly compile-tested with default options on Linux, but except
for the last chunk, nothing seems to depend on #ifdefs, so if it indeed
breaks some weird combination of options, buildbot will tell...

Patch has been applied to the master branch.

commit d0c4c442a44f85c18903b4edba9c1d726f6983c0 (master)

Author: Arne Schwabe
Date:   Mon Apr 15 23:06:39 2013 +0200

     PATCHv3 Remove unused variables or put them to the defines they are being used in

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1366059999-31731-1-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/7511
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


