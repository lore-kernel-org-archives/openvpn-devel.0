Date: Wed, 24 Feb 2021 08:16:33 +0100 (CET)
Message-Id: <202102240716.11O7GX5m036055@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1613520275-28637-1-git-send-email-selva.nair@...277...>
References: <1613520275-28637-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Quote the domain name argument
 passed to the wmic command
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

From reading the ticket, this seems like a necessary change.  I have not
tested this, just looked at the code change, which is trivial enough.

Your patch has been applied to the master and release/2.5 branch.

commit 3338f2d5a2b7f12f314cc53bf0eaa44ba4f2e58c (master)
commit 2c8ef6fd2abbaef2e8c458690be545c171e11afe (release/2.5)
Author: Selva Nair
Date:   Tue Feb 16 19:04:35 2021 -0500

     Quote the domain name argument passed to the wmic command

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1613520275-28637-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21570.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


