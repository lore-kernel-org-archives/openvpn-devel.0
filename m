From: David Sommerseth <davids@...515...>
Date: Mon, 31 Oct 2016 13:51:56 +0100
Message-Id: <1477918318-18561-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH 0/2] auth-gen-token: Inform client why
	auth-token was rejected
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

Previously when a client connection got closed due to the auth-token 
being rejected, the client did not receive any indication why.  This
patch-set ensures the client will receive such an indication.

The AUTH_FAILED statement which is used to reject and close client
connections can contain a text string with a message aimed at the
user.  Some clients (like OpenVPN Connect) have also some kind of
categorization.  For this use-case, the SESSION category was chosen.

The rejection message to the client is sent using the send_auth_failed()
function.  This ensures the formatting is proper.  The only detail we
need to ensure is that the category and the message is separated by
a colon (:).

This patch-set is split into two parts.  The first parts refactors
the code to provide the struct context object the whole way into
key_method_2_read().  This is the place where verify_user_pass() is
called.  The reason we need the struct context object is that 
send_auth_failed() needs that to prepare a message to be pushed to
the client.

The second patch just implements the rejection message and 
calling send_auth_failed() with the appropriate messages.

David Sommerseth (2):
  Refactor to provide struct context object inside key_method_2_read()
  auth-gen-token: Provide a rejection message back to the client on
    failure

 src/openvpn/forward.c    |  2 +-
 src/openvpn/ssl.c        | 30 +++++++++++++++++-------------
 src/openvpn/ssl.h        |  6 +-----
 src/openvpn/ssl_verify.c | 13 +++++++++----
 src/openvpn/ssl_verify.h |  2 +-
 5 files changed, 29 insertions(+), 24 deletions(-)

-- 
1.8.3.1


