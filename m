Date: Sun, 11 Jun 2017 13:48:48 +0200 (CEST)
Message-Id: <201706111148.v5BBmmVn038597@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <87fuf7u455.fsf@...2274...>
References: <87fuf7u455.fsf@...2274...>
Subject: [Openvpn-devel] [PATCH applied] Re: Missing include for
 socket-flags TCP_NODELAY on OpenBSD
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
To: jca@...2272...
Cc: openvpn-devel@lists.sourceforge.net

ACK, thanks.

(While I'm not exactly happy with the mess we have in syshead.h, this
is not your fault - you just happen to add the 6th identical chunk...)

Applying this to all branches to fix the bug, putting "rework syshead.h
for master, to clean up the zillion nearly-identical blocks" on my TODO
list.

Your patch has been applied to the master, release/2.4 and release/2.3 branch.

commit e5b236eaba4512f86da917a0a63dd0f84e1b02db (master)
commit fc6b630e8b2f2c3ec2a18b3791f419d99c9fefb1 (release/2.4)
commit 464ac6ea10751093741c8fb3d32b5eea10e1a533 (release/2.3)
Author: Jérémie Courrèges-Anglas
Date:   Sat Jun 10 19:31:21 2017 +0200

     Missing include for socket-flags TCP_NODELAY on OpenBSD

     Signed-off-by: Jeremie Courreges-Anglas <jca@...2272...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <87fuf7u455.fsf@...2274...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14772.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


