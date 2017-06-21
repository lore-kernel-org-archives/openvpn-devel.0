Date: Wed, 21 Jun 2017 12:03:40 +0200 (CEST)
Message-Id: <201706211003.v5LA3eps073842@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1497864520-12219-4-git-send-email-steffan.karger@...1435...>
References: <1497864520-12219-4-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix remote-triggerable memory
 leaks (CVE-2017-7521)
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master, release/2.4 and release/2.3 branch.

commit 2d032c7fcdfd692c851ea2fa858b4c2d9ea7d52d (master)
commit 2341f716198fa90193e040b3fdb16959a47c6c27 (release/2.4)
commit 84e1775961de1c9d2ab32159fc03f758591f5238 (release/2.3)
Author: Steffan Karger
Date:   Mon Jun 19 11:28:38 2017 +0200

     Fix remote-triggerable memory leaks (CVE-2017-7521)

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Acked-by: David Sommerseth <davids@...515...>
     Acked-by: Guido Vranken <guidovranken@...277...>
     Message-Id: <1497864520-12219-4-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/search?l=mid&q=1497864520-12219-4-git-send-email-steffan.karger@...1435...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


