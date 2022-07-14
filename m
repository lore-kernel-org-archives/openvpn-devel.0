Date: Thu, 14 Jul 2022 20:30:11 +0200 (CEST)
Message-Id: <202207141830.26EIUB9k026753@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220707035151.25469-1-selva.nair@...277...>
References: <20220707035151.25469-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix crash in xkey-provider in
 msvc builds
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

Taking the agreement from Arne as formal ACK (checked on IRC).

I'm not sure I grok all the details of this, but I can attest that 
unit_tests/test_provider still works (on a 3.0.x build), and that calls
the "xkey_load_generic_key()" function being modified here.  So, this
is good.  Lev promised to verify MSVC builds early next week.

Your patch has been applied to the master branch.

commit 2b2e4d0ad5c3a309af8425be8e6e605975fb2a43
Author: Selva Nair
Date:   Wed Jul 6 23:51:51 2022 -0400

     Fix crash in xkey-provider in msvc builds

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20220707035151.25469-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24664.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


