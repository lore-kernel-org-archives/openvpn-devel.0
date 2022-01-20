Date: Thu, 20 Jan 2022 17:26:21 +0100 (CET)
Message-Id: <202201201626.20KGQLTN003269@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211214165928.30676-12-selva.nair@...277...>
References: <20211214165928.30676-12-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Support sending DigestSign
 request to management client
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

Compile-tested on 3.0.1 and stared at the code for a bit.  The "global"
change is trivial enough, the xkey_helper changes look safe wrt memory
overflows etc, though I lack the greater understanding on how all 
the wheels work together (so it's good that Arne tested and ACKed this).

Your patch has been applied to the master branch.

commit 0f6781fa3639d05ce1afb83a45c3bb12c6f97f1b
Author: Selva Nair
Date:   Tue Dec 14 11:59:21 2021 -0500

     Support sending DigestSign request to management client

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20211214165928.30676-12-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23435.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


