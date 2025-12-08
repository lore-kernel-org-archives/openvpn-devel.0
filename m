Date: Mon, 8 Dec 2025 20:29:49 +0100 (CET)
Message-Id: <202512081929.5B8JTnAq023330@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251208170937.5221-1-gert@...1296...>
References: <20251208170937.5221-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: GHA: Add minGW Release build
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

Tested, does what is intended - trigger the error we saw on the "release
builder" machine also in regular GH Actions, so we do not get as much
surprise next time.

Your patch has been applied to the master branch.

commit 55a5e2051f97b885c6fca9a6e030a48e81328c05
Author: Frank Lichtenheld
Date:   Mon Dec 8 18:09:32 2025 +0100

     GHA: Add minGW Release build

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1421
     Message-Id: <20251208170937.5221-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34896.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


