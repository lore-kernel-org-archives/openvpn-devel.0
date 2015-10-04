Date: Sun, 4 Oct 2015 22:33:46 +0200 (CEST)
Message-Id: <201510042033.t94KXkaj060238@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <561130FC.8090008@...1856...>
References: <561130FC.8090008@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Replace strdup() calls for
	string_alloc() calls
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

ACK.

Your patches have been applied to the master and release/2.3 branch.

commit ddc7692d245017c71adc40ad5cc195617e39fce0 (master)
commit 6d4920e9d36675ff515da17c1eb301d22d07b489 (release/2.3)

Author: Steffan Karger
Date:   Mon Sep 21 20:48:33 2015 +0200

     Replace strdup() calls for string_alloc() calls

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <561130FC.8090008@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10176
     Signed-off-by: Gert Doering <gert@...1296...>

commit 5584b738a332d0abc740d9303c275764c2ca13f1 (master)
commit ad71fe5f79ffbd4c86afa79d4559b08617b41dfb (release/2.3)

Author: Steffan Karger
Date:   Mon Sep 21 22:04:19 2015 +0200

     Check return value of ms_error_text()

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <561130FC.8090008@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10176
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


