Date: Thu, 3 Feb 2022 13:35:42 +0100 (CET)
Message-Id: <202202031235.213CZgMW068001@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220101162532.2251835-9-arne@...1227...>
References: <20220101162532.2251835-9-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove link_mtu parameter when
 running up/down scripts
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

"Because it makes sense".  Client-side and server-side tested (I do not
have any scripts that look at link_mtu, I have other scripts that might
be upset).  Code change is simple enough.

For reference, this was 16/21 in v1 of the series, and got a NAK 
for "missing update to script-options.rst".  This is still not in, 
so we agreed on IRC this morning that I'll do the missing text 
adjustments, which I have done.

Your patch has been applied to the master branch.

commit 3780ce0e16c2cd06e77357a30df3c43595c98cab (master)
Author: Arne Schwabe
Date:   Sat Jan 1 17:25:26 2022 +0100

     Remove link_mtu parameter when running up/down scripts

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220101162532.2251835-9-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23493.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


