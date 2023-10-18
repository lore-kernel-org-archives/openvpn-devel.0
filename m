Date: Wed, 18 Oct 2023 17:10:23 +0200 (CEST)
Message-Id: <202310181510.39IFANNo072053@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231006111910.3541180-1-arne@...1227...>
References: <20231006111910.3541180-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove openssl engine method
 for loading the key
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

Turns out it compiles just fine across all platforms, and I must have
gotten confused by a parallel build (by gerrit...) triggering errors
that looked related to "SSL things", assuming it must have been
this patch... 

Manually tested it on OpenBSD 6.8 with LibreSSL, and via GH/buildbot
on all the rest of the zoo.

Your patch has been applied to the master and release/2.6 branch.

commit e7427bcbb9b16b52d81c65b01d440a8ecd1e6ea7 (master)
commit 8bbc2926e620bcf995e6697e614a2716b572c07d (release/2.6)
Author: Arne Schwabe
Date:   Fri Oct 6 13:19:10 2023 +0200

     Remove openssl engine method for loading the key

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20231006111910.3541180-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27133.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


