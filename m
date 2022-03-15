Date: Tue, 15 Mar 2022 19:47:14 +0100 (CET)
Message-Id: <202203151847.22FIlEF2017381@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220315155344.37787-3-openvpn@...2080...>
References: <20220315155344.37787-3-openvpn@...2080...>
Subject: [Openvpn-devel] [PATCH applied] Re: plug-ins: Disallow multiple
 deferred authentication plug-ins
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

I have not done formal testing, just verified that the code change is
the same and that it compiles.  The "plugin.c" module did change quite
a bit since 2.4 (PF removal, argv overhaul, ENABLE_CRYPTO, etc.) but 
the code patched here - plugin_call_ssl() - is identical.

Your patch has been applied to the release/2.4 branch.

commit 58ec3bb4aac77131118dbbc39a65181e7847adee
Author: David Sommerseth
Date:   Tue Mar 15 16:53:43 2022 +0100

     plug-ins: Disallow multiple deferred authentication plug-ins

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220315155344.37787-3-openvpn@...2080...>
     URL: https://www.mail-archive.com/search?l=mid&q=20220315155344.37787-3-openvpn@...2080...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


