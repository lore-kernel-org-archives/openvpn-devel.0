Date: Mon, 1 Jun 2015 21:54:11 +0200 (CEST)
Message-Id: <201506011954.t51JsB8x006932@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1433178914-7842-1-git-send-email-gert@...1296...>
References: <1433178914-7842-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use EAI_AGAIN instead of
	EAI_SYSTEM for openvpn_getaddrinfo().
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

commit 8ceb9619a26f8c507bafbc6d59aed3f65a30455d (master)
commit 874ffde11255beb6873024b24c4231934460f485 (release/2.3)

Author: Gert Doering
Date:   Mon Jun 1 19:15:14 2015 +0200

     Use EAI_AGAIN instead of EAI_SYSTEM for openvpn_getaddrinfo().

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <1433178914-7842-1-git-send-email-gert@...1296...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/9768


--
kind regards,

Gert Doering


