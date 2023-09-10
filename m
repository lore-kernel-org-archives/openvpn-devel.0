Date: Sun, 10 Sep 2023 17:31:28 +0200 (CEST)
Message-Id: <202309101531.38AFVSE6058279@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230815231555.6465-1-a@...2181...>
References: <20230815231555.6465-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: fix crash when --multihome
 is used with --proto tcp
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

Code looks good.

Done a quick test on a Linux/DCO server, with TCP and --multihome.  Without
the patch:

2023-09-10 17:15:20 us=552871 freebsd-14-amd64/194.97.140.5:33293 MULTI: primary virtual IPv6 for freebsd-14-amd64/194.97.140.5:33293: fd00:abcd:220:1::1002
Segmentation fault (core dumped)

with the patch:

2023-09-10 17:16:57 us=590075 freebsd-14-amd64/194.97.140.5:41489 MULTI: primary virtual IPv6 for freebsd-14-amd64/194.97.140.5:41489: fd00:abcd:220:1::1002
2023-09-10 17:16:57 us=590252 freebsd-14-amd64/194.97.140.5:41489 Data Channel MTU parms [ mss_fix:1366 max_frag:0 tun_mtu:1500 tun_max_mtu:1600 headroom:136 payload:1768 tailroom:562 ET:0 ]
2023-09-10 17:16:57 us=590348 freebsd-14-amd64/194.97.140.5:41489 Outgoing dynamic tls-crypt: Cipher 'AES-256-CTR' initialized with 256 bit key
..

"and it just works".

Since the logic for "what do we need to do differently?" is the same
as for the non-DCO case now, I have not done more in-depth tests
(though I maybe *should* set up a server with multiple v4+v6 addresses
and run client tests against either one).


I have adjusted the github tag - our established format is

  Github: fixes OpenVPN/openvpn#390

not anything else.

Your patch has been applied to the master and release/2.6 branch (bugfix).

commit 0793eb105c5720c4eb31af71c9db81459439e510 (master)
commit 70ef43f2b9b938256e0f689f4ddba0d6fbb3a371 (release/2.6)
Author: Antonio Quartulli
Date:   Wed Aug 16 01:15:55 2023 +0200

     dco: fix crash when --multihome is used with --proto tcp

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230815231555.6465-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26953.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


