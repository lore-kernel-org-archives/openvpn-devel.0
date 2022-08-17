Date: Wed, 17 Aug 2022 16:54:54 +0200 (CEST)
Message-Id: <202208171454.27HEss7C040907@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220817075925.815184-1-arne@...1227...>
References: <20220817075925.815184-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Rename OPT_P_IPWIN32 to
 OPT_P_DHCPDNS and include --dns in it
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

Acked-by: Gert Doering <gert@...1296...>

Looks like a reasonable change (so, feature-ACK), and stare-at-code
agrees.

Basically, this renames OPT_P_IPWIN32 to OPT_P_DHCPDNS and mechanically 
changes this in all the code, adds "DNS" to the --route-nopull help text,
and changes the "dns" permissions from DEFAULT to DHCPDNS - which is
the only "real" code change.

I do not have a working windows build environment right now, so I pushed
to my GH repo and let GHA build this - which is all green, so I didn't
overlook anything.

Your patch has been applied to the master branch.

commit 8a7d0005860d2227c8d0e63ee73131e8188b7c18
Author: Arne Schwabe
Date:   Wed Aug 17 09:59:25 2022 +0200

     Rename OPT_P_IPWIN32 to OPT_P_DHCPDNS and include --dns in it

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220817075925.815184-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24946.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


