Date: Wed, 26 Nov 2025 12:01:05 +0100 (CET)
Message-Id: <202511261101.5AQB15dU025167@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251126103427.4085-1-gert@...1296...>
References: <20251126103427.4085-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: iservice: fix calculation of
 converted domains size
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

Stared long and hard at the code.  Found lots of "this cannot work, really?"
staring at it, that are all getting fixed in additional single-line patches
later on - this is not a useful patch granularity, sending 8 patches to
fix like 6 single-line bugs.  Reviewing and testing something where the
starting code is broken to no end and a single patch will not bring it 
into a correct state is not a good use of my time.

This said, this single-line change (plus a bit of movearound in preparation
for the next patch) does what it says, calculate "converted_size"
correctly, in bytes ("_len" in glyphs, "_size" = in bytes).

Your patch has been applied to the master branch.

commit ac6c9d65701ed6d41691497846a47cb4e72b2878
Author: Heiko Hund
Date:   Wed Nov 26 11:34:21 2025 +0100

     iservice: fix calculation of converted domains size

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1390
     Message-Id: <20251126103427.4085-1-gert@...1296...>
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


