Date: Tue, 2 Sep 2025 18:12:48 +0200 (CEST)
Message-Id: <202509021612.582GCm6h069716@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250902160050.18640-1-gert@...1296...>
References: <20250902160050.18640-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: management: resync timer on
 bytecount interval change
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

I have tested this on client and server, including lots of extra msg()
printing to verify that "the arg that we think should be a multi* or
context* pointer" indeed is what we expect.

v4 was good to go, but it crashes the server if --management-hold is
active and "bytecount 1" is issued (tun not open yet, so parts of the
management infra are not initalized yet - in particular *.callback.arg)

So, v5 is the same as v3, just having an if() clause there.  ASSERT()
for "can't happen" will tell you what you overlooked ;-)

As for the commit before that, mail-archive.org refuses to acknowledge
existence of the "patch on the list!" mail, so sourceforge.net is 
linked.

Your patch has been applied to the master branch.

commit 3bc0b2d0aea742640a1acf97fc4b41726b88ce96
Author: Ralf Lici
Date:   Tue Sep 2 18:00:44 2025 +0200

     management: resync timer on bytecount interval change

     Signed-off-by: Ralf Lici <ralf@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250902160050.18640-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59228306/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


