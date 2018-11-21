From: Arne Schwabe <arne@...1227...>
Date: Wed, 21 Nov 2018 11:10:06 +0100
Message-Id: <20181121101019.1801-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v4 00/13] Deferred client-connect patch set
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

Fabian submitted the original patch set in 2015. When I started working on it
I had quite big rebase conflicts and decided to rebsae it manually. During
this rebase I adjusted the code and made other minor and major adjustments
to the code to better fit our current code style. The minor adjustments are
mostly not mentioned in the commit message. The larger changes are mentioned
or if feasible and sensible in their own commits. 

The V4 patch fixes minor code style problems, spotted by
uncrustify. Since modifying the first patch creates merge conflicts in
all other patches, the whole patch series is rebased and resend. The
patches themsevles do not have a V4 item in them that mentions this
reformatting.

Arne Schwabe (5):
  client-connect: Change connection_established_flag from bool to enum
  client-connect: Move adding inotify watch into its own function
  client-connect: Also use inotify for the deferred client-connect
    status file
  client-connect: Implement deferred connect support for plugin API v2
  client-connect: Add documentation for the deferred client connect
    feature

Fabian Knittel (8):
  client-connect: Split multi_connection_established into separate
    functions
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

 doc/openvpn.8               |   47 +-
 include/openvpn-plugin.h.in |   51 +-
 src/openvpn/multi.c         | 1045 ++++++++++++++++++++++++++---------
 src/openvpn/multi.h         |   52 +-
 src/openvpn/plugin.c        |    6 +
 5 files changed, 906 insertions(+), 295 deletions(-)

-- 
2.19.1


