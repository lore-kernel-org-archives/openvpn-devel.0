Date: Sun, 16 Nov 2025 19:02:59 +0100 (CET)
Message-Id: <202511161802.5AGI2xKO050162@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251111155139.31642-1-gert@...1296...>
References: <20251111155139.31642-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: forward: Change
 context_reschedule_sec sec argument to time_t
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Stared-at-code, and test compiled on Linux and GHA (I +2'ed this last
week already, but it needed a prerequisite patch to otime.h).

Your patch has been applied to the master branch.

commit 7835c371c72b42a55a451356246733e32bdbdffa
Author: Frank Lichtenheld
Date:   Tue Nov 11 16:51:31 2025 +0100

     forward: Change context_reschedule_sec sec argument to time_t

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1356
     Message-Id: <20251111155139.31642-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34319.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


