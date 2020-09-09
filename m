Date: Wed, 9 Sep 2020 09:55:01 +0200 (CEST)
Message-Id: <202009090755.0897t1xw010496@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200908105130.24171-1-gert@...1296...>
References: <20200908105130.24171-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix error detection / abort in
 --inetd corner case.
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Patch has been applied to the master, release/2.5 and release/2.4 branch.

The 2.4 patch only has the actual "--inetd" fix, not the uncrustify whitespace
change for --bind-dev (code not in 2.4).

(As a side note for the protocol: it turns out this only fixes "--inetd nowait",
aka "--proto tcp-server".  Running "openvpn --dev tap --inetd" + pressing return
will still lead to busy spinning in the UDP receive path... next fix coming)

commit a09a2fadbadb5dc435f6fccc581163e1f637f43f (master)
commit 05050e7d089e382e0e8bc7565f30e02e2246d569 (release/2.5)
commit 769c894db29f76f6510569fc20633fb6f0c357f9 (release/2.4)
Author: Gert Doering
Date:   Tue Sep 8 12:51:30 2020 +0200

     Fix error detection / abort in --inetd corner case.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20200908105130.24171-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20897.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


