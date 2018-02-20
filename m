Date: Tue, 20 Feb 2018 08:48:19 +0100 (CET)
Message-Id: <201802200748.w1K7mJ4E036313@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1518788739-16610-1-git-send-email-steffan.karger@...1435...>
References: <1518788739-16610-1-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix format errors when
 cross-compiling for Windows
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the release/2.4 branch.

Note: the code in master looks subtly different here - also using %lld
for tv.tv_sec, but using %ld / (long) for tv.tv_usec so the patch does not
directly apply.  Since Selva is working on fixing all these for good, I've
decided to take the easy way and only apply this patch to 2.4 - which it
very much looks like it's intended for :-)

commit 9ba36639abcac4367c8227d2dd87b18fb56267c4 (release/2.4)
Author: Steffan Karger
Date:   Fri Feb 16 14:45:39 2018 +0100

     Fix format errors when cross-compiling for Windows

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <1518788739-16610-1-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16478.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


