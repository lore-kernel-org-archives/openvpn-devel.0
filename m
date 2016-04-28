Date: Thu, 28 Apr 2016 16:59:32 +0200 (CEST)
Message-Id: <201604281459.u3SExW3L058767@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1460918143-408-1-git-send-email-steffan@...1856...>
References: <1460918143-408-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Migrate to mbed TLS 2.x
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

(One minor whitespace fix to configure.ac)

Just to point it out here again, in case someone is frustrated and googles
for it: mbedTLS 2.x refuses RSA keys < 2048 bits by default - so if your
setup is nicely working with shorter RSA keys and PolarSSL 1.3 today, 
this commit *will break it* - and it won't tell you why ("VERIFY FAILED"
is all you get).  A patch with a more helpful error message is forthcoming.


commit 86d8cd6860dfc74cb1a040ff8fe03140ebe7f930
Author: Steffan Karger
Date:   Sun Apr 17 20:35:42 2016 +0200

     Migrate to mbed TLS 2.x

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <1460918143-408-1-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11458
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


