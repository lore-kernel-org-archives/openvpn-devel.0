Date: Fri, 31 Dec 2021 12:13:41 +0100 (CET)
Message-Id: <202112311113.1BVBDfRC001414@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211230172136.2017215-1-arne@...1227...>
References: <20211230172136.2017215-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Rework occ link-mtu calculation
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Code looks reasonably, and comes with an extensive test suite - so I
did not test "does it configure the same link-mtu for all possible
combinations as the code before that".  I did test some basic stuff
(TLS/BF-CBC/SHA1, TLS/AES-256-GCM, TLS/none/none) and it did produce
"different values".  BF-CBC matched what the server wanted, with the
same config.

I have left out the hunk that adds "option.h" to test_misc.c - that
looks stray, no change to that test otherwise (maybe it's needed in
a later patch, then I'll notice and re-add it).  test_crypto.c also
has this added, and *there* it's definitely needed :-)

As mentioned on IRC, we're losing a few msg(D_MTU_DEBUG, ...) in this 
process - do we want to bring them back at some point?

Your patch has been applied to the master branch.

commit 01b7cd44669896d91696e936cc38a2f57bc6081e
Author: Arne Schwabe
Date:   Thu Dec 30 18:21:36 2021 +0100

     Rework occ link-mtu calculation

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211230172136.2017215-1-arne@...1227...>
     URL: https://www.mail-archive.com/search?l=mid&q=20211230172136.2017215-1-arne@...1227...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


