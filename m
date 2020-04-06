Date: Mon, 6 Apr 2020 17:45:30 +0200 (CEST)
Message-Id: <202004061545.036FjUBp035549@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200403090944.17726-1-arne@...1227...>
References: <20200403090944.17726-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix off-by-one in tls-crypt-v2
 client wrapping with custom metadata
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

Your patch has been applied to the master branch.

While a bugfix, the code in question is not in release/2.4, so no need
to backport.

No real testing done, just a quick test compile.

commit e23fb6b8c88a2aec160965769f6467d455c0d010 (master)
Author: Arne Schwabe
Date:   Fri Apr 3 11:09:44 2020 +0200

     Fix off-by-one in tls-crypt-v2 client wrapping with custom metadata

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <20200403090944.17726-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19695.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


