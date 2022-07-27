Date: Wed, 27 Jul 2022 20:14:50 +0200 (CEST)
Message-Id: <202207271814.26RIEoDR045914@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220720123021.24281-1-a@...2181...>
References: <20220720123021.24281-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: initialize context and
 save pointer in TLS object
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

The change to init.c is easier viewed with "-w" - wrapping the existing
code to initialize the ping intervals into "if (!dco_enabled)".

The remainder does not really do much yet - introduce structure elements
and enums, but they are not used yet.  Also, record the ACK from Arne
on v1.

Tested on linux without --enable-dco (works), and with --enable-dco
but without kernel DCO (works as well).

Your patch has been applied to the master branch.

commit a2d851d4fa69792f2bcde568e43ec0879d757788
Author: Antonio Quartulli
Date:   Wed Jul 20 14:30:21 2022 +0200

     dco: initialize context and save pointer in TLS object

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-By: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220720123021.24281-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24714.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


