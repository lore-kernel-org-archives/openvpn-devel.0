Date: Tue, 2 Aug 2022 13:54:55 +0200 (CEST)
Message-Id: <202208021154.272Bst2x070837@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220728034508.15180-1-selva.nair@...277...>
References: <20220728034508.15180-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Do not skip ERROR:/SUCCESS:
 response from management interface
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

I'm not sure I understand what is happening here, exactly, but since
Arne understands management way better and ACKed this - in it goes :)
(it *looks* harmless enough).

Since I understand this to be a bugfix, applied to 2.5 as well.

Your patch has been applied to the master and release/2.5 branch.

commit 579b78e22feab7fe7cc627355cbb270cd91aebb4 (master)
commit e3c397b0edd86158b8c417f6d396920a7e2eae68 (release/2.5)
Author: Selva Nair
Date:   Wed Jul 27 23:45:07 2022 -0400

     Do not skip ERROR:/SUCCESS: response from management interface

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20220728034508.15180-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24750.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


