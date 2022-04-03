Date: Sun, 3 Apr 2022 16:45:32 +0200 (CEST)
Message-Id: <202204031445.233EjWxX069601@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220402070902.30282-2-a@...2181...>
References: <20220402070902.30282-2-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: networking: remove duplicate
 methods from networking_sitnl.c
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

Trivial enough.  Compile-tested with sitnl and --enable-iproute2.

Your patch has been applied to the master branch.

commit c0fa37eda2a12c6587e9b2db2c0a33c91d3ced6e
Author: Arne Schwabe
Date:   Sat Apr 2 09:08:56 2022 +0200

     networking: remove duplicate methods from networking_sitnl.c

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220402070902.30282-2-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24054.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


