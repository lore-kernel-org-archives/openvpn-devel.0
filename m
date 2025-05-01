Date: Thu, 1 May 2025 13:15:53 +0200 (CEST)
Message-Id: <202505011115.541BFrhk012449@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250429154923.20921-1-gert@...1296...>
References: <20250429154923.20921-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix MBEDTLS_DEPRECATED_REMOVED
 build errors
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
To: "rein.vanbaaren" <rein.vanbaaren@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for the backport.  This is important long-term compat material.

I have not tested this beyond "buildbots build against various mbedTLS
versions, and with the latest version, this all succeeds and t_client
tests pass".  Staring at the diff confirms it's the backport of commit
8eb397de36564 + code sections for older mbedTLS versions.

Your patch has been applied to the release/2.6 branch.

commit 0169b4ad2bb35d2cc5f0c35db4775f182646127b
Author: rein.vanbaaren
Date:   Tue Apr 29 17:49:18 2025 +0200

     Fix MBEDTLS_DEPRECATED_REMOVED build errors

     Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20240618120127.4564-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28771.html
     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250429154923.20921-1-gert@...1296...>
     URL: https://www.mail-archive.com/search?l=mid&q=20250429154923.20921-1-gert@...1296...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


