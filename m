Date: Wed, 4 Jan 2017 08:35:38 +0100 (CET)
Message-Id: <201701040735.v047ZcSB057648@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <9d41f9dd-a587-5c1e-2e0d-ebb6c921f4ae@...2101...>
References: <9d41f9dd-a587-5c1e-2e0d-ebb6c921f4ae@...2101...>
Subject: [Openvpn-devel] [PATCH applied] Re: Crash in options.c
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
To: Gisle Vanem <gvanem@...2101...>
Cc: openvpn-devel@lists.sourceforge.net

ACK, thanks.  Tested, fixes the issue, tracked to the offending commit
(5d429efd97).

Your patch has been applied to the master and release/2.4 branch.

Release/2.3 does not contain the offending code.

commit 49629380a7bdba25c24c9d410b79946fe29249f0 (master)
commit 6650911256b2e636b4a2d754cfe60e949f213f91 (release/2.4)
Author: Gisle Vanem
Date:   Mon Jan 2 17:17:51 2017 +0100

     Crash in options.c

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <9d41f9dd-a587-5c1e-2e0d-ebb6c921f4ae@...2101...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13808.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


