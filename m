Message-Id: <200208271733.g7RHXQG08200@...41...>
Subject: Fwd: [Openvpn-devel] Fwd: Bug#158404: openvpn: Improper error handling
From: "James Yonan" <jim@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Tue Aug 27 10:34:06 2002
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: cowboy@...39...
Cc: openvpn-devel@lists.sourceforge.net

Hello Richard,

Normally we shouldn't get EAGAIN in the UDP read loop because we block on select and don't call recvfrom until there is a datagram waiting for us.  So the fact that you are getting a lot of EAGAIN messages is interesting and probably indicative of some kind of problem.  Is there any correlation between the EAGAIN floods and some sort of real world factor such as a bad or congested network condition?

If EAGAIN is received from recvfrom (or any other error for that matter), it is syslogged and the select event loop continues.  So your potential solutions 1 and 2 below are already being done.  Solution 3 doesn't work because OpenVPN is too asynchronous to be able to block on a single i/o call.  That's why we use select instead.

Also, floods of non-fatal error returns from recvfrom are generally logged for informational purposes, but can be controlled by the --mute option so as not to clog up the log files.

You also mention that sometimes the session drops.  What do you mean?  Does OpenVPN crash or exit?  Does it try to renegotiate?  Does the tunnel die for a while and then come back?  What kind of encryption mode are you running in (Static Key, TLS, or cleartext)?

Since I don't know how to reproduce this, I'll need more details.

James

> ----- Forwarded message from Richard A Nelson <cowboy@...39...> -----
> 
> From: Richard A Nelson <cowboy@...39...>
> Reply-To: Richard A Nelson <cowboy@...39...>,
> 	158404@...40...
> To: submit@...40...
> Subject: Bug#158404: openvpn: Improper error handling
> Date: Mon, 26 Aug 2002 17:28:37 -0400
> X-Spam-Status: No, hits=-4.5 required=5.0 tests=SENT_BY_BTS,FORGED_RCVD_FOUND version=2.20
> 
> Package: openvpn
> Version: 1.3.0-1
> Severity: important
> 
> I often get a flood of these messages:
> openvpn[1239]: read from UDP: Resource temporarily unavailable (errno=11)
> 
> The condition persists for a bit, and then clears up...  While the errors
> are occuring, occasionally the session will drop ;(
> 
> It seems to be improper handling of EAGAIN !
> The potential solutions would most likely be:
> 	1) re-try the systemcall
> 	2) redrive the read loop
> 	3) set blocking IO
> 
> -- System Information
> Debian Release: testing/unstable
> Kernel Version: Linux badlands.lexington.ibm.com 2.4.20-pre4-ac1 #13 Sat Aug 24 19:11:43 EDT 2002 i686 unknown unknown GNU/Linux
> 
> Versions of the packages openvpn depends on:
> ii  libc6          2.2.5-14       GNU C Library: Shared libraries and Timezone
> ii  liblzo1        1.07-1         A real-time data compression library.
> ii  libssl0.9.6    0.9.6g-2       SSL shared libraries
> 
> ----- End forwarded message -----
> 
> -- 
> Alberto Gonzalez Iniesta       | They that give up essential liberty
> agi@...5...                     | to obtain a little temporary safety
> Encrypted mail preferred       | deserve neither liberty nor safety.
> 
> Key fingerprint = 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: OSDN - Tired of that same old
> cell phone?  Get a new here for FREE!
> https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 



-- 




