Date: Mon, 12 Dec 2022 09:32:27 +0100 (CET)
Message-Id: <202212120832.2BC8WRCc048871@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221210134427.1433419-1-arne@...1227...>
References: <20221210134427.1433419-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Disable DCO when TLS mode is
 not used
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

Yeah, thanks :-) (tested on the "p2p --secret" server, still does the
right thing.  Have no "no secrets at all" setup, but from stare-at-code
I see no reason why this wouldn't work as well)

Dec 12 09:29:15 ubuntu2004 tun-udp-p2p[1272956]: No tls-client or tls-server option in configuration detected. Disabling data channel offload.
Dec 12 09:29:15 ubuntu2004 tun-udp-p2p[1272956]: DEPRECATION: No tls-client or tls-server option in configuration detected. OpenVPN 2.7 will remove the functionality to run a VPN without TLS. See the examples section in the manual page for examples of a similar quick setup with peer-fingerprint.
..
Dec 12 09:29:15 ubuntu2004 tun-udp-p2p[1272957]: TUN/TAP device tun5 opened


Your patch has been applied to the master and release/2.6 branch.

commit a666668f064c7ff57cdebb3afceb72e1263a3ba9 (master)
commit 9b277f426c7d295c8f354496e8e226fc26ff7b1c (release/2.6)
Author: Arne Schwabe
Date:   Sat Dec 10 14:44:27 2022 +0100

     Disable DCO when TLS mode is not used

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221210134427.1433419-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25641.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


