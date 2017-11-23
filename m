Date: Thu, 23 Nov 2017 08:15:42 +0100 (CET)
Message-Id: <201711230715.vAN7FgQe021255@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <8760a6kjwc.fsf@...2274...>
References: <8760a6kjwc.fsf@...2274...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix build with LibreSSL
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
To: Jeremie Courreges-Anglas <jca@...2272...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks.  Tested on OpenBSD 6.0, fixes compilation again.

Your patch has been applied to the master and release/2.4 branch.

commit 88a827f25cb4a79f06597ca438f8f04d37a03d4e (master)
commit eac1e089239999a161d81e0222d461c8b580a776 (release/2.4)
Author: Jeremie Courreges-Anglas
Date:   Sun Nov 19 22:57:56 2017 +0100

     Fix build with LibreSSL

     Signed-off-by: Jeremie Courreges-Anglas <jca@...2272...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <8760a6kjwc.fsf@...2274...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15902.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


