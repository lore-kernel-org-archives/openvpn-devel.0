Date: Tue, 11 Nov 2025 19:45:14 +0100 (CET)
Message-Id: <202511111845.5ABIjEe0097252@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251111154846.31360-1-gert@...1296...>
References: <20251111154846.31360-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Enable -Wtype-limits by default
 (via -Wextra)
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

Stared at it, complained about SOCKET_UNDEFINED, read up sysdefs.h...

Thrown at GHA, got aborts due to macOS 13 brownouting...

Not "smooth sailing" day, but still, in it goes.

Your patch has been applied to the master branch.

commit 5d50583bf853b62c0362a45a9ea1b085516bdd4e
Author: Frank Lichtenheld
Date:   Tue Nov 11 16:48:39 2025 +0100

     Enable -Wtype-limits by default (via -Wextra)

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1207
     Message-Id: <20251111154846.31360-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34317.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


