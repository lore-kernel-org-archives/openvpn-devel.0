Date: Wed, 30 Jul 2025 20:15:13 +0200 (CEST)
Message-Id: <202507301815.56UIFDWV057507@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250730180527.25339-1-gert@...1296...>
References: <20250730180527.25339-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix broken DHCP options
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks.  I've ran into this myself with 2.7_alpha2 and a setup that 
ended up doing DHCP on TAP, so thanks for the fix :-)

I have not tested it beyond "does it compile", but looking at the code
flow and finding tt->options.dhcp_options in tun.c, this is "obviously
correct".  The dance with the helper variable is unavoidable due to
the platform-dependent nature of the options.c code here... ("or you
get 3 extra #ifdefs").

Your patch has been applied to the master branch.

commit 040e0d1c308a587ae9a26295eeaa070561befa0d
Author: Lev Stipakov
Date:   Wed Jul 30 20:04:26 2025 +0200

     Fix broken DHCP options

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250730180527.25339-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32427.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


