Date: Thu, 25 Mar 2021 12:32:33 +0100 (CET)
Message-Id: <202103251132.12PBWXKE007298@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210324222330.455-3-arne@...1227...>
References: <20210324222330.455-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix socket related functions
 using int instead of socket_descriptor_t
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

On non-windows, socket_descriptor_t is typedef'ed to "int", so this is
no "generated code change", just ensuring consistency in our types.  On
Windows, this is a "SOCKET", which might or might not fit into an int,
but is certainly not interchangeable.  So, makes sense.

Compile-tested on MinGW, lightly client-tested on FreeBSD and Linux.

Your patch has been applied to the master branch.

commit e756e12adb33e93f712281361ae61a1522d3df93
Author: Arne Schwabe
Date:   Wed Mar 24 23:23:29 2021 +0100

     Fix socket related functions using int instead of socket_descriptor_t

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210324222330.455-3-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21806.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


