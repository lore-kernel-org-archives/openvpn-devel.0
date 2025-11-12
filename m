Date: Wed, 12 Nov 2025 14:58:41 +0100 (CET)
Message-Id: <202511121358.5ACDwfPE042693@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251111153230.29865-1-gert@...1296...>
References: <20251111153230.29865-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: openssl_compat: Avoid
 conversion warning for SSL_get_negotiated_group
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

Patch looks reasonable, has an ACK from Arne, and BB is all green...

.. and one set of #pragma's gone, hooray.

Your patch has been applied to the master branch.

commit 4fa8539a088e490633e0f7114c21e03d61871dd6
Author: Frank Lichtenheld
Date:   Tue Nov 11 16:32:24 2025 +0100

     openssl_compat: Avoid conversion warning for SSL_get_negotiated_group

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1359
     Message-Id: <20251111153230.29865-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34316.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


