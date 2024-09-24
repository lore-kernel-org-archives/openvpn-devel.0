Date: Tue, 24 Sep 2024 14:59:07 +0200 (CEST)
Message-Id: <202409241259.48OCx7kN082876@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240924124328.3037-1-gert@...1296...>
References: <20240924124328.3037-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Change dev null to be a driver
 type instead of a special mode of tun/tap
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

This is just basic refactoring, making future work on special-case
hacks like "--dev null" or "af_unix" more streamlined.  No functional
change expected or seen.

The change to tun.c looks huge but is mostly re-indenting after
getting rid of the DEV_TYPE_NULL condition (-> git show -w)
in open_tun_generic(), and also moving the check from all the
open_tun() to open_tun_backend().

As with the previous patch, unwrapped the "offload".

Your patch has been applied to the master branch.

commit 8fe14fea935d6c2591649353eb7daf4977585b03
Author: Arne Schwabe
Date:   Tue Sep 24 14:43:28 2024 +0200

     Change dev null to be a driver type instead of a special mode of tun/tap

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240924124328.3037-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29384.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


