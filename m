Date: Mon, 13 Oct 2025 18:02:23 +0200 (CEST)
Message-Id: <202510131602.59DG2NMN083066@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251013154758.21695-1-gert@...1296...>
References: <20251013154758.21695-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: test_dhcp: Start a dhcp helper
 functions UT
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

UTs are welcome, it passes all the tests on all platforms now, so in it
goes ;-) - the extra #ifdef is unavoidable, as we normally don't build
the code tested here on non-WIN32 platforms...

Your patch has been applied to the master branch.

commit d78ebd4b8c11e3fb2ed8ceac56d955d7a9dffb13
Author: Frank Lichtenheld
Date:   Mon Oct 13 17:47:53 2025 +0200

     test_dhcp: Start a dhcp helper functions UT

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1267
     Message-Id: <20251013154758.21695-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59246199/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


