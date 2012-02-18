MIME-Version: 1.0
Date: Sat, 18 Feb 2012 17:05:16 +0200
Message-ID: <CAOazyz3S2GAFu+TN0s7482ovQBdWJYUxALVfOEiF6UGHR0oW0Q@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: [Openvpn-devel] [DEVELOPER REQUESTED] Repackage TAP-Win32
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Hello,

We have a go to rewrite the OpenvPN build system.
I started to work at core product [1].

As part of the re-write we split out the TAP-Win32 out of OpenVPN code base.

To make things go faster we may try to parallelize the effort.

Here are the tasks to perform:
1. Create a GIT repository of the master TAP-Win32 sources with all
history, to ease our work, please use github.
2. Detach the TAP-Win32 build from the OpenVPN build. It should be a
simpler build as it now only use the DDK.
3. Rename the TAP-Win32 to TAP-Windows as we do not need the legacy
"Win32" any more.
4. Rename the TAP common.h into tap-windows.h.
5. Sync tap-windows.h symbols per [2], I added prefix and removed the
"32", add another header for version information.
6. Create tap nsis installation (based on current openvpn nsis), the
msi must be silent installation mode enabled.
7. Within installation, add a group "SDK" or similar to nsis to
install the tap-windows.h as well.
8. Create build script to build and optionally sign the driver and the msi.
9. Output of build system would be [at least] (msi, tarball) for
(win32, win64). Why tarball? To enable people to fetch files without
hacking the msi (example: cross compile).

Anyone interested?
Need someone experienced with courage!

Alon.

[1] https://github.com/alonbl/openvpn branch build.
[2] https://github.com/alonbl/openvpn/blob/build/include/tap-windows.h

