Date: Wed, 28 Apr 2021 15:29:55 +0200 (CEST)
Message-Id: <202104281329.13SDTt0v028376@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210422151724.2132573-2-arne@...1227...>
References: <20210422151724.2132573-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use functions to access
 key_state instead direct member access
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

Looked a bit at the code, not sure if's really easier to read, or
just an "looks unfamiliar" effect.  But it works in my tests, not
very surprisingly :-)

Your patch has been applied to the master branch.

commit a80bec331ec65efbbec1adb7892e242589c238ef
Author: Arne Schwabe
Date:   Thu Apr 22 17:17:19 2021 +0200

     Use functions to access key_state instead direct member access

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210422151724.2132573-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22200.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


