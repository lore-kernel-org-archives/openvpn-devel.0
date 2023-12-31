Date: Sun, 31 Dec 2023 19:12:30 +0100 (CET)
Message-Id: <202312311812.3BVICUiB003184@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231231173431.31356-1-gert@...1296...>
References: <20231231173431.31356-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix unaligned access in macOS,
 FreeBSD, Solaris hwaddr
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

There's still room for improvement in the comments, but the current version
might be as good as it gets this year... and I want to be able to push to
GHA again without UBSAN errors :-)

Tested this on NetBSD, OpenBSD, FreeBSD, MacOS and OpenSolaris, and found
lots of interesting things - but nothing that was made worse by *this*
patch, and the UBSAN build stopped complaining on MacOS... also, I've
stared long and hard at the code, and as long as we can trust the kernel,
every variant of short/long length should be covered.

Did I say that this is a shitty API that MacOS copied from FreeBSD, 
FreeBSD actually fixed it (by increasing the structure size a lot, so 
if the buffer is aligned, nothing will overrun and alignment will also
be fine), and MacOS just stuck with what they have...

A followup patch that implements HWADDR for OpenSolaris happened by
accident while testing this :-) - will be on the list soon.

Your patch has been applied to the master and release/2.6 branch (bugfix).

commit f13331005d5a75f2788685485d46be1fe2f133a1 (master)
commit 5380fe02b9ef4f0f2b1f0eb52100b7922965dfdb (release/2.6)
Author: Arne Schwabe
Date:   Sun Dec 31 18:34:31 2023 +0100

     Fix unaligned access in macOS, FreeBSD, Solaris hwaddr

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20231231173431.31356-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27885.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


