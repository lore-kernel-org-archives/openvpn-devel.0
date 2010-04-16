Message-ID: <4BC8A2EA.9070602@...1147...>
Date: Fri, 16 Apr 2010 19:48:26 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
Subject: [Openvpn-devel] man page patch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Openvpn-devel@lists.sourceforge.net

man page patch to fix (based on the git page).

- explicit-exit-notify text is misleading : parameter [n] is the number 
of attempts not the number of retries

- I would make a statement that a section starting with 'so I would make 
a statement' does not belong in a man page


--- new-openvpn.8    2010-04-16 19:16:08.427860657 +0200
+++ jjk-openvpn.8    2010-04-16 19:46:01.374609848 +0200
@@ -3308,8 +3308,8 @@
 option will tell the server to immediately close its client instance object
 rather than waiting for a timeout.  The
 .B n
-parameter (default=1) controls the maximum number of retries that the 
client
-will attempt to resend the exit notification message.
+parameter (default=1) controls the maximum number of attempts that the 
client
+will make to send the exit notification message.
 .\"*********************************************************
 .SS Data Channel Encryption Options:
 These options are meaningful for both Static & TLS-negotiated key modes
@@ -3591,7 +3591,7 @@
 OpenVPN adds to the IPSec model by limiting the window size in time as 
well as
 sequence space.
 
-OpenVPN also adds TCP transport as an option (not offered by IPSec) in 
which
+OpenVPN also adds TCP transport as an option (not offered by plain 
IPSec) in which
 case OpenVPN can adopt a very strict attitude towards message deletion and
 reordering:  Don't allow it.  Since TCP guarantees reliability, any packet
 loss or reordering event can be assumed to be an attack.
@@ -3601,11 +3601,6 @@
 message deletion or reordering attack which falls within the normal
 operational parameters of IP networks.
 
-So I would make the statement that one should never tunnel a non-IP 
protocol
-or UDP application protocol over UDP, if the protocol might be 
vulnerable to a
-message deletion or reordering attack that falls within the normal 
operating
-parameters of what is to be expected from the physical IP layer.  The 
problem
-is easily fixed by simply using TCP as the VPN transport layer.
 .\"*********************************************************
 .TP
 .B \-\-mute-replay-warnings


