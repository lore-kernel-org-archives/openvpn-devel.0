Date: Sat, 17 Sep 2016 13:54:13 +0200 (CEST)
Message-Id: <201609171154.u8HBsDAK056296@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1474111006-16401-1-git-send-email-arne@...1227...>
References: <1474111006-16401-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix ENABLE_WITH_OPENSSL set to
	YES even with --disable-crypto set
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

ACK.

Your patch has been applied to the master branch.

Text changed to read "ENABLE_CRYPTO_OPENSSL"

commit d13a40a4a477bae3efede6945174df1cb2c3aa69
Author: Arne Schwabe
Date:   Sat Sep 17 13:16:46 2016 +0200

     Fix ENABLE_CRYPTO_OPENSSL set to YES even with --disable-crypto set

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1474111006-16401-1-git-send-email-arne@...1227...>
     URL: http://www.mail-archive.com/search?l=mid&q=1474111006-16401-1-git-send-email-arne@...1227...
     Signed-off-by: Gert Doering <gert@...1296...>

--
kind regards,

Gert Doering


