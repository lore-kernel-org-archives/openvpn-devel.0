Date: Sun, 4 Oct 2020 15:53:58 +0200 (CEST)
Message-Id: <202010041353.094Drwux046819@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200930064845.28022-1-jan.seeger@...2574...>
References: <20200930064845.28022-1-jan.seeger@...2574...>
Subject: [Openvpn-devel] [PATCH applied] Re: Added environment variable for
 IPv6 route metric.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jan Seeger <jan.seeger@...2574...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

I have not actually tested this (I have no testbed with IPv6 route
metrics, and I do not feel like creating one).  So I have only test-
compiled this, and "stared at code", which looks good.

Your patch has been applied to the master and release/2.5 branch.

I have slightly reworded the commit message (as Antonio remarked) to
mention the actual *name* of the added environment variable.

commit bfb288454aa43f8c2d0131bc87b48a37e4ab01b4 (master)
commit 956c5af148d0f6d9b70d0498a499f6b70c8e8035 (HEAD -> release/2.5)
Author: Jan Seeger
Date:   Wed Sep 30 08:48:45 2020 +0200

     Added 'route_ipv6_metric_NN' environment variable for IPv6 route metric.

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200930064845.28022-1-jan.seeger@...2574...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21110.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


