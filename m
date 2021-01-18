Date: Mon, 18 Jan 2021 20:16:10 +0100 (CET)
Message-Id: <202101181916.10IJGAQY052965@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201215173004.26170-1-domagoj@...2540...>
References: <20201215173004.26170-1-domagoj@...2540...>
Subject: [Openvpn-devel] [PATCH applied] Re: Skip DHCP renew with Wintun
 adapter
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
To: Domagoj Pensa <domagoj@...2540...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.5 branch.

I've not tested it in any way, but looked at "git show -w", and this
this makes it quite clear that the patch does not actually change
as much code as it looks like, just moves the whole "dhcp_masq_post"
code block into the "if (WINDOWS_DRIVER_TAP_WINDOWS6)" block - so,
for TAP6, nothing changes, and for wintun, the code is not reached.

commit e0e7625c6b15f85b81d4f11d02f3daf4f32f1200 (master)
commit b8f4ca323969c13b039f35e5792a35f3e903b28c (release/2.5)
Author: Domagoj Pensa
Date:   Tue Dec 15 18:30:04 2020 +0100

     Skip DHCP renew with Wintun adapter

     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20201215173004.26170-1-domagoj@...2540...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21364.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


