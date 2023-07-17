Date: Mon, 17 Jul 2023 19:00:50 +0200 (CEST)
Message-Id: <202307171700.36HH0oD0091515@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230712094620.569273-1-arne@...1227...>
References: <20230712094620.569273-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Ignore Ipv6 route delete
 request on Android and set ipv4 verbosity to 7
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

"because it makes sense"

Not tested beyond stare-at-code and have GHA do a test build, because
this is all #ifdef TARGET_ANDROID, and "only msg() calls" at that.

Uncrustify complains about indentation, so whitespace adjusted accordingly.

Your patch has been applied to the master and release/2.6 branch (one
could argue that branch, but it's "fix a misleading error message" so
it qualifies as a mini bugfix).  Not applying to 2.5 or 2.4 :-)

commit ab01eaf49fa9341ff647206bd6e3017770cc0674 (master)
commit 4ed7d7f72515c7df34edf617cb0bb8f2ac533e48 (release/2.6)
Author: Arne Schwabe
Date:   Wed Jul 12 11:46:20 2023 +0200

     Ignore Ipv6 route delete request on Android and set ipv4 verbosity to 7

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230712094620.569273-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26848.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


