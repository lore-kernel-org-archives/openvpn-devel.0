From: David Sommerseth <davids@...515...>
Date: Fri, 28 Oct 2016 21:48:39 +0200
Message-Id: <1477684124-26083-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH v2 0/4] New feature: --auth-gen-token
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

This is an updated patch-set of the --auth-gen-token feature.  A couple
of patches have already been sent to the previous mail thread [1], but I
thought it would be easier to do the final ACK round when everything was
collected into the same thread.

As the previous PATCH 1/5 got ACKed and is already applied to the master
branch, this patch is excluded from this updated thread.

[1] <https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg12701.html>


Quick recap
===========

This patch-set adds a new --auth-gen-token option with an optional lifetime
argument.  This allows existing authentication modules to let clients store
a temporary authentication token for the session instead of caching passwords
locally.  This also have the benefit of allowing Two Factor Authentication 
(2FA) implementations to work properly with the --reneg-* options enabled
without any further modifications.  This feature can be used against any
OpenVPN v2.3.0 client and newer.


What has changed since the first patche-set
===========================================

 - Changes.rst have been updated
 - man page have been improved
 - Ensuring the feature has a consistent naming scheme in the code
 - Ensuring the code don't exceed 80 chars line length
 - Various improvements to comments 


David Sommerseth (4):
  auth-gen-token: Add --auth-gen-token option
  auth-gen-token: Generate an auth-token per client
  auth-gen-token: Push generated auth-tokens to the client
  auth-gen-token: Authenticate generated auth-tokens when client
    re-authenticates

 Changes.rst              | 15 ++++++++
 doc/openvpn.8            | 22 +++++++++++
 src/openvpn/init.c       |  2 +
 src/openvpn/misc.c       |  9 +++++
 src/openvpn/options.c    | 16 ++++++++
 src/openvpn/options.h    |  2 +
 src/openvpn/push.c       | 12 +++++-
 src/openvpn/ssl.c        |  6 +++
 src/openvpn/ssl_common.h | 13 +++++++
 src/openvpn/ssl_verify.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 193 insertions(+), 1 deletion(-)

-- 
1.8.3.1


