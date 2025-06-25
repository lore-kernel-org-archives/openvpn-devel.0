Date: Wed, 25 Jun 2025 18:49:29 +0200 (CEST)
Message-Id: <202506251649.55PGnT6n041354@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250625162638.7769-1-gert@...1296...>
References: <20250625162638.7769-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco linux: avoid sending local
 port to ovpn
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
To: Ralf Lici <ralf@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

I have tested this on Linux + DCO "client side" (which should not excercise
this code path at all, so "no change") and have set up a server instance
that has "--multihome" in the config - and as expected, the current code
fails

2025-06-25 18:37:44 us=736543 freebsd-74-amd64/udp6:194.97.140.3:51620 peer-id=0 Cannot add peer to DCO for freebsd-74-amd64/udp6:194.97.140.3:51620 peer-id=0: Numerical result out of range (-34)

.. and the fixed code succeeds.  Well spotted... (I do have a --multihome
server instance somewhere, but not "with DCO", meh - now I have one).

Your patch has been applied to the master branch.

commit 6c2bd6be4f8ac4f0b25aa05e2d5eb9bf6b736cd1
Author: Ralf Lici
Date:   Wed Jun 25 18:26:31 2025 +0200

     dco linux: avoid sending local port to ovpn

     Signed-off-by: Ralf Lici <ralf@...2726...>
     Acked-by: Antonio Quartulli <antonio@...2726...>
     Message-Id: <20250625162638.7769-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31971.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


