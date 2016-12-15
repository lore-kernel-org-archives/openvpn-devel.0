From: David Sommerseth <davids@...515...>
Date: Thu, 15 Dec 2016 21:20:44 +0100
Message-Id: <1481833246-32507-1-git-send-email-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/2] LZ4 updates
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

This patch set is rebasing the LZ4 compat library to the latest upstream
LZ4 release (v1.7.4.2).  This library is only used if ./configure cannot
find a system LZ4 library.

In addition, I've included Christian Hesse's patch he already sent to the
mailing list as we should review those two combined.  His patch will ensure
we will be able to build against LZ4 libraries older than lz4-r129.

But ... should we also consider to build against compat-lz4 if a too old
library is found?  Too old perpahs should be related to if the
LZ4_VERSION_NUMBER macro can be found or not.  The problem however with
static linking is if the system upgrades from r131 (not carrying that macro)
to a future version v1.8, then OpenVPN would not benefit from the newer
system library.  This gets critical if there are some security patches to
the LZ4 library, which would then require a new build of OpenVPN.

There is also another potential issue with the current approach, if we link
against r129 or older ... the code will be using
LZ4_compress_limitedOutput().  If the system library is upgraded to a newer
upstream version which finally removes LZ4_compress_limitedOutput(), OpenVPN
will break.

One way to get around this, which is not trivial and causes alot more code
to be added, is to always build and link the compat-lz4 library under its
own name space.  Then not to do a dynamic linking against liblz4, but rather
try to load it at runtime and probe it.  Once the newest version is
determined, the proper function pointers are set up, pointing at the LZ4
version we prefer - either our own compat-lz4 or the system wide liblz4. But
I am far from convinced this is a good or reasonable approach for this part
of the code.


Christian Hesse (1):
  replace deprecated LZ4 function

David Sommerseth (1):
  lz4: Rebase compat-lz4 against upstream v1.7.4.2

 src/compat/compat-lz4.c | 820 ++++++++++++++++++++++----------------------=
----
 src/compat/compat-lz4.h | 377 ++++++++++++++--------
 src/openvpn/comp-lz4.c  |   4 +
 3 files changed, 623 insertions(+), 578 deletions(-)


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc


