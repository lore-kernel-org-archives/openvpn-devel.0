Date: Mon, 19 Dec 2022 17:51:25 +0100 (CET)
Message-Id: <202212191651.2BJGpPOP093811@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221219150435.1222451-1-selva.nair@...277...>
References: <20221219150435.1222451-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Reduce default restart pause to
 1 second
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

Admittedly, I have not tested this, but it's simple enough - code wise,
not the "fighting .rst" part :-)

Your patch has been applied to the master and release/2.6 branch.

commit cb385c64279fcb11bf6622d9723e1223b4e2a7f5 (master)
commit 3a5d82d7fee8fc7d00902e9640494ea6fdd08b35 (release/2.6)
Author: Selva Nair
Date:   Mon Dec 19 10:04:35 2022 -0500

     Reduce default restart pause to 1 second

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20221219150435.1222451-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25770.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


