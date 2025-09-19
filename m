Date: Fri, 19 Sep 2025 18:42:40 +0200 (CEST)
Message-Id: <202509191642.58JGgesp033634@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250919154040.17684-1-gert@...1296...>
References: <20250919154040.17684-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: socket: Change resolve flags to
 unsigned int
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

Straightforward, stared a bit at the code, and BB confirms that nothing
breaks...  (not that our test rig is excercising these party really hard).

Your patch has been applied to the master branch.

commit 5b7fde23af6e06c90a56100e4bec91132617e327
Author: Frank Lichtenheld
Date:   Fri Sep 19 17:40:34 2025 +0200

     socket: Change resolve flags to unsigned int

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1131
     Message-Id: <20250919154040.17684-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33098.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


