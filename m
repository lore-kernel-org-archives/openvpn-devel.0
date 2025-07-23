Date: Wed, 23 Jul 2025 18:16:32 +0200 (CEST)
Message-Id: <202507231616.56NGGWc8031351@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250723153224.13708-1-gert@...1296...>
References: <20250723153224.13708-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco_linux: factor out netlink
 notification code
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
To: Antonio Quartulli <antonio@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Stared long and hard on the changes (some of the ugly bits just move around,
and are not new in this patch).  Ran full client/server tests with Linux
DCO (passed).

Your patch has been applied to the master branch.

commit 0e0023fe48357150ef1c35b99451f6d3054e2c0b
Author: Antonio Quartulli
Date:   Wed Jul 23 17:32:19 2025 +0200

     dco_linux: factor out netlink notification code

     Signed-off-by: Antonio Quartulli <antonio@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250723153224.13708-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32298.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


