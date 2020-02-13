Date: Thu, 13 Feb 2020 20:44:14 +0100 (CET)
Message-Id: <202002131944.01DJiE8W090404@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200213095539.11157-1-lstipakov@...277...>
References: <20200213095539.11157-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: cryptoapi.c: fix run-time check
 failure in msvc debugger
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

Your patch has been applied to the master branch.

(No testing done, but this is syntactically correct and does what it
says on the tin)

commit e84f430f8487cf42304fe29fd8746a91309b08d0
Author: Lev Stipakov
Date:   Thu Feb 13 11:55:39 2020 +0200

     cryptoapi.c: fix run-time check failure in msvc debugger

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20200213095539.11157-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19410.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


