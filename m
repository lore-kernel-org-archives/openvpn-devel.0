Message-ID: <40086293.4040005@...61...>
From: Julien TOUCHE <julien.touche@...61...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] No buffer space available (code=105)
References: <4002F85B.9010103@...61...>
In-Reply-To: <4002F85B.9010103@...61...>
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
Date: Fri Jan 16 14:15:01 2004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: openvpn-devel@lists.sourceforge.net

in fact, complete log show this:

Fri Jan 16 22:48:39 2004 40: Peer Connection Initiated with 
81.50.152.188:16883
Fri Jan 16 22:48:39 2004 41: Peer Connection Initiated with 10.0.1.26:16883
Fri Jan 16 22:48:39 2004 42: Peer Connection Initiated with 
81.50.152.188:16883
Fri Jan 16 22:48:39 2004 43: Peer Connection Initiated with 10.0.1.26:16883
Fri Jan 16 22:48:39 2004 44: Authenticate/Decrypt packet error: bad 
packet ID (may be a replay): [ #11695541 / time = (1
074289048) Fri Jan 16 22:37:28 2004 ] -- see the man page entry for 
--no-replay and --replay-window for more info
Fri Jan 16 22:48:39 2004 45: Peer Connection Initiated with 
81.50.152.188:16883
Fri Jan 16 22:48:39 2004 46: Peer Connection Initiated with 10.0.1.26:16883
Fri Jan 16 22:48:48 2004 47: write UDPv4 []: No buffer space available 
(code=105)
Fri Jan 16 22:48:48 2004 48: write UDPv4 []: No buffer space available 
(code=105)

seems it try to connect to vpn external (remote) and internal (specified 
by ifconfig) ip ...
the remote host is specified in a configuration file which had not been 
changed sinced 1.4 (maybe extra mute & log-append but that's all)

i get it on another link with no extra use of cpu and strange frag traffic
but connection is no more reliable

both side are linux 2.4 (openvpn 1.5 and 1.6b1 <-> 1.5b11; will try with 
1.5)

Regards

		Julien

