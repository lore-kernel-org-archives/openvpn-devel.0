Date: Sun, 29 Nov 2015 13:46:49 +0100 (CET)
Message-Id: <201511291246.tATCknvr018057@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1448750881-10767-1-git-send-email-steffan@...1856...>
References: <1448750881-10767-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix openssl builds with
	custom-built library: specify most-dependent first
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

Your patch has been applied to the master branch (with some massaging as
the context has the aead_modes stuff in your tree...).

commit 09f2670ce27158f81b4983c06f63870a5188d4aa
Author: Steffan Karger
Date:   Sat Nov 28 23:48:01 2015 +0100

     Fix openssl builds with custom-built library: specify most-dependent first

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <1448750881-10767-1-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10649
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


