Date: Sun, 25 Dec 2022 18:14:36 +0100 (CET)
Message-Id: <202212251714.2BPHEakD064251@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221224194253.3202231-6-arne@...1227...>
References: <20221224194253.3202231-6-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Also drop incoming dco packet
 content when dropping the packet
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

I'm not sure if my gremlins have ever seen this particular problem, but
it seems yours have been more active :-)

Stare-at-code confirms that "buf_init()" is the way we clear dco_packet_in
in the existing code paths, "if a packet has been consumed", and doing so
in these two places ("we do not want any packet, go away") sounds like the
right thing to do (otherwise dco_linux::ovpn_handle_msg() will get very
upset trying to read the next incoming message).

Tested on the Linux/DCO test rig, client+server.  FreeBSD never sends
data packets via the DCO interface, and Windows does not even have this
structure element.

Your patch has been applied to the master and release/2.6 branch.

commit 7433618cb4bea017ae7c360da42093f49cf014b4 (master)
commit 474fe4df7d04de0eaa4cfe48b06497008275451a (release/2.6)
Author: Arne Schwabe
Date:   Sat Dec 24 20:42:49 2022 +0100

     Also drop incoming dco packet content when dropping the packet

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221224194253.3202231-6-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25797.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


