Date: Wed, 24 Sep 2025 16:57:46 +0200 (CEST)
Message-Id: <202509241457.58OEvk1U077223@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250924082121.23139-1-gert@...1296...>
References: <20250924082121.23139-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: ps: Fix conversion warnings
 related to send/recv return values
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

.. and out goes the next #ifdef block.

Tested on the t_server testbed that has an HTTP port-share instance
("still works", and everything else as well).

Your patch has been applied to the master branch.

commit 26a4cd686275252fc27fa21deedc58a310e864d9
Author: Frank Lichtenheld
Date:   Wed Sep 24 10:21:15 2025 +0200

     ps: Fix conversion warnings related to send/recv return values

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1194
     Message-Id: <20250924082121.23139-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59237926/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


