Date: Sun, 27 Apr 2014 15:46:31 +0200 (CEST)
Message-Id: <201404271346.s3RDkU4v001262@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1398080238-19662-1-git-send-email-steffan@...1856...>
References: <1398080238-19662-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix build system to accept
	non-system crypto library locations for plugins.
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

ACK.  (I had a really nice test case for this, as my "test-compile 2.3
with polar 1.2" tree only builds if the compile flags are honoured...)

Your patch has been applied to the master and release/2.3 branches.

commit ea31bc680fc83946b2cc8d0c93544a1ab2a01d63 (master)
commit c2faef04e61378ef5f112401b586fc9af6168f33 (master)

Author: Steffan Karger
Date:   Mon Apr 21 13:37:18 2014 +0200

     Fix build system to accept non-system crypto library locations for plugins.

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1398080238-19662-1-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8576
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


