Date: Thu, 14 Oct 2021 16:31:08 +0200 (CEST)
Message-Id: <202110141431.19EEV8ul059968@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211013230227.199-1-lstipakov@...277...>
References: <20211013230227.199-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: msvc: fix product version
 display
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

"makes sense"

Your patch has been applied to the master and release/2.5 branch.

(As a side note, why do we have PACKAGE_VERSION and PRODUCT_VERSION there
that seem to be totally identical, but each one defined individually?)

commit 23143667ff3368694191a57fea29b41d25c4b135 (master)
commit d6a9bf5d77451571b8d4ba83f5a80f5e16f9174b (release/2.5)
Author: Lev Stipakov
Date:   Thu Oct 14 02:02:27 2021 +0300

     msvc: fix product version display

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211013230227.199-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22931.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


