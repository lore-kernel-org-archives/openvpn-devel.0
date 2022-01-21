Date: Fri, 21 Jan 2022 13:30:18 +0100 (CET)
Message-Id: <202201211230.20LCUIm2032281@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220117094917.178-1-lstipakov@...277...>
References: <20220117094917.178-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun: remove tun_finalize()
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

Test compiled with MinGW.  Not runtime tested.

Adjusted the prototype to be in-one-line, as instructed.  And have 
ignored the other nits :-)

Your patch has been applied to the master branch.

commit bcf04b0b8e3c0f142ab0ec97627ea140c80c7962
Author: Lev Stipakov
Date:   Mon Jan 17 11:49:17 2022 +0200

     tun: remove tun_finalize()

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20220117094917.178-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23555.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


