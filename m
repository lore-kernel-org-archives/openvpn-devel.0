Message-ID: <4B5E2895.4030906@...1299...>
Date: Tue, 26 Jan 2010 12:26:13 +1300
From: Jason Haar <Jason.Haar@...1299...>
MIME-Version: 1.0
Subject: [Openvpn-devel] win32 openvpn-2.1.1 has bug with "nobind"?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi there

I'm running openvpn as a client under XP and Win7 (binary from
openvpn.net) over UDP with the "nobind" option. "netstat -anb" shows
openvpn.exe is attached to local port 1194. I'm running it as a service BTW.

In general it works well, but once in a while, restarting openvpn
doesn't work - you get some vague "cannot access" error. Waiting some
minutes or rebooting will always fix the problem. Ends up that running
"netstat -an" in this situation shows that something is associated with
udp port 1194 - svchosts.exe. When this happens, waiting until 1194
disappears from netstat means I'm able to start openvpn successfully.

So there's a couple of issues. As I was using "nobind", shouldn't the OS
have allocated the port? i.e. why is it always 1194 - not 20111 or the
like? Secondly, as it's "nobind", shouldn't openvpn have allocated the
next free port instead of trying to reuse 1194?

Finally, any ideas why openvpn doesn't cleanly exit all the time. I also
use openvpn client under Linux and it never shows these symptoms, so I'd
guess these are all win32-specific.

Thanks

-- 
Cheers

Jason Haar
Information Security Manager, Trimble Navigation Ltd.
Phone: +64 3 9635 377 Fax: +64 3 9635 417
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1


