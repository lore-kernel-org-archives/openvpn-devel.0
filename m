Date: Mon, 7 Jul 2014 22:09:34 +0200 (CEST)
Message-Id: <201407072009.s67K9YQ0010531@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1402244175-31462-5-git-send-email-steffan@...1856...>
References: <1402244175-31462-5-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Extend t_lpback tests to test
	all ciphers reported by --show-ciphers
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

Your patch has been applied to the master branch.

(It might break the script on some of the more obscure platforms that 
haven't learned the new POSIXly "tail -n+7" yet.  But if so, buildbot 
will tell us, and we can then still fix it, like by using "sed -e '1,6d'" 
instead...)

commit b2bff9fa15695f2850999688b0ca6047016fd7f5
Author: Steffan Karger
Date:   Sun Jun 8 18:16:15 2014 +0200

     Extend t_lpback tests to test all ciphers reported by --show-ciphers

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <1402244175-31462-5-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8777
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


