Date: Mon, 14 Dec 2015 18:47:20 +0100 (CET)
Message-Id: <201512141747.tBEHlKFZ055907@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1449923660-27363-1-git-send-email-lstipakov@...277...>
References: <1449923660-27363-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Pass adapter index to up/down
	scripts
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  I have not actually compile-tested this (buildbot will :-) ) but
it looks reasonable and since we've decided to use idx for netsh.exe, 
it should be available to scripts too.

Your patch has been applied to the master and release/2.3 branch.

I've taken the liberty of actually documenting $env_idx in doc/openvpn.8

commit 9dff2c1f106865a72a1d505076751dde170e88dc (master)
commit 9fe2ac8d51b8182f5e8e41ce7c875f451de10191 (release/2.3)

Author: Lev Stipakov
Date:   Sat Dec 12 14:34:20 2015 +0200

     Pass adapter index to up/down scripts

     Signed-off-by: Lev Stipakov <lstipakov@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1449923660-27363-1-git-send-email-lstipakov@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10762
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


