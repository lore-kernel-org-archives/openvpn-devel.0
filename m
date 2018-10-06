Date: Sat, 6 Oct 2018 07:44:59 +0200 (CEST)
Message-Id: <201810060544.w965ixI7049889@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1538784495-24988-1-git-send-email-selva.nair@...277...>
References: <1538784495-24988-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Pass the hash without the
 DigestInfo header to NCryptSignHash()
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

Acked-by: Gert Doering <gert@...1296...>

Thanks, Selva, for checking what was missing (nothing but context) :-) - I
wasn't feeling familiar enough with the code to check myself yesterday, 
and the large conflict "git cherrypick" created misled me.

I have verified that the patch itself contains the code same changes, just
line numbers and context are different ("diff -u master.patch 24.patch"),
so I cherrypick Steffan's ACK to the master patch and add my own.

Test built on ubuntu1604 with openssl 1.0.1* (so verifying yesterday's 
openssl 1.1-compat patch in 2.4 as well).

Your patch has been applied to the release/2.4 branch.

commit 163fa9c1e79bddc07c7dd47e8c313016b482314f (release/2.4)
Author: Selva Nair
Date:   Fri Oct 5 20:08:15 2018 -0400

     Pass the hash without the DigestInfo header to NCryptSignHash()

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1538784495-24988-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17579.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


