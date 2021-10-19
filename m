Date: Tue, 19 Oct 2021 11:41:34 +0200 (CEST)
Message-Id: <202110190941.19J9fYfi084620@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211015184733.16988-1-selva.nair@...277...>
References: <20211015184733.16988-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix some more wrong defines in
 config-msvc.h
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

Thanks.

I have adjusted the commit message ("should fix Trac #1430") and removed
the #define ENABLE_DEBUG 0, as instructed.

Your patch has been applied to the release/2.5 branch.

commit c699c0d85cf2028796cdb0592271f1167709e6ac
Author: Selva Nair
Date:   Fri Oct 15 14:47:33 2021 -0400

     Fix some more wrong defines in config-msvc.h

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20211015184733.16988-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22943.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


