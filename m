Message-Id: <201908050933.x759XIuU001220@...2300...>
From: Casper.Dik@...2299...
In-Reply-To: <20190805092529.9467-2-a@...2181...> 
References: <20190805092529.9467-1-a@...2181...>
 <20190805092529.9467-2-a@...2181...> 
Mime-Version: 1.0
Date: Mon, 05 Aug 2019 11:33:18 +0200
Subject: Re: [Openvpn-devel] [PATCH 1/6] sitnl: harden strncpy() by forcing
 arguments to have the same length
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>



>For this reason, force both strings to use IFNAMSIZ as size and, since
>this constant may not exist on every platform, ensure it is always
>defined.

A problem with this patch misght be that strncpy() does NOT NUL terminates the
copied string.  (It writes EXACTLY IFNAMSIZ bytes but only when the string 
is shorter, it will writes NUL bytes in the reminder of the char array[].)

You could use strlcpy() but I'm not sure if that is available in Windows.


> 
>     /* save result in output variables */
>     memcpy(best_gw, &res.gw, res.addr_size);
-    strcpy(best_iface, res.iface);
>+    strncpy(best_iface, res.iface, IFNAMSIZ);

Casper


