Date: Mon, 22 Aug 2022 20:48:11 +0200 (CEST)
Message-Id: <202208221848.27MImBMO012920@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220811120722.29168-2-maximilian.fillinger@...2507...>
References: <20220811120722.29168-2-maximilian.fillinger@...2507...>
Subject: [Openvpn-devel] [PATCH applied] Re: Handle EVP_MD_CTX as an opaque
 struct
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
To: Max Fillinger <maximilian.fillinger@...2507...>
Cc: openvpn-devel@lists.sourceforge.net

Same as for the previous patch, I have not tested this on a recent-enough
OpenBSD or OpenSSL 1.0.x (no time to build or find such a system) but I
have tested on FreeBSD with 1.1.1l and 3.0.3 - both OpenSSL builds still
work fine and pass client side tests.

Arne says this does not apply cleanly to 2.5, so if we want it there,
please send a (tested :-) ) backport.

Your patch has been applied to the master branch.

commit 5a9d5dbf5c2d0fc979a05c84afd05689f2ad99b0
Author: Max Fillinger
Date:   Thu Aug 11 14:07:22 2022 +0200

     Handle EVP_MD_CTX as an opaque struct

     Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20220811120722.29168-2-maximilian.fillinger@...2507...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24873.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


