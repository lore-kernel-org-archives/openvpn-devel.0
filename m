Date: Mon, 17 Nov 2025 08:44:06 +0100 (CET)
Message-Id: <202511170744.5AH7i6fc080435@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251030145231.2792-1-gert@...1296...>
References: <20251030145231.2792-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl: Clean up type handling in
 export_user_keying_material()
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

This is another one that had the +2 already 3 weeks ago, but needed the
prerequisite patches to be mergeable.

Stared at the code, changes make sense, passes compile tests on FreeBSD.

Your patch has been applied to the master branch.

commit fc00a3c92c5bd34c1f3a1cd8680fd12571f2b674
Author: Frank Lichtenheld
Date:   Thu Oct 30 15:52:26 2025 +0100

     ssl: Clean up type handling in export_user_keying_material()

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1301
     Message-Id: <20251030145231.2792-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34036.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


