Date: Thu, 2 Feb 2023 09:56:04 +0100 (CET)
Message-Id: <202302020856.3128u49S034425@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230201170735.2266851-1-selva.nair@...277...>
References: <20230201170735.2266851-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: block-dns using iservice: fix a
 potential double free
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

I've stared a bit at the code, and it looks good.  Also, MinGW and GH
compile it just fine ;-) - did not test actual installation.

Your patch has been applied to the master and release/2.6 branch.

commit b761cb9bc942b6077f0b6e2b85a72e33fc618a0f (master)
commit a85257e78f0d9f922941ad981bc4272d0aaf5594 (release/2.6)
Author: Selva Nair
Date:   Wed Feb 1 12:07:35 2023 -0500

     block-dns using iservice: fix a potential double free

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20230201170735.2266851-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26130.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


