Date: Wed, 26 Jan 2022 14:26:46 +0100 (CET)
Message-Id: <202201261326.20QDQkif058192@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220125025128.2117-3-selva.nair@...277...>
References: <20220125025128.2117-3-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Support PSS signing using
 pkcs11-helper >= 1.28
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

I'm not claiming to understand any of this... so I have test compiled
on Linux/3.0.1, and also bumped my MinGW test rig to pkcs11-helper 1.28
(though only 1.1.1 yet).  So maybe I tested something useful, or maybe
not... but at least these combinations still compile fine :-)

Your patch has been applied to the master branch.

commit 15ba808503113f685d254e9007b8e9937e01532d
Author: Selva Nair
Date:   Mon Jan 24 21:51:28 2022 -0500

     Support PSS signing using pkcs11-helper >= 1.28

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20220125025128.2117-3-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23647.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


