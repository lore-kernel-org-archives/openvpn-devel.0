Date: Thu, 23 Feb 2017 10:20:05 +0100 (CET)
Message-Id: <201702230920.v1N9K5h3058826@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <345db0ac-f6e8-8490-a80a-ffbd81972c07@...1856...>
References: <345db0ac-f6e8-8490-a80a-ffbd81972c07@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix segfault when using crypto
	lib without AES-256-CTR or SHA256
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
To: Simon Matter <simon.matter@...2249...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks.

Your patch has been applied to the master and release/2.4 branches.

commit 2fe5547c1df854d41611633ea533649fe88e3031 (master)
commit c9b4313eae6fc59f7d075edf23a7f59b137ba11f (release/2.4)
Author: Simon Matter
Date:   Tue Feb 21 20:34:15 2017 +0100

     Fix segfault when using crypto lib without AES-256-CTR or SHA256

     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <345db0ac-f6e8-8490-a80a-ffbd81972c07@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14138.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


