Date: Thu, 26 Jun 2025 11:26:20 +0200 (CEST)
Message-Id: <202506260926.55Q9QKTc075076@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250626091959.23505-1-gert@...1296...>
References: <20250626091959.23505-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: fix macOS dns-updown handling
 of parallel full redirects
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

I have just stared a bit at the code ("looks reasonable"), thanks to
Arne for confirming that it fixes the observed problem ("two VPN
connections active at the same time, both trying to redirect all DNS
queries").  Basically this will do nothing but print an error for the
second VPN to come up - and there is not much else we can do in this
scenario.

Your patch has been applied to the master branch.

commit 7a2b814fee06ab1edeb5f9ad104880f0fef5b0ba
Author: Heiko Hund
Date:   Thu Jun 26 11:19:52 2025 +0200

     fix macOS dns-updown handling of parallel full redirects

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20250626091959.23505-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31988.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


