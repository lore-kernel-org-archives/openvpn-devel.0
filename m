From: Domagoj Pensa <domagoj@...2540...>
Message-ID: <20200205124615.15758-1-domagoj@...2540...>
Date: Wed,  5 Feb 2020 13:46:13 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/2] Couple of fixes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi!

First patch fixes long delays when setting IPv4 DNS using netsh without=20
interactive service by adding "validate=3Dno" to netsh invocation.

I've noticed that issue while testing wintun, as it is setup using netsh.

All other variants, IPv6 DNS without interactive service and IPv4/IPv6 DNS=
=20
with interactive service, have validation already turned off.

Change is adapted from code by commit 786e06a.
It is necessary to make sure that argument is added only for DNS and not=20
WINS, thus additional check is made (is_dns).

Second patch was necessary, at least for me, because build process was=20
unable to perform linking, with the following output:

/usr/bin/x86_64-w64-mingw32-ld: forward.o:forward.c:(.text+0x5fec):=20
undefined reference to `tuntap_is_wintun'
/usr/bin/x86_64-w64-mingw32-ld: mtcp.o:mtcp.c:(.text+0x8a4): undefined refe=
rence to `tuntap_is_wintun'
/usr/bin/x86_64-w64-mingw32-ld: mtcp.o:mtcp.c:(.text+0x1362): undefined ref=
erence to `tuntap_is_wintun'
/usr/bin/x86_64-w64-mingw32-ld: mtcp.o:mtcp.c:(.text+0x1379): undefined ref=
erence to `tuntap_ring_empty'
/usr/bin/x86_64-w64-mingw32-ld: mudp.o:mudp.c:(.text+0x536): undefined refe=
rence to `tuntap_is_wintun'
/usr/bin/x86_64-w64-mingw32-ld: mudp.o:mudp.c:(.text+0xf53): undefined refe=
rence to `tuntap_ring_empty'
/usr/bin/x86_64-w64-mingw32-ld: openvpn.o:openvpn.c:(.text+0x1b6): undefine=
d reference to `tuntap_ring_empty'
/usr/bin/x86_64-w64-mingw32-ld: openvpn.o:openvpn.c:(.text+0x261): undefine=
d reference to `tuntap_is_wintun'
collect2: error: ld returned 1 exit status

After declaring both functions as static linking worked.

I'm using Ubuntu 19.04 with mingw-w64 from official repository (version=20
6.0.0-3) and for build process script generic/build from openvpn-build=20
repository.

It is also worth noting that similar function tuntap_defined() with same=20
signature (static inline bool) already exists in the same header file, so=20
this change should be safe.

Domagoj Pensa (2):
  Skip DNS address validation
  Fix linking issues on MinGW

 src/openvpn/tun.c | 9 +++++++++
 src/openvpn/tun.h | 4 ++--
 2 files changed, 11 insertions(+), 2 deletions(-)

--=20
2.25.0



