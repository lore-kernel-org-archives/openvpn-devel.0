Date: Fri, 27 Dec 2024 18:37:19 +0100 (CET)
Message-Id: <202412271737.4BRHbJTj024874@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241227161755.4010-1-gert@...1296...>
References: <20241227161755.4010-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: override ai_family if 'local'
 numeric address was specified
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

This does change semantics of "local <address>" or "remote <address>",
but in a useful way.  The old code would just fail on

  proto udp4
  remote 2001:db8::1

because it tried to force-resolve the v6 address as "proto v4" (and vice
versa):

2024-12-24 13:24:18 RESOLVE: Cannot resolve host address: 2001:db8::1:51194 (Name does not resolve)
2024-12-24 13:25:01 RESOLVE: Cannot resolve host address: 199.102.77.82:51194 (Name does not resolve)

The new code will basically change "proto udp4" to "udp6" if a numeric v6
address is seen (and vice versa).

This has a small risk for unforeseen breakage (configs that have v4+v6
connection entries in them, and purposely selecting one or the other 
using "proto udp4/udp6"), but I'm willing to accept that - if we really
need that use case (instead of just letting the transport layer decide if
v4 or v6 succeeds) we might enhance `--proto-force` to also serve as a
v4/v6 switch.  Or introduce -4/-6.

Tested client-side with the "mismatched" combinations, and subjected to
the full client/server side tests - which uncovered a unforeseen surprise
in v7 (instead of a dual-stack socket for "ANY", I only got v4 sockets)
- this has been addressed in v9, and my zoo behaves "as before".


Your patch has been applied to the master branch.

commit 8b209d9e5d80799eec931e2fec9b15f7e2c1a7b0
Author: Antonio Quartulli
Date:   Fri Dec 27 17:17:55 2024 +0100

     override ai_family if 'local' numeric address was specified

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20241227161755.4010-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30257.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


