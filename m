Date: Thu, 27 Nov 2025 12:14:25 +0100 (CET)
Message-Id: <202511271114.5ARBEPNt074754@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251127105125.30457-1-gert@...1296...>
References: <20251127105125.30457-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Linux: Assume we have a kernel
 that was release in the last 15 years
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

Thanks for the cleanup.

I have tested this on a gentoo system (rolling release, so fairly recent),
and BB has tested this across our zoo of linux distributions and museums,
and things still work and test fine.  I have verified that --mktun still
works, and that --mark still shows up in --help (so these conditionals are
fine).

Also I've tested that the extended error handling still works:

  2025-11-27 12:13:17 write UDPv4 [EMSGSIZE Path-MTU=1500]: Message too long (fd=3,code=90)

Your patch has been applied to the master branch.

commit 2abfb759d6d52b41d61e5aadbb0915f4084e28e6
Author: Frank Lichtenheld
Date:   Thu Nov 27 11:51:20 2025 +0100

     Linux: Assume we have a kernel that was release in the last 15 years

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1408
     Message-Id: <20251127105125.30457-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34738.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


