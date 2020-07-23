Date: Thu, 23 Jul 2020 19:03:16 +0200 (CEST)
Message-Id: <202007231703.06NH3GwU038376@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200723155937.1867-1-arne@...1227...>
References: <20200723155937.1867-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Deprecate --inetd
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

I think I am the only one currently using --inetd, and I only
use it on my test server rig because I was curious on whether
it still works.  It does (after some code fixes, back then),
but it is very limited in what it can do, and complicates
the socket.c code quite a bit.  Out with it!

Added Changes.rst entry.

Your patch has been applied to the master branch.

commit 25a422cc60c609cc6927a3fb26bf1fb506dda828
Author: Arne Schwabe
Date:   Thu Jul 23 17:59:37 2020 +0200

     Deprecate --inetd

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200723155937.1867-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20554.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


