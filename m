Date: Thu, 12 Sep 2024 16:30:11 +0200 (CEST)
Message-Id: <202409121430.48CEUBiV016370@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240912142421.703-1-gert@...1296...>
References: <20240912142421.703-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun: removed unnecessary route
 installations
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
To: Marco Baffo <marco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for this.  I'm not sure why this code was there originally, but
I guess one of the BSDs needed it ("15 years ago!") and I just assumed
the others would, too.  I have tested this on NetBSD, OpenBSD and
MacOS, with all variants I thought might make a difference (tun/p2p,
tun/subnet, tun/subnet with a non-/64 IPv6 mask, tap) and it turns out
that this extra route is needed on none of them.

MacOS has no easily accessible TAP anymore (system security, kext loading)
so this was not tested - but I see no reason why it would break this.

.. and testing this really trivial patch took me about 2 days of
fighting with VMs, macOS, buildbots, ... *sigh*

Your patch has been applied to the master branch.

commit 992da812ad56d2cff44fd4f171dd85c808e1ed50
Author: Marco Baffo
Date:   Thu Sep 12 16:24:21 2024 +0200

     tun: removed unnecessary route installations

     Signed-off-by: Marco Baffo <marco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240912142421.703-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29217.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


