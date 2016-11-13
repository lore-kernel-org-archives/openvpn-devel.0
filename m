Date: Sun, 13 Nov 2016 14:50:43 +0100 (CET)
Message-Id: <201611131350.uADDohOl005906@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1479043047-25883-1-git-send-email-steffan@...1856...>
References: <1479043047-25883-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Don't deference type-punned
	pointers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  Brilliant approach to "make the compiler happy" that is *increasing*
code readability, not making it worse.

Reviewed ("STARE AT CODE!"), client tests on linux and freebsd, server
tests on linux.

Your patch has been applied to the master branch.

commit 8cac9b98d58b97fbd5a23dd9f172a9843ecf5b50
Author: Steffan Karger
Date:   Sun Nov 13 14:17:27 2016 +0100

     Don't deference type-punned pointers

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1479043047-25883-1-git-send-email-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13017.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


