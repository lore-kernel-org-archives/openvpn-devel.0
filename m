Date: Wed, 4 Mar 2026 11:43:33 +0100 (CET)
Message-Id: <202603041043.624AhXYC057148@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260216162236.22304-1-gert@...1296...>
References: <20260216162236.22304-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Merge stream_buf_get_next and
 stream_buf_set_next
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

So I managed to reproduce the original crash (--dev-tap --ifconfig-noexec,
and then kill the socket), and can confirm that the patch fixes that.

I have also run this through the full client/server test bed, to verify
that it's not breaking anything else in the process.  Looks good
(the patch looks bigger than it actually is, because "sb->next" is
now "next" and that changes all lines in stream_buf_get_next() without
a "real" change).

I have simplified the instructions in the commit message - it's not 
necessary to have a special server config, just "any TAP+TCP server"
will do, with "--ifconfig-noexec" on the client side.

Your patch has been applied to the master & release/2.7 branch.

Backporting to 2.6 has not been done as the bug is considered too exotic
to be a "real problem" in general (it's day 1 bug, so we *could* backport
it all the way back to 2.2.x ;-) ).

commit 5e85c3491fcf75f1a006d410d1a2a7720c2d3f09 (master)
commit 4d6cf3dcb821e281fdede8a989b50b9c1a2255c2 (release/2.7)
Author: Arne Schwabe
Date:   Mon Feb 16 17:22:31 2026 +0100

     Merge stream_buf_get_next and stream_buf_set_next

     Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1477
     Message-Id: <20260216162236.22304-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35673.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


