Date: Thu, 14 Jul 2022 20:49:30 +0200 (CEST)
Message-Id: <202207141849.26EInURC029964@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220630190549.16675-1-selva.nair@...277...>
References: <20220630190549.16675-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Log the actual management
 interface port in use
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

This looks like a useful addition, and it actually works :-)

$ openvpn --verb 4 --dev tun --management :: 0 --management-hold
..
2022-07-14 20:43:01 us=644866 setsockopt(IPV6_V6ONLY=0)
2022-07-14 20:43:01 us=644907 MANAGEMENT: TCP Socket listening on [AF_INET6][undef]:59291
2022-07-14 20:43:01 us=644918 Need hold release from management interface, waiting...

of course it also works for legacy IP...

2022-07-14 20:43:39 us=245584 MANAGEMENT: TCP Socket listening on [AF_INET]127.0.0.1:63545

Tested on FreeBSD and on OpenSolaris (because that's always the oddball
"it is a real unix, but more pain than the rest" OS).

Your patch has been applied to the master branch.

commit 298f3bedbc42578d39055990669f7dda0f787d68
Author: Selva Nair
Date:   Thu Jun 30 15:05:47 2022 -0400

     Log the actual management interface port in use

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220630190549.16675-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24617.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


