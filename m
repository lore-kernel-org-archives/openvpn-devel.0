Date: Wed, 27 Aug 2025 11:25:19 +0200 (CEST)
Message-Id: <202508270925.57R9PJO6099156@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250826184935.22110-1-gert@...1296...>
References: <20250826184935.22110-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: crypto: Make sure crypto flags
 are treated as unsigned
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Another one that is fairly "failsave" - the integer ranges of the flags
are all much smaller than "signs might be critical" and they are 
stored in an unsigned int, so unsigned they go (but I'm happy that Arne
looked more deeply).

Your patch has been applied to the master branch.

commit 98dbc8fdb593f204a3ca75753e9b39bd28c01cf8
Author: Frank Lichtenheld
Date:   Tue Aug 26 20:49:29 2025 +0200

     crypto: Make sure crypto flags are treated as unsigned

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20250826184935.22110-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32688.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


