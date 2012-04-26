MIME-Version: 1.0
Date: Fri, 27 Apr 2012 02:29:15 +0300
Message-ID: <CAOazyz3Z3Mr=wBnjZ=PmRV8cMWezzqv6ZgJrNXcxkfj73jUyvA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: [Openvpn-devel] tap-windows - release
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
To: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>, =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>

Hello Samuli,

The tap-windows project unlikely to be changed, I think we should release it.

I already created public repository[1], completed the separate build,
signing and packaging.

All we need is a signed build.

Something like:
set CODESIGN_PKCS12=<key location in PKCS#12 format>
set CODESIGN_PASS=>password>
configure
build

I had only software signing certificate (not driver), so I could not
test this all the way. But it should be OK.

If you need help converting the Microsoft proprietary format into
standard PKCS#12 format, please tell me.

Alon.

[1] https://github.com/OpenVPN/tap-windows

