Date: Fri, 5 Oct 2018 14:48:53 +0200 (CEST)
Message-Id: <201810051248.w95Cmrbx041930@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181005123938.25649-1-steffan@...1856...>
References: <20181005123938.25649-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: travis: add OpenSSL 1.1 Windows
 build
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks.  As we figured out, we miss testing openssl 1.0 <-> 1.1 for the
windows builds - no we do, and the test results nicely show the "1.0 only"
breakage before Arne's fix that just went in.

Your patch has been applied to the master and release/2.4 branch.

commit a29b60c9577a7ea1302cd761645234a174a7e3cb (master)
commit b8d8e492604b5691c66178605b6c5362f98f6c9d (release/2.4)
Author: Steffan Karger
Date:   Fri Oct 5 14:39:38 2018 +0200

     travis: add OpenSSL 1.1 Windows build

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20181005123938.25649-1-steffan@...1856...>
     URL: https://www.mail-archive.com/search?l=mid&q=20181005123938.25649-1-steffan@...1856...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


