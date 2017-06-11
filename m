Date: Sun, 11 Jun 2017 13:13:05 +0200 (CEST)
Message-Id: <201706111113.v5BBD5nQ038238@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <87ink3vpcs.fsf@...2274...>
References: <87ink3vpcs.fsf@...2274...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix an unaligned access on
 OpenBSD/sparc64
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

ACK, thanks.  As discussed in great detail :-)

Smoke-tested on OpenBSD 6.0/amd64 (to ensure v4/v6 still work).

Note to self: clean up the different per-OS ways of doing the same
thing here.

Your patch has been applied to the master, release/2.4 and release/2.3
branch.

commit 3e4e300d6c5ea9c320e62def79e5b70f8e255248 (master)
commit 29ba477801998aff4e0ae7c1edc50b4ac9d145d9 (release/2.4)
commit 02845e8dc6bd5ee0be1b4a5616f9da90d6e38f4b (release/2.3)
Author: Jérémie Courrèges-Anglas
Date:   Sat Jun 10 16:48:44 2017 +0200

     Fix an unaligned access on OpenBSD/sparc64

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <87ink3vpcs.fsf@...2274...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14769.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


