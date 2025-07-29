Date: Tue, 29 Jul 2025 16:56:54 +0200 (CEST)
Message-Id: <202507291456.56TEusYD004215@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250729093857.37832-1-kprovost@...2661...>
References: <20250729093857.37832-1-kprovost@...2661...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-freebsd: pass address scope
 to the kernel
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
To: Kristof Provost <kp@...1376...>
Cc: openvpn-devel@lists.sourceforge.net

I have tested that this does not break on kernels that do not have scope
support (as discussed on the list).  Good :-) - float notifications also
still work fine (unsurprisingly).

Need to setup a testbed with client and server on the same LAN, and
then test DCO with link-local addresses, scope, and floating...

Your patch has been applied to the master branch.

commit b5e0032bf09afa928d9728051599a5e738ff4d10
Author: Kristof Provost
Date:   Tue Jul 29 11:38:57 2025 +0200

     dco-freebsd: pass address scope to the kernel

     Signed-off-by: Kristof Provost <kprovost@...2661...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250729093857.37832-1-kprovost@...2661...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32401.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


