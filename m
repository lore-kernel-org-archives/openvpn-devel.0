Date: Thu, 20 Jan 2022 17:58:07 +0100 (CET)
Message-Id: <202201201658.20KGw7BS007381@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211214165928.30676-14-selva.nair@...277...>
References: <20211214165928.30676-14-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add a generic key loading
 helper function for xkey provider
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

I knew fixing that "avaiable" typo would come back and bite me :-)

Client tested with 3.0.1, and glanced at the code a bit.

Fixed a comment typo ("callng free_op").

Your patch has been applied to the master branch.

commit b64c9eb31824dd46c949d071751f8aebc008004c
Author: Selva Nair
Date:   Tue Dec 14 11:59:23 2021 -0500

     Add a generic key loading helper function for xkey provider

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20211214165928.30676-14-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23436.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


