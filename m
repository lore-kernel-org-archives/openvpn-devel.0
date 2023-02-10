Date: Fri, 10 Feb 2023 21:59:14 +0100 (CET)
Message-Id: <202302102059.31AKxEB3032986@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230208001819.244694-5-arne@...1227...>
References: <20230208001819.244694-5-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add missing stdint.h includes
 in unit tests files
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

Tested with cmocka on linux and AIX ("nothing more exotic than that").

Nothing breaks.

.. and if cmocka docs tell us "this is the thing", then it is :-)

Your patch has been applied to the master and release/2.6 branch.

commit e80720ef9399d7a4e3469cf1004d064643e0f4dd (master)
commit 1b06696efb069ff9dfc77bac6cb487de232938cc (release/2.6)
Author: Arne Schwabe
Date:   Wed Feb 8 01:18:18 2023 +0100

     Add missing stdint.h includes in unit tests files

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20230208001819.244694-5-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26182.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


