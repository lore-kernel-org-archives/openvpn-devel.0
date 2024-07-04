Date: Thu, 4 Jul 2024 08:11:10 +0200 (CEST)
Message-Id: <202407040611.4646BA2M069441@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240703174158.7137-1-gert@...1296...>
References: <20240703174158.7137-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: mbedtls: Warn if
 --tls-version-min is too low
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

Thanks for that.  This fixes my server test rig, which sets --tls-version-min
to accept connections from very old clients - it will now (still) fail old
clients that can not do TLS 1.2 (namely, OpenVPN 2.2(!) - 2.3 and up are
fine), but it will not fail "everything else" as the current code did.

Your patch has been applied to the master branch.

commit c535fa7afe45937bbc7dda435b2b05e57f7ecd53 (master)
Author: Max Fillinger
Date:   Wed Jul 3 19:41:58 2024 +0200

     mbedtls: Warn if --tls-version-min is too low

     Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20240703174158.7137-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28865.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


