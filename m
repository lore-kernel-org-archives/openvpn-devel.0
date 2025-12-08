Date: Mon, 8 Dec 2025 22:36:23 +0100 (CET)
Message-Id: <202512082136.5B8LaNvY027600@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251208194151.17419-1-gert@...1296...>
References: <20251208194151.17419-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure: Try to use
 pkg-config to detect mbedTLS
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

This is a straightforward cherrypick from the corresponding master patch
(c829f57096cb6951aa4698eff388aeebf9310334), affects only building with
mbedtls, and improves library detection by means of pkgconf.

This is backported *now* because a few buildbot workers were reinstalled
with mbedtls3, relying on openvpn build to pick up everything via
pkgconf, and now the 2.6 builds are failing there -> fixing builds.

No actual code change.

Your patch has been applied to the release/2.6 branch.

commit 40420d43a95d4b837188f8345f3f2583e105b23f
Author: Frank Lichtenheld
Date:   Mon Dec 8 20:41:46 2025 +0100

     configure: Try to use pkg-config to detect mbedTLS

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
     Message-Id: <20240906160510.76387-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29090.html
     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1422
     Message-Id: <20251208194151.17419-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34911.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


