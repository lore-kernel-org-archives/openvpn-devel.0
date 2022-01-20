Date: Thu, 20 Jan 2022 16:18:06 +0100 (CET)
Message-Id: <202201201518.20KFI6r4000355@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211214165928.30676-8-selva.nair@...277...>
References: <20211214165928.30676-8-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Enable signing via provider for
 management-external-key
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

Compile and client tested on 1.1.1 and 3.0.1.

Glancing at the code related to management_external_key() does
not make me very happy... too many build time variants.  

Maybe we should look into "external key is only supported with 
OpenSSL 3.0.1+ builds" for 2.7 and get rid of all the #ifdef'ed 
code there...

Your patch has been applied to the master branch.

commit 199df03bf57339661a853cb764ea41a0c8349b95
Author: Selva Nair
Date:   Tue Dec 14 11:59:17 2021 -0500

     Enable signing via provider for management-external-key

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20211214165928.30676-8-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23428.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


