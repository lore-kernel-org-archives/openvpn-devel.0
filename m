From: David Sommerseth <davids@...515...>
Date: Thu, 22 Sep 2016 21:40:57 +0200
Message-Id: <1474573258-25420-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH/RFC] Remove global allocation of HTTP proxy
	user/password
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch tries to remove allocating memory which will not being used unless
a specific feature is enabled.  This is merely to get a patch out to be tested
and to see if this is worth the efforts.  The code does get extended, but
for embedded devices, the benefit might just be big enough to get a reasonable
profit.

This is related to a patch where it was considered to increase USER_PASS_LEN
from 128 bytes to 4096 by default, but it was discovered that there are 
several places where the code uses static allocation which then would be
wasting memory.

If people could test this patch for HTTP and NTLM proxies, both with and
without user/password authentication, I would appreciate that a lot!

If we consider this work to be worth it, similar patches for the management
interface and the more generic username/password authentication might come
too.

David Sommerseth (1):
  Remove static global allocation of HTTP proxy user/passwords

 src/openvpn/ntlm.c  | 16 ++++++++--------
 src/openvpn/proxy.c | 41 +++++++++++++++++++++++++++++------------
 src/openvpn/proxy.h |  2 +-
 3 files changed, 38 insertions(+), 21 deletions(-)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJX5DN2AAoJEIbPlEyWcf3ygbUQAIRZ0z5trB+/s39oGXgQzI6V
yAPe/Q3vJIUG9KRc3bpmqMPBNhS1ieCYpdpvhVdpgWpKnJbWvfFdnI2yQj4Uth0S
G+j7oFxI+c+4LT4o2cyZ1ib7LA204ewkR/etbZvlMJcdq6SW34R3BU4+KHhRGvAp
XtVAEzhjGdV9JofeJ880BFKL2J+wrx8wdrX26ysBYmdc4mmlnTpyF4owexh13AyO
ptp0MUa4dmTCGyItkKY52PxtfOmj4scnqxwWN/CKwAf8fVo7nUtdQfPAVSUvb7ty
LDbh2uSg1F9CVsalYvGV8dSEx3Rz3sfyciNjpPup/Hp7QtHqyjgIds1F/rLwDbvK
JDCepPgCW1Y0A+6r8JL1ocB0uXh4akSR7rPeX1iDjC6+l4lZgpozqoLvNmPpDnkh
4UbtnMGUzeaynR47X7FA/TgqdWmoseMkuFindeyW7vHoIdn4Q2a4tQtWwfSW2o8X
2aO/za3hPq1TDa0fOZICWQYJ4ouwXoj1PmU5AcAF0A74v9L8CXPlaI2IZsxajrO/
iescNu/6gvE4VWdLEFBhJWI464icnk8CenEdj08r2UPrMCwdJF/ZiqJvlesU9hFR
m59WXXvjGMerBhPaKdiVxqHDoMbzFOGkd3Nedx5k3N8vkxORxf3cz/xLCytZet73
3wdLUKQsTbfb6Cp5Xv/z
=JKpg
-----END PGP SIGNATURE-----

