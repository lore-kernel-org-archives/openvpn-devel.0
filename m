Date: Fri, 18 Sep 2020 09:45:56 +0200 (CEST)
Message-Id: <202009180745.08I7jum0083090@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200914070843.51678-1-gert@...1296...>
References: <20200914070843.51678-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix combination of --dev tap
 and --topology subnet across multiple platforms.
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

Patch has been applied to the master and release/2.5 branch.

(I leave the ticket open with "milestone 2.6" to prod me into
the long-planned refactoring of these if() variants into something
with an enum and "speaking" identifiers)

commit 860a7bc77ef515f1d042a2860f7e2bd9980e19be (master)
commit a5964e34057bd3a2c0cb232f1abc6feeefdf146e (release/2.5)
Author: Gert Doering
Date:   Mon Sep 14 09:08:43 2020 +0200

     Fix combination of --dev tap and --topology subnet across multiple platforms.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20200914070843.51678-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20987.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


