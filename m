From: "Robin G. Wenninger" <robin@...152...>
Message-ID: <20040112203825.GA5857@...152...>
Mime-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 1.5.0 -> write UDPv4 []: No buffer space available
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Jan 12 12:39:01 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi List,

I'm not sure about if this is a real bug, but:

Since OpenVPN 1.5.0 I notice this in my log-files:

<snip>
Jan 12 16:55:14 hefti openvpn[20762]: write UDPv4 []: No buffer space
available (code=105)
Jan 12 16:56:04 hefti last message repeated 4 times
Jan 12 16:56:21 hefti last message repeated 3 times

(the same with "ping -s 1000 -f")
Jan 12 21:18:46 hefti last message repeated 976 times
<snap> ...and so on

First I thought it might be a Kernel problem, but I get these error
under 2.4.20, 2.4.23, 2.6.1 and also this happens only since OVPN
1.5.0.

It's very easy to reproduce if you try something like
"ping -s 1000" or even "ping -s 1000 -f" over the tunnel. However I 
don't assume that this has a major effect to the throughput but I'm 
wondering about this message.

-> Maybe it's important that I have a xDSL on each side.
-> OpenVPN 1.5.0 i386-pc-linux-gnu [SSL] [LZO] [PTHREAD]

It you need further information to track down this problem, tell me and
don't be too angry if I did something wrong - it's my first Bug-Report.
;)

Best regards rw

