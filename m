Date: Tue, 18 Jun 2024 18:29:57 +0200 (CEST)
Message-Id: <202406181629.45IGTvIk098094@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240618120127.4564-1-gert@...1296...>
References: <20240618120127.4564-1-gert@...1296...>
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

Mildly tested via GHA compilation.  Not sure what option I need to
really trigger an "it would break without that patch" scenario so
not really tested that much.

Your patch has been applied to the master branch.

commit 8eb397de3656402872f9c9584c6f703b87b50762
Author: rein.vanbaaren
Date:   Tue Jun 18 14:01:26 2024 +0200

     Fix MBEDTLS_DEPRECATED_REMOVED build errors

     Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20240618120127.4564-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28771.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


