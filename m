From: Alberto Gonzalez Iniesta <agi@...5...>
Message-ID: <20020827144054.GB1146@...30...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Fwd: Bug#158404: openvpn: Improper error handling
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
Date: Tue Aug 27 07:45:06 2002
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi James et al,

I just came back from holidays and got this bug report in Debian. (Seems
like IBM is using OpenVPN). I didn't have time to look at it yet, but
I'm sure you'll handle it better anyway :)

Best regards,

Alberto



----- Forwarded message from Richard A Nelson <cowboy@...39...> -----

From: Richard A Nelson <cowboy@...39...>
Reply-To: Richard A Nelson <cowboy@...39...>,
	158404@...40...
To: submit@...40...
Subject: Bug#158404: openvpn: Improper error handling
Date: Mon, 26 Aug 2002 17:28:37 -0400
X-Spam-Status: No, hits=-4.5 required=5.0 tests=SENT_BY_BTS,FORGED_RCVD_FOUND version=2.20

Package: openvpn
Version: 1.3.0-1
Severity: important

I often get a flood of these messages:
openvpn[1239]: read from UDP: Resource temporarily unavailable (errno=11)

The condition persists for a bit, and then clears up...  While the errors
are occuring, occasionally the session will drop ;(

It seems to be improper handling of EAGAIN !
The potential solutions would most likely be:
	1) re-try the systemcall
	2) redrive the read loop
	3) set blocking IO

-- System Information
Debian Release: testing/unstable
Kernel Version: Linux badlands.lexington.ibm.com 2.4.20-pre4-ac1 #13 Sat Aug 24 19:11:43 EDT 2002 i686 unknown unknown GNU/Linux

Versions of the packages openvpn depends on:
ii  libc6          2.2.5-14       GNU C Library: Shared libraries and Timezone
ii  liblzo1        1.07-1         A real-time data compression library.
ii  libssl0.9.6    0.9.6g-2       SSL shared libraries

----- End forwarded message -----

-- 
Alberto Gonzalez Iniesta       | They that give up essential liberty
agi@...5...                     | to obtain a little temporary safety
Encrypted mail preferred       | deserve neither liberty nor safety.

Key fingerprint = 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

