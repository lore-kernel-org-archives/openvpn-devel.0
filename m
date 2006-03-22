From: "Dave" <dev@...575...>
Subject: RE: [Openvpn-devel] OpenVPN for PocketPC
Message-ID: <000001c64dbd$0aa26390$1601a8c0@...576...>
MIME-Version: 1.0
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
Date: Wed Mar 22 06:30:08 2006
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: 'Iftikhar Qureshi' <iftikharqureshi@...109...>, openvpn-devel@lists.sourceforge.net

Iftikhar;

I should be able to send to you an archive with the modified source for the
PocketPC port of the openvpn (once I find a suitable ftp; the email is
unhappy with the size).


Brief summary of modifications to source thus far:


TAP driver in tap-win32 directory:

dhcp.c		trivial change to avoid compiler warning
error.c		modification to spew debug to text file in debug build
lrror.h		prototype change to avoid compiler warning
lock.h		CE doesn't have IRQLs; compensate design
macinfo.c		alternative random MAC generation
prototypes.h	altered parameters for CreateTapDevice
types.h		modified 'extension' structure for CE-relevant things
tapdvr.c		support CE ;)

resource.h
tap-ce.rc
tap-ce.ico
tap-ce.vcp
tap-ce.def
tap-ce.cpp
tap-ce.h		added



OpenVPN user-mode application in main directory:

config-win32.h			config mods and inclusion of portstuff
cryptoapi.h				include config-win32.h for some
portability defs
win32.c				mods incomplete*
tun.c					include breakout wince_tun.c,
incomplete**

wince_tun.c				breakout of CE-specific tun stuff**
wince_portstuff.h, .c		implementation of some APIs not otherwise
present

* in win32.c, a method get_console_input_win32() needs to be implemented.
** the user-mode side of the tun stuff has not been done; the implementation
in wince_tun.c is just cut/paste from the same-named methods in tun.c so
that compilation will happen.



TBD:

I discovered a couple days ago that all the socket IO uses the overlapped io
method.  So all the stuff in socket.c/h will have to be reworked as well, in
addition to the stuff in tun.c.  I am hoping that doing an implementation of
socket.c that is closer to the unix configuration (where there isn't
overlapped io) will work.

Also, there is a minor method in win32.c that needs implementation.  It
involves console io, and since the SymbolicTools PortLib is being used at
the moment to provide console support, I suspect that documentation in such
can provide guidance.

To install the tap driver you need to set up some registry keys.  In the
interest of concision, here are those keys in regedit format:


REGEDIT4

[HKEY_LOCAL_MACHINE\Comm\TAP Device]
"ImagePath"=3D"tap-ce.dll"
"Group"=3D"NDIS"
"DisplayName"=3D"TAP user-mode ethernet device"

[HKEY_LOCAL_MACHINE\Comm\TAP Device\Linkage]
"Route"=3Dhex(7):\
      54,41,50,20,44,65,76,69,63,65,31,00,00,00,00

[HKEY_LOCAL_MACHINE\Comm\TAP Device1]
"ImagePath"=3D"tap-ce.dll"
"Group"=3D"NDIS"
"DisplayName"=3D"TAP user-mode ethernet device"

[HKEY_LOCAL_MACHINE\Comm\TAP Device1\Parms]
"StreamIndex"=3Ddword:00000001
"StreamName"=3D"TAP"
"BusType"=3Ddword:00000000
"BusNumber"=3Ddword:00000000


If you install these keys, and have the driver named tap-ce.dll and placed
in the \Windows directory, then the driver will be loaded upon start (you
can do soft-reset after copying the files and installing the keys to
stimulate the load).  Also, to uninstall the driver you can remove the keys
or the dll and soft-reset again.

There is an API to load and unload the driver on-the-fly.  It works great in
the emulator but doesn't work on any of my real devices.  It's via
IOCTL_NDIS_REGISTER_ADAPTER.  If you can get that to work on a real device
please let me know.  It fails in interesting ways.  First, when loading the
driver it fails and returns 'parameter error'.  However, it did really load
the driver and the driver is running happily.  Second, when unloading the
driver, it returns 'success', however it really did _not_ unload the driver
and you will still have to soft-reset (after removing the registry keys) to
truly unload it.  Odd!  I notice the reference counts did not drop
appropriately in that second scenario.

-Dave


