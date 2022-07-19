Date: Tue, 19 Jul 2022 11:40:30 +0200 (CEST)
Message-Id: <202207190940.26J9eUgK034316@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220718221923.2033-1-a@...2181...>
References: <20220718221923.2033-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: allow user to disable it
 at runtime
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

This does not really *do* much yet, but now you can do an --enable-dco
build, and suppress the "no kernel support!! ey!" message with --disable-dco
again ;-) - also, a build will now show [DCO] on --version

As agreed on IRC, rewrapped the p2p message ("table" on a separate line).

Your patch has been applied to the master branch.

commit 7a4c75927109acc2cd455140db312042781a3949
Author: Antonio Quartulli
Date:   Tue Jul 19 00:19:23 2022 +0200

     dco: allow user to disable it at runtime

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220718221923.2033-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24702.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


