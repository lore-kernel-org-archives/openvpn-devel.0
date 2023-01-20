Date: Fri, 20 Jan 2023 18:28:02 +0100 (CET)
Message-Id: <202301201728.30KHS2ME033726@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230120021841.2048791-1-selva.nair@...277...>
References: <20230120021841.2048791-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Warn when pkcs11-id or
 pkcs11-id-management options are ignored
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

As I do not have a working pkcs11-anything environment (still :( ), I have
not tested this beyond "looks reasonable" and "compiles on github".

Your patch has been applied to the master and release/2.6 branch.

commit abad04fc8ef6c1da7dc4e976bacee9f34931adea (master)
commit f42b38a68e7a9b44153021a7c3864618e3864cae (release/2.6)
Author: Selva Nair
Date:   Thu Jan 19 21:18:41 2023 -0500

     Warn when pkcs11-id or pkcs11-id-management options are ignored

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20230120021841.2048791-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26056.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


