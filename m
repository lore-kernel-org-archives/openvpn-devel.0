Date: Tue, 17 Jun 2025 11:18:24 +0200 (CEST)
Message-Id: <202506170918.55H9IOUs038812@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250617084136.10215-1-gert@...1296...>
References: <20250617084136.10215-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Preserve socket protocol during
 float processing
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
To: Ralf Lici <ralf@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Explanation is very reasonable - good catch, "just adding a field to
the mroute" was far less trivial than the original patch made us assume.

Since it has an +2 from Giaan I have not further tested it, just stared
a bit at the change and it makes sense.  The server test framework does
not currently test floating, which is unfortunately and I really need
to address this (but it's somewhat tricky to get right with the t_client
framework).

mail-archive.com is not cooperating (it seems to categorize all the patches
I relay from gerrit to the list as "spam" - the mails from gerrit itself 
are there but the patch I sent is not...?) - so I recorded the gerrit URL
and the initial patch submission URL instead.

Your patch has been applied to the master branch.

commit db9632f7f976a5e0b810d76173a38f76879d99c0
Author: Ralf Lici
Date:   Tue Jun 17 10:41:28 2025 +0200

     Preserve socket protocol during float processing

     Signed-off-by: Ralf Lici <ralf@...2726...>
     Acked-by: Gianmarco De Gregori <gianmarco@...2726...>
     Message-Id: <20250617084136.10215-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31902.html
     URL: https://gerrit.openvpn.net/c/openvpn/+/1063
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


