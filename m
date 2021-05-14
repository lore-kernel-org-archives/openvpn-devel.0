Date: Fri, 14 May 2021 14:08:13 +0200 (CEST)
Message-Id: <202105141208.14EC8DAF092461@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210512131511.1309914-3-arne@...1227...>
References: <20210512131511.1309914-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove getpeername, getpid check
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

"because it makes sense" (we discussed this on IRC, and I couldn't
find anything in my software museum that has no getpeername() - not
even SCO Unix! - and checking for getpid() borders on ridiculous...)

Stared-at-patch, test compiled on Linux.

Your patch has been applied to the master branch.

commit 84e14209232441fd6601d3efb7c7aa93bee4ce88
Author: Arne Schwabe
Date:   Wed May 12 15:15:04 2021 +0200

     Remove getpeername, getpid check

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210512131511.1309914-3-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22340.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


