From: Tony <kb2wjw@...277...>
Message-ID: <op.s7zxubgnioehzu@...603...>
References: <443EC7D0.9020408@...41...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Re: OpenVPN 2.1-beta14 released
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
Date: Fri Apr 14 04:52:01 2006
Content-Type: text/plain; format=flowed; delsp=yes; charset=koi8-r
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: openvpn-users@lists.sourceforge.net

On Fri, 14 Apr 2006 01:51:12 +0400, James Yonan <jim@...41...> wrote:

> 2006.04.13 -- Version 2.1-beta14
>
> * Fixed Windows server bug in time backtrack handling code which could  
> cause TLS negotiation failures on legitimate clients.
Confirm.
client(v2.1b14)<->server(v2.1b14) works OK on winXP-SP2.
  	
> * Rewrote gettimeofday function for Windows to be simpler and more  
> efficient.
No matter what BG says about his windows - the MS-DOS remnants are still  
there.
http://www.cl.cam.ac.uk/~mgk25/mswish/ut-rtc.html
Is OpenVPN aware of this time-related issue on windows?
(I have my laptop dual-bootable and RTC is on UTC. I may test this in  
server configuration if needed.)

Tony.


