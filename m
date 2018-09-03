Date: Mon, 3 Sep 2018 10:39:56 +0200 (CEST)
Message-Id: <201809030839.w838duC5083300@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1535550583-21825-1-git-send-email-steffan.karger@...1435...>
References: <1535550583-21825-1-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix memory leak after sighup
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

Your patch has been applied to the master and release/2.4 branch (bugfix).

commit 7170bef507bfe74ceb4a12f8f10df4d2d6ad39c9 (master)
commit 8fcfe1d449a64e1ce61e361dc593ff52293b41f2 (release/2.4)
Author: Steffan Karger
Date:   Wed Aug 29 15:49:43 2018 +0200

     Fix memory leak after sighup

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <1535550583-21825-1-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17429.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


