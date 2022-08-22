Date: Mon, 22 Aug 2022 20:47:58 +0200 (CEST)
Message-Id: <202208221847.27MIlwEH012890@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220822154037.44320-1-maximilian.fillinger@...2507...>
References: <20220822154037.44320-1-maximilian.fillinger@...2507...>
Subject: [Openvpn-devel] [PATCH applied] Re: Update openssl_compat.h for
 newer LibreSSL
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
To: Max Fillinger <maximilian.fillinger@...2507...>
Cc: openvpn-devel@lists.sourceforge.net

I have not tested this on a recent-enough OpenBSD or OpenSSL 1.0.x 
(no time to build or find such a system) but I have tested on FreeBSD
with 1.1.1l - unsurprisingly (the #ifdef say so) no difference.

I'm a bit unsure if we need this for 2.5 - it's "long term compat" 
and not very intrusive, but on the other hand, not too many people
seem to care about LibreSSL.

Your patch has been applied to the master branch.

commit 6d9695de9fd125cced72b531559c2bdf0c4e0966
Author: Max Fillinger
Date:   Mon Aug 22 17:40:37 2022 +0200

     Update openssl_compat.h for newer LibreSSL

     Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20220822154037.44320-1-maximilian.fillinger@...2507...>
     URL: https://www.mail-archive.com/search?l=mid&q=20220822154037.44320-1-maximilian.fillinger@...2507...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


