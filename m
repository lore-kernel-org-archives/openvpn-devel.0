Date: Tue, 28 Oct 2025 10:23:31 +0100 (CET)
Message-Id: <202510280923.59S9NV0R094813@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251027212747.4161-1-gert@...1296...>
References: <20251027212747.4161-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: pkcs11_management_id_get: Free
 certificate object after use
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

I have not reviewed/tested this beyond "BB compiles things, unit tests
(including pkcs11 on some of the instances) work".  Stare-at-code looks
very trivially correct.

Your patch has been applied to the master branch.

commit 87f639c820b8365585fc825ee7ea9cdd86cf88c5
Author: Selva Nair
Date:   Mon Oct 27 22:27:41 2025 +0100

     pkcs11_management_id_get: Free certificate object after use

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1317
     Message-Id: <20251027212747.4161-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33908.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


