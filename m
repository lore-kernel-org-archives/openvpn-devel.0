From: "James Yonan" <jim@...41...>
Message-ID: <twig.1058975430.96694@...41...>
Subject: [Openvpn-devel] OpenVPN ported to Windows
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Jul 23 08:51:32 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Well some good news on the development front...

(1) OpenVPN has finally been ported to Windows.
(2) TCP protocol support has been added.

The Windows port was made possible by a number of emerging developments, most
importantly the stabilizing of the TAP driver component of the Cipe-Win32
project, thanks to the work of Damion K. Wilson and the other Cipe-Win32
developers.

My work on this effort involved decoupling the nascent Win32 TAP virtual
device driver from the Cipe-Win32 project, and making OpenVPN comfortable with
the Win32 API and the MinGW development environment.  This is a native port,
and does not require the presence of a Posix compatibility layer such as
Cygwin.  Performance appears to be comparable with Linux running on similar
hardware.

Some Notes:

* The port has been developed and tested on XP only at this point.

* With a few exceptions, most of the core functionality available under Posix
implementations of OpenVPN also works under Windows, including SSL/TLS, LZO
compression, the ability to call scripts (i.e. --up & --tls-auth), and support
for UDP or TCP tunnels.  Features that are missing from the current Windows
beta include --daemon, --shaper, pthread support, TUN devices, and options
such as --mlock or --user which don't have Posix-equivalent Win32 system
calls.  Another limitation is that installation must be done manually, i.e.
there is no Windows installer support yet.

* The --ifconfig option is not implemented on Windows OpenVPN, due to the lack
of an ifconfig executable to call.  Basically what happens when you install
the TAP-Win32 driver is that you get a new TAP network adapter that shows up
in your network control panel.  You right click on the TAP adapter and set the
TCP/IP properties, i.e. IP address and netmask.  Then you rename the TAP
adapter icon to something like "my-tap" and reference it using the --dev-node
option in OpenVPN.  So essentially the function of --ifconfig is accomplished
manually using the GUI and the network control panel.

* While OpenVPN on Windows supports multiple TAP adapters, I have not yet
found an easy way to create and delete TAP adapters using the Network Control
Panel.  Damion tells me that this can be done in the .inf file that is used to
install the driver, but I am still a beginner at understanding .inf files.

* The TAP-Win32 device driver is fairly stable at this point and did not crash
my system despite repeated editing, compiling, installing, and reinstalling
the driver.

* The other new feature is TCP support, for situations where using UDP is not
possible.  TCP support is enabled through the the new --proto option.  You can
select the protocol with --proto p, where p = udp | tcp-server | tcp-client. 
TCP support also works on Windows.  Since TCP is connection oriented, OpenVPN
needs to handle Connection Reset events.  Basically, on connection reset, a
TCP client or server will simulate a SIGUSR1 signal.  The server will go back
into a mode where it listens for a new connection, and the TCP client will
simulate a SIGUSR1 signal which will normally cause it to try to reestablish
the connection with the server.

Known Issues in the beta:

* TCP mode combined with --daemon doesn't work correctly yet -- this will be
fixed before 1.5 final.

* For some reason if a Solaris TCP client is connected to a TCP server, and
that TCP server resets the connection, the Solaris client will try to
reconnect, and will apparently succeeed, but then after reading a handful of
bytes from the remote, the client suddenly thinks that the connection was
reset again, and it will restart.  This client restart will also cause the
server to restart, and the whole process repeats again.  I have tested this
same scenario using both Windows and Linux TCP clients, but only Solaris TCP
clients show this problem.  The Solaris system I am using is:

SunOS [name] 5.9 Generic_112233-06 sun4u sparc SUNW,Ultra-1

Downloads
---------

The beta version of the Windows distribution can be downloaded from here (with
source + pre-compiled binaries):

http://openvpn.sourceforge.net/beta/openvpn-1.4.99.3.zip

See the file INSTALL.w32 for Windows installation instructions.

The usual Posix distribution beta is here:

http://openvpn.sourceforge.net/beta/openvpn-1.4.99.3.tar.gz

The version numbering scheme is an attempt to denote a pre-1.5 beta in a way
that works with RPM spec files. 

The only differences between the distributions are compressed file formats
(.tar.gz for posix, .zip for windows) and the presence of a win32-binaries
directory on the .zip distribution which contains a pre-built openvpn exe,
OpenSSL DLLs, and the TAP-Win32 device driver.

James


