Subject: Re: [Openvpn-devel] TCP tunnel problem on Windows
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1071056259.38759@...41...>
In-Reply-To: <1527F40959C109439CBC334DE4758F280C10EA@...142...>
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
Date: Wed Dec 10 03:38:01 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: VLipert@...141..., openvpn-devel@lists.sourceforge.net

Lipert,

The error messages below occur because of an IRP Queue overrun in the
TAP-Win32 driver.  The IRP Queue handles the packet flow from the TAP driver
to the userspace component of OpenVPN.  Not sure why this would occur, though
your config files might shed some light.

James

Lipert Václav <VLipert@...141...> said:

> Hello,
> 
> I am using OpenVPN 1.5.0 for Windows (windowsxp - windowsxp, tap, tcp-client
tcp-server) and I have one problem. After connection establishing work pinging
OK, but when I try connect from server to client with VNC or Remote Desktop
Connection (from Microsoft) it is working for few seconds (first screen
loaded) and then stops working all TCP/IP communication (pinging doesnt work).
On side of client it generates this error (on server side it is no error):
> 
> Mon Dec 08 18:11:57 2003 672: TCPv4_CLIENT link local: [undef]
> Mon Dec 08 18:11:57 2003 673: TCPv4_CLIENT link remote: 127.0.0.1:2000
> Mon Dec 08 18:11:57 2003 674: read from TUN/TAP  [State=AT?c
Err=[c:\src\openvpn\tap-win32\tapdrvr.c/1756] #O=5 Tx=[315,0] Rx=[0,0]
IrpQ=[16,16,16] PktQ=[0,10,64]]: General failure (ERROR_GEN_FAILURE) (code=31)
> Mon Dec 08 18:11:57 2003 675: read from TUN/TAP  [State=AT?c
Err=[c:\src\openvpn\tap-win32\tapdrvr.c/1756] #O=5 Tx=[315,0] Rx=[0,0]
IrpQ=[16,16,16] PktQ=[0,10,64]]: General failure (ERROR_GEN_FAILURE) (code=31)
> Mon Dec 08 18:11:57 2003 676: read from TUN/TAP  [State=AT?c
Err=[c:\src\openvpn\tap-win32\tapdrvr.c/1756] #O=5 Tx=[315,0] Rx=[0,0]
IrpQ=[16,16,16] PktQ=[0,10,64]]: General failure (ERROR_GEN_FAILURE) (code=31)
> Mon Dec 08 18:11:57 2003 677: read from TUN/TAP  [State=AT?c
Err=[c:\src\openvpn\tap-win32\tapdrvr.c/1756] #O=5 Tx=[315,0] Rx=[0,0]
IrpQ=[16,16,16] PktQ=[0,10,64]]: General failure (ERROR_GEN_FAILURE) (code=31)
> Mon Dec 08 18:11:57 2003 678: read from TUN/TAP  [State=AT?c
Err=[c:\src\openvpn\tap-win32\tapdrvr.c/1756] #O=5 Tx=[315,0] Rx=[0,0]
IrpQ=[16,16,16] PktQ=[0,10,64]]: General failure (ERROR_GEN_FAILURE) (code=31)
> Mon Dec 08 18:11:57 2003 679: read from TUN/TAP  [State=AT?c
Err=[c:\src\openvpn\tap-win32\tapdrvr.c/1756] #O=5 Tx=[315,0] Rx=[0,0]
IrpQ=[16,16,16] PktQ=[0,10,64]]: General failure (ERROR_GEN_FAILURE) (code=31)
> Mon Dec 08 18:11:57 2003 680: read from TUN/TAP  [State=AT?c
Err=[c:\src\openvpn\tap-win32\tapdrvr.c/1756] #O=5 Tx=[315,0] Rx=[0,0]
IrpQ=[16,16,16] PktQ=[0,10,64]]: General failure (ERROR_GEN_FAILURE) (code=31)
> Mon Dec 08 18:11:58 2003 681: read from TUN/TAP  [State=AT?c
Err=[c:\src\openvpn\tap-win32\tapdrvr.c/1756] #O=5 Tx=[315,0] Rx=[0,0]
IrpQ=[16,16,16] PktQ=[0,10,64]]: General failure (ERROR_GEN_FAILURE) (code=31)
> Mon Dec 08 18:11:58 2003 682: read from TUN/TAP  [State=AT?c
Err=[c:\src\openvpn\tap-win32\tapdrvr.c/1756] #O=5 Tx=[315,0] Rx=[0,0]
IrpQ=[16,16,16] PktQ=[0,10,64]]: General failure (ERROR_GEN_FAILURE) (code=31)
> Mon Dec 08 18:11:58 2003 683: read from TUN/TAP  [State=AT?c
Err=[c:\src\openvpn\tap-win32\tapdrvr.c/1756] #O=5 Tx=[315,0] Rx=[0,0]
IrpQ=[16,16,16] PktQ=[0,10,64]]: General failure (ERROR_GEN_FAILURE) (code=31)
> Mon Dec 08 18:12:27 2003 684: 269 variation(s) on previous 10 message(s)
suppressed by --mute
> Mon Dec 08 18:12:27 2003 685: Connection reset, restarting [0]
> Mon Dec 08 18:12:27 2003 686: Closing TCP/UDP socket
> Mon Dec 08 18:12:27 2003 687: Restart pause, 3 second(s)
> 
> 
> Anyone knows, where could be a problem?
> 
> Thanks
> Wally
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 



-- 




