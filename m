Date: Wed, 21 Feb 2018 20:13:23 +0100 (CET)
Message-Id: <201802211913.w1LJDN4h088214@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20180220202508.16201-1-steffan@...1856...>
References: <20180220202508.16201-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Get rid of
 ax_check_compile_flag.m4
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

Acked-by: Gert Doering <gert@...1296...>

Tested on OpenSolaris (since this one of my buildslaves), and the problem
goes away.  So I assume Centos6 should be fine, too.

AIX7 is still working :)

Your patch has been applied to the master and release/2.4 branch.

commit 6a5d10e96b9ad2f9a9472aeee8cdb7c02fe4d050 (master)
commit fc70bc8b30eab2bea5e9486182184b1b6b7ceb60 (release/2.4)
Author: Steffan Karger
Date:   Tue Feb 20 21:25:08 2018 +0100

     Get rid of ax_check_compile_flag.m4

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20180220202508.16201-1-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16515.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


