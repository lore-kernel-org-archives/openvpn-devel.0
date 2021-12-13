Date: Mon, 13 Dec 2021 22:23:42 +0100 (CET)
Message-Id: <202112132123.1BDLNgT7098070@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211201180727.2496903-9-arne@...1227...>
References: <20211201180727.2496903-9-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Initialise kt_cipher even when
 no crypto is enabled
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

I do not see the immediate benefit, but the commit message points toward
future simplification - so it falls under "always init everything
avoids special cases later", which is good :-)

I do not have a test case for this right now (TLS with --cipher none
does not excercise this code path), so I couldn't *really* test it - 
running openvpn / p2p without --secret does yield the correct warning 
(lots of them), does not crash, and sends nice encapsulated but unecrypted
packets over the wire...

2021-12-13 22:20:09 DEPRECATION: No tls-client or tls-server option in configuration detected. OpenVPN 2.7 will remove the functionality to run a VPN without TLS. See the examples section in the manual page for examples of a similar quick setup with peer-fingerprint.
2021-12-13 22:20:09 ******* WARNING *******: '--cipher none' was specified. This means NO encryption will be performed and tunnelled data WILL be transmitted in clear text over the network! PLEASE DO RECONSIDER THIS SETTING!
2021-12-13 22:20:09 ******* WARNING *******: '--auth none' was specified. This means no authentication will be performed on received packets, meaning you CANNOT trust that the data received by the remote side have NOT been manipulated. PLEASE DO RECONSIDER THIS SETTING!
2021-12-13 22:20:09 ******* WARNING *******: All encryption and authentication features disabled -- All data will be tunnelled as clear text and will not be protected against man-in-the-middle changes. PLEASE DO RECONSIDER THIS CONFIGURATION!

maybe this is overdoing it just so slightly, and we should set "warn"
to "false" here...?  But anyway, I assume that this will go away soonish
anyway.

Your patch has been applied to the master branch.

commit 02d8f792893965a653e6bc99e039e169ad70bef9
Author: Arne Schwabe
Date:   Wed Dec 1 19:07:27 2021 +0100

     Initialise kt_cipher even when no crypto is enabled

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211201180727.2496903-9-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23272.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


