Date: Thu, 28 Nov 2024 16:04:46 +0100 (CET)
Message-Id: <202411281504.4ASF4kti068679@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241128142708.14665-1-gert@...1296...>
References: <20241128142708.14665-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: macOS: Assume that
 net/if_utun.h is always present
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

This is, basically, a "stare at code and do build test via GHA" patch
- which succeeds.  It came out of a discussion on brackets in #821,
and getting rid of an #ifdef is always good ;-)

Your patch has been applied to the master branch.

As discussed on IRC, part of the change was an "uncrustify does funny
things" uncalled-for change.  I have moved the closing */ to its own
line, which appeases uncrustify and leaves the comment alone.

commit cb878882388bfe9dc49b116190c5c6ae8918322d
Author: Frank Lichtenheld
Date:   Thu Nov 28 15:27:08 2024 +0100

     macOS: Assume that net/if_utun.h is always present

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20241128142708.14665-1-gert@...1296...>
     URL: https://www.mail-archive.com/search?l=mid&q=20241128142708.14665-1-gert@...1296...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


