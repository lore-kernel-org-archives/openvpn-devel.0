Date: Tue, 9 Oct 2012 14:52:33 -0400
From: Adam McDougall <mcdouga9@...1777...>
Message-ID: <20121009185233.GS48053@...1777...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Backslash in user/pass breaks OpenVPN-GUI
	management authentication
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hello, I've been running an OpenVPN server for several years and in 
recent years I've been testing out various Windows GUIs.  Essentially 
just the official one bundled with the OpenVPN Windows download and the 
OpenVPN-MI variant.

This report concerns the OpenVPN-GUI application included with 
2.3-alpha3 and 2.3_beta1.  I am excited to see native support for the 
Management Interface which I will ultimately need if I start deploying 
the Windows client, but I discovered username/password authentication 
chokes if either contain a backslash: \

Tue Oct 09 14:23:55 2012 Warning: cannot open --log file: C:\Program Files\OpenVPN\log\openvpn-user-client.log:
The process cannot access the file because it is being used by another process.   (errno=32)
Tue Oct 09 14:23:55 2012 OpenVPN 2.3_beta1 x86_64-w64-mingw32 [SSL (OpenSSL)] [LZO] [PKCS11] [eurephia] [IPv6]
built on Sep 14 2012
Tue Oct 09 14:23:55 2012 MANAGEMENT: TCP Socket listening on [AF_INET]127.0.0.10:25341
Tue Oct 09 14:23:55 2012 Need hold release from management interface, waiting...
Tue Oct 09 14:23:55 2012 MANAGEMENT: Client connected from [AF_INET]127.0.0.10:25341
Tue Oct 09 14:23:55 2012 MANAGEMENT: CMD 'state on'
Tue Oct 09 14:23:55 2012 MANAGEMENT: CMD 'log all on'
Tue Oct 09 14:23:55 2012 MANAGEMENT: CMD 'hold off'
Tue Oct 09 14:23:55 2012 MANAGEMENT: CMD 'hold release'
Tue Oct 09 14:24:06 2012 MANAGEMENT: CMD 'username "Auth" "aa\aa"'
Tue Oct 09 14:24:06 2012 MANAGEMENT: CMD 'password [...]'
(hangs here)

I am running OpenVPN as a service on the client, and the server is using 
the PAM auth plugin to require user/pass authentication.  This works 
fine as long as the username and password do not contain a backslash, so 
this seems like a quoting issue when the user/pass get passed to the TCP 
port for management.

I am hoping this could be fixed for or shortly after the 2.3 release 
since I think it is the last remaining large issue in my way.  The other 
big one was the DHCP NAK issue in the TAP Adapter but I am thrilled it 
is fixed.  Please let me know if there is some place I should file a 
formal bug ticket (I hunted for a while) or whatever else I can do that 
could help this get fixed.  Thanks.

