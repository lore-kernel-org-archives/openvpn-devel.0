Date: Tue, 24 Sep 2024 15:27:05 +0200 (CEST)
Message-Id: <202409241327.48ODR59j090332@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240924131437.22294-1-gert@...1296...>
References: <20240924131437.22294-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Automatically enable
 ifconfig-exec/route-exec behaviour for afunix tun/tap
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

This is basically just a convenience, to avoid having to explicitly add
--ifconfig-noexec --route-noexec to the options whenever using --dev null
or --dev-node af_unix: ("because there is no device to be configured"),
and as such does not change anything for all other cases.

Your patch has been applied to the master branch.

commit 5c4a0b71abecf1ccfff4c2ddadf0db9818b40f36
Author: Arne Schwabe
Date:   Tue Sep 24 15:14:37 2024 +0200

     Automatically enable ifconfig-exec/route-exec behaviour for afunix tun/tap

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240924131437.22294-1-gert@...1296...>
     URL: https://www.mail-archive.com/search?l=mid&q=20240924131437.22294-1-gert@...1296...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


