Date: Wed, 15 Mar 2023 22:28:45 +0100 (CET)
Message-Id: <202303152128.32FLSjUL054268@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230315195512.323070-1-arne@...1227...>
References: <20230315195512.323070-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix memory leaks in HMAC
 initial packet id
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

Stared at the code, and the current version looks good - the change
is now bigger than "just add a free_buf()", but since that did not
work, the new approach of putting all buffers into the per-session
gc_arena should stop the leaking (it might use a bit more memory
while the session is active, because there are two bufs of 1600 bytes
each, but it will be returned afterwards << this is the good part)

The biggest part of this patch is the unit test anyway :-)

Subjected this to Github actions (which broke the previous two versions)
and to my server testbed (which broke v2).  All are happy now.

Your patch has been applied to the master and release/2.6 branch.

commit e8ecaadd2ac38f2c2d4bcd40eeaea7401aa737a1 (master)
commit 0942e1575abbc0bdda62e3158827b130ae3f9ab6 (release/2.6)
Author: Arne Schwabe
Date:   Wed Mar 15 20:55:12 2023 +0100

     Fix memory leaks in HMAC initial packet id

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230315195512.323070-1-arne@...1227...>
     URL: https://www.mail-archive.com/search?l=mid&q=20230315195512.323070-1-arne@...1227...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


