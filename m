Date: Mon, 2 Oct 2017 21:13:23 +0200 (CEST)
Message-Id: <201710021913.v92JDNvw040527@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20171002190732.12531-1-davids@...515...>
References: <20171002190732.12531-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: lz4: Fix broken builds when
 pkg-config is not present but system library is
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  Tested locally.  Now let's see what MacOS thinks about it :-)

Your patch has been applied to the master and release/2.4 branch.

commit e5b279f1b62e75569ee8d988b55e6ee0dc93464e (master)
commit c70a80b1b73d658bfe16225048d95958daf034e7 (release/2.4)
Author: David Sommerseth
Date:   Mon Oct 2 21:07:32 2017 +0200

     lz4: Fix broken builds when pkg-config is not present but system library is

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20171002190732.12531-1-davids@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15549.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


