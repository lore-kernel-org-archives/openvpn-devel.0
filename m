Date: Wed, 4 Jan 2017 20:29:30 +0100 (CET)
Message-Id: <201701041929.v04JTU3A063128@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20161216163218.25449-1-jm@...1926...>
References: <20161216163218.25449-1-jm@...1926...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix implicit declarations when
	HAVE_OPENSSL_ENGINE is unset
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
To: Julien Muchembled <jm@...1926...>
Cc: openvpn-devel@lists.sourceforge.net

Sorry for the delay, this got lost in the pre-2.4 craziness.

Your patch has been applied to the release/2.3 branch.

Thanks!

commit ab1302d47b0f2b2ac9272b9fbb90ef0bd7b7cc35
Author: Julien Muchembled
Date:   Fri Dec 16 17:32:18 2016 +0100

     Fix implicit declarations when HAVE_OPENSSL_ENGINE is unset

     Signed-off-by: Julien Muchembled <jm@...1926...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <20161216163218.25449-1-jm@...1926...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13591.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


