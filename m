Date: Thu, 20 Jan 2022 15:32:22 +0100 (CET)
Message-Id: <202201201432.20KEWMRw096411@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211214165928.30676-6-selva.nair@...277...>
References: <20211214165928.30676-6-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Initialize the xkey provider
 and use it in SSL context
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

This is the first truly "interesting" patch in the series, that brings
stuff to be tested :-)

Tested on OSSL 1.1.1 and mbedTLS builds ("so nothing breaks with the
old stuff"), and on 3.0.1 - but only with regular keys, so no
"key_is_external() = true" yet.

Your patch has been applied to the master branch.

commit 4b85c488ecadb3c076bc6cb605e00653cef67c94
Author: Selva Nair
Date:   Tue Dec 14 11:59:15 2021 -0500

     Initialize the xkey provider and use it in SSL context

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20211214165928.30676-6-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23432.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


