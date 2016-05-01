Date: Sun, 1 May 2016 22:29:23 +0200 (CEST)
Message-Id: <201605012029.u41KTNr6089848@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1462126986-2686-1-git-send-email-steffan@...1856...>
References: <1462126986-2686-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure.ac: link to all mbed
	TLS libs during library detection
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

ACK.  Tested on ubuntu 14.04 with "default Makefile"-installed mbedtls 
(it works if you have cmake build your Makefile first...)

Your patch has been applied to the master branch.

gmane archive lookup is broken right now, so no URL: below - but the
message ID is there.

commit e860059baa912ced7acf00f9b1e85a3d80dc0b1f
Author: Steffan Karger
Date:   Sun May 1 20:23:06 2016 +0200

     configure.ac: link to all mbed TLS libs during library detection

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1462126986-2686-1-git-send-email-steffan@...1856...>
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


