MIME-Version: 1.0
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 1 Feb 2022 11:43:40 +0200
Message-ID: <CAGyAFMXhDNuu7jKwsOnymtd2F1qLQgn4-0KMppLogZ-AdYPmFw@...278...>
Subject: [Openvpn-devel] OpenVPN Data Channel Offload for Windows (Jan 2022)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Dear all,

OpenVPN Community would like to present a new technical preview version of
OpenVPN Windows client with Data Channel Offload functionality. This version
includes many bugfixes and improvements since the previous one (May 2021).
It also uses OpenSSL 3.0.1.

The client is built from the openvpn "dco" branch
(https://github.com/openvpn/openvpn/tree/dco)
plus some unmerged patches. The Data Channel Offload kernel driver is built
from https://github.com/openvpn/ovpn-dco-win

The signed installers for x64, x86 and ARM64 could be downloaded from
the link below:

https://build.openvpn.net/downloads/temp/ovpn-dco-win/msi/

Note that DCO functionality requires Windows 10 2004 (Windows Server
2022) or newer.
To enable it, add following options to your ovpn profile:

    windows-driver ovpn-dco-win
    tun-mtu 1428

If you are interested in what happens inside the driver, you could run TraceView
(https://docs.microsoft.com/en-us/windows-hardware/drivers/devtest/traceview)
and
create a new logging session with control GUID
4970F9cf-2c0c-4f11-b1cc-e3a1e9958833.
More information could be found in README.md in ovpn-dco-win repo.

Please give it a try and let us know if you got better performance
compared to tap-windows6.
If you experience any issues with it, please let us know too. Be aware
that this is a technical
preview and not a final release, so use your judgement.

--
-Lev

