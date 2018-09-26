Date: Wed, 26 Sep 2018 12:23:56 +0200 (CEST)
Message-Id: <201809261023.w8QANuTE046106@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1536916459-25900-3-git-send-email-steffan.karger@...1435...>
References: <1536916459-25900-3-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: mbedtls: remove dependency on
 mbedtls pkcs11 module
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

Cursory review, way too much crypto / too little time for me to say 
"I understand the changes".  But nothing that looks obviously erroneous.

Trusting Arne, Steffan and my t_client tests on this :-)

Your patch has been applied to the master branch.

commit 03c8bfc90fbc63007f62d3ed165942d149225551
Author: Steffan Karger
Date:   Fri Sep 14 11:14:19 2018 +0200

     mbedtls: remove dependency on mbedtls pkcs11 module

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <1536916459-25900-3-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17463.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


