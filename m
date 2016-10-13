From: David Sommerseth <davids@...515...>
Date: Thu, 13 Oct 2016 21:59:26 +0200
Message-Id: <1476388771-16492-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH 0/5] New feature: --auth-gen-token
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

This new feature enables re-authentication of on-going sessions without
asking the user for a new password.  This is in particular useful when
the authentication scheme is based on One Time Passwords (OTP).

When OTP is used and without auth-token support in the authentication module
OpenVPN is configured to use, the clients will be asked for a new OTP each
time OpenVPN starts a re-negotiation.  What often happens is that this
re-negotiation is disabled to avoid this.

OpenVPN does provide a remedy to this, by pushing a unique auth-token value
to each client.  Then the authentication module needs to keep track of which
client is using which auth-token value.  When a client receives the pushed
auth-token option and the attached value, it replaces the locally saved
password with this token value.  So for all coming re-authentications, the
client will send this value as the password instead of the users password.

But not all authentication modules adds support for this feature.  By adding
--auth-gen-token to the server configuration, the OpenVPN server will take
care of the auth-token processing and authentication.  This also means that
the server will not call the configured authentication module on
re-negotiations; it will do the re-negotiation internally by itself.

This feature may just as well be useful for non-OTP configurations as well.
Unless the OpenVPN client is configured with --auth-nocache, it will save
the users password in-memory for the lifetime of the OpenVPN session.  Using
this feature that password will be replaced by the auth-token instead.

The patch-set this thread covers focuses only on this new --auth-gen-token
feature.  The --auth-token option added to OpenVPN 2.3, but never properly
documented.  The --auth-token documentation is tracked in this mail thread:
http://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg12506.html
(Message-Id: <http://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg12506.html>)

One remark regarding PATCH 1/5.  This patch is needed by PATCH 5/5.  I just
chose to split it out as a separate patch to make the core auth-gen-token
patches easier to review.  This patch can be moved anywhere before PATCH 5/5
or squashed into PATCH 5/5 if that is requested.

David Sommerseth (5):
  Move memcmp_constant_time() to crypto.h
  auth-gen-token: Add --auth-gen-token option
  auth-gen-token: Generate an auth-token per client
  auth-gen-token: Push generated auth-tokens to the client
  auth-gen-token: Authenticate generated auth-tokens when client
    re-authenticates

 doc/openvpn.8            | 16 ++++++++++
 src/openvpn/crypto.c     | 18 -----------
 src/openvpn/crypto.h     | 18 +++++++++++
 src/openvpn/init.c       |  2 ++
 src/openvpn/misc.c       |  5 +++
 src/openvpn/options.c    | 16 ++++++++++
 src/openvpn/options.h    |  2 ++
 src/openvpn/push.c       |  9 +++++-
 src/openvpn/ssl.c        |  6 ++++
 src/openvpn/ssl_common.h | 11 +++++++
 src/openvpn/ssl_verify.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++
 11 files changed, 167 insertions(+), 19 deletions(-)

-- 
1.8.3.1


