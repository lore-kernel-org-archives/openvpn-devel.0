Sender: Fabian Knittel <fabian@...1547...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Sat, 11 Oct 2014 00:09:17 +0200
Message-Id: <1412978966-15392-1-git-send-email-fabian.knittel@...1547...>
In-Reply-To: <5437B156.1020408@...1114...>
References: <5437B156.1020408@...1114...>
Subject: [Openvpn-devel] [PATCH 0/9] Refactor client-connect / add support
	for deferred handling
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

Hi,

a few years ago I wrote a patch-set concerning OpenVPN's client-connect
code.  The first part of the patch-set (patches 1 to 6) refactors and unifies
the client-connect code.  (This might be of interest in the current "Fix
temporary file leak"-thread.)

The second part of the patch-set allows client-connect handling to proceed
asynchronously, similar to how OpenVPN supports asynchronous (or deferred)
authentication.  Basically, the scripts or v1-plugins handling the
client-connect event can now write back an additional status code that
indicates deferred handling of the client-connect.  This causes the OpenVPN
server to continue with other things and to regularly re-read the status file.
As soon as the status changes from "deferred" to "failed" or "succeeded", the
client-connect processing for the connection is continued.  (As mentioned
before, the auth code does something very similar.)

The motivation for the deferred handling approach were relatively long running
client-connect scripts (> 2s) intended for high-traffic servers.  As the
OpenVPN server completely blocks while synchronously waiting for client-connect
scripts to complete, the asynchronous / deferred approach was needed.

The deferred script code path has been in production use for a few years now,
although this freshly rebased patch-set has only seen light testing so far.

Feed-back would be very welcome.

The patches are also availabe on a Github branch:
https://github.com/fknittel/openvpn/tree/feat_deferred_client-connect

Cheers
Fabian

PS: See
https://github.com/fknittel/openvpn/wiki/Patch-set-%22deferred-client-connect%22
in case you're interested in ready-made Debian packages.

Fabian Knittel (9):
  client-connect: Split multi_connection_established into separate
    functions
  client-connect: Properly indent all functions
  client-connect: Refactor multi_client_connect_source_ccd
  client-connect: Move multi_client_connect_setenv into early_setup
  client-connect: Refactor to use return values instead of modifying a
    passed-in flag
  client-connect: Refactor client-connect handling to calling a bunch of
    hooks in a loop
  client-connect: Add CC_RET_DEFERRED and cope with deferred
    client-connect
  client-connect: Add deferred support to the client-connect script
    handler
  client-connect: Add deferred support to the client-connect plugin v1
    handler

 src/openvpn/multi.c   | 831 ++++++++++++++++++++++++++++++++++++--------------
 src/openvpn/multi.h   |  32 +-
 src/openvpn/options.h |   6 +
 3 files changed, 635 insertions(+), 234 deletions(-)

-- 
2.1.1


