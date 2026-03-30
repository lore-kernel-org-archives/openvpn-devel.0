Date: Mon, 30 Mar 2026 14:50:20 +0200 (CEST)
Message-Id: <202603301250.62UCoKrw037572@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260303142819.6123-1-gert@...1296...>
References: <20260303142819.6123-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add an optional username-only
 flag for auth-user-pass
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

Sorry for being slow here.  Busy times...

This said, I have not tested this for real - this is a much larger task
coming up, building a proper test rig that tests the gazillion of auth
options we have in a proper way...  - staring at the code, the change
makes sense, support can be queried from the GUI, so everything should
work out nicely.

Tests on the client/server testbeds pass fine, so "nothing else got
broken, and basic --auth-user-pass $file still works".

Since 2.7 will be with us for a long time, and we're still in the very
low release numbers, I think having this in release/2.7 "fairly localized
change, low impact on high-risk areas of the code" is ok.

Your patch has been applied to the master and release/2.7 branch.

commit dfbf80b0a04a986fc5b5d5fef67d86ce68439b0b (master)
commit 96781b42f2b9ecf28ace4fbe97ac868477eef480 (release/2.7)
Author: Selva Nair
Date:   Tue Mar 3 15:28:14 2026 +0100

     Add an optional username-only flag for auth-user-pass

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1548
     Message-Id: <20260303142819.6123-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35855.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


