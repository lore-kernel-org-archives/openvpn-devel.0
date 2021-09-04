From: Antonio Quartulli <a@...2181...>
Date: Sat,  4 Sep 2021 11:56:22 +0200
Message-Id: <20210904095629.6273-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/7] change defaults and introduce
 compat-mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <a@...2181...>

This patchset is basically Arne's patch
"Modernise OpenVPN defaults and introduce '--compat-mode'"
divided in smaller patches in order to group relevant changes together,
make review easier and allow potential reverting/bisecting in the
future.

* Patch 1 is a restyling;
* Patch 2 introduces the knob to let users specify the version to be
  compatible with;
* Patch 3, 4, 5 and 6 change defaults and introduce related compat-mode
  values;
* Patch 7 adds a generic warning to let user know that default have
  changed and something may not behave as expected, unless compat-mode is
  used;

This change is an important milestone that will allow us to move our
effort onto supporting ovpn-dco.

Cheers,

Antonio Quartulli (7):
  simplify condition detecting pure P2P mode
  compat-mode: allow user to specify version to be compatible with
  reject compression by default
  do not include --cipher value in data-ciphers
  compat-mode: add --data-cipher-fallback auomatically if requested
  set TLS 1.2 as minimum by default
  add message about changing default values

 Changes.rst                          |  23 ++++++
 doc/man-sections/generic-options.rst |  21 +++++
 src/openvpn/comp.h                   |   1 +
 src/openvpn/options.c                | 117 +++++++++++++++++++++++----
 src/openvpn/options.h                |   4 +
 src/openvpn/ssl_ncp.c                |  13 +++
 src/openvpn/ssl_ncp.h                |   8 ++
 7 files changed, 172 insertions(+), 15 deletions(-)

-- 
2.32.0


