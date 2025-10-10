Date: Fri, 10 Oct 2025 09:16:33 +0200 (CEST)
Message-Id: <202510100716.59A7GXMZ073039@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251010063934.18197-1-gert@...1296...>
References: <20251010063934.18197-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix PIN cache time in
 test_pkcs11.c
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for the quick fix.  I have not tested this, but the explanation
makes sense (and all BBs are fine, though that could be Frank's "let's
just retry this particular test if it fails" change).

Your patch has been applied to the master branch.

commit f9bfd1c405f86617ace2f63ff29f1a4099b6920b
Author: Selva Nair
Date:   Fri Oct 10 08:39:27 2025 +0200

     Fix PIN cache time in test_pkcs11.c

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1263
     Message-Id: <20251010063934.18197-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33306.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


