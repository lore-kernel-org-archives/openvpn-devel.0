Date: Mon, 3 Nov 2025 14:14:05 +0100 (CET)
Message-Id: <202511031314.5A3DE5TI001871@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251103115552.6201-1-gert@...1296...>
References: <20251103115552.6201-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: manage: Correctly handle port
 65535 in man_kill
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

Trivial fix - and we should have fixed that on the original patch, but
due to time constraints around 2.7_rc1 release it did not work out.

Your patch has been applied to the master branch.

commit 40b29347c05e969dc2d23223a426ce652b123589
Author: Frank Lichtenheld
Date:   Mon Nov 3 12:55:46 2025 +0100

     manage: Correctly handle port 65535 in man_kill

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1341
     Message-Id: <20251103115552.6201-1-gert@...1296...>
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


