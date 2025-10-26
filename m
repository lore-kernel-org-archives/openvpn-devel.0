Date: Sun, 26 Oct 2025 22:50:09 +0100 (CET)
Message-Id: <202510262150.59QLo994014340@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251026142100.12147-1-gert@...1296...>
References: <20251026142100.12147-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove perf.c/perf.h
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

Out it goes!  The less magical stuff we need to maintain and understand,
the better (especially if it really does not actually work anymore).

I have stared-at-code, the buildbots have built & t_client tested it,
and the remaining failing testcase (1h) is due to external circumstances
(buildbot environment / DNS, "it's always DNS").

Your patch has been applied to the master branch.

commit 9c55e84eea01b1f3ddabae82c7df8adaac7b8c35
Author: Steffan Karger
Date:   Sun Oct 26 15:20:52 2025 +0100

     Remove perf.c/perf.h

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1303
     Message-Id: <20251026142100.12147-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33868.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


