From: Arne Schwabe <arne@...1227...>
Date: Wed, 30 Sep 2020 15:13:05 +0200
Message-Id: <20200930131317.1299-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 00/11] Pending authentication improvements
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

This patchset brings a number of improvements:

 - Allow a tiemout that is different from the default 60s for
   pending authentication. 60s is a bit tight, especially when
   being redirected to a complicated web login process.
 - Make the server side auth-pending support no longer
   dependent on management interface but also allow scripts
   and plugins to utilise it.
 - Introduce deffered authentication support for scripts.
   Deferred authentication is a necessary requirement for
   pending authentication.

The branch is also available here: https://github.com/schwabe/openvpn/tree/schwabe/auth_pending

Arne Schwabe (11):
  Change pull request timeout use a timeout rather than a number
  Implement client side handling of AUTH_PENDING message
  Implement server side of AUTH_PENDING with extending timeout
  Introduce management client state for AUTH_PENDING notifications
  Change parameter of send_auth_pending_messages from context to
    tls_multi
  Add S_EXITCODE flag for openvpn_run_script to report exit code
  Refactor extract_var_peer_info into standalone function and add
    ssl_util.c
  Allow pending auth to be send from a auth plugin
  Implement deferred auth for scripts
  Implement --client-crresponse script options and plugin interface
  Add example script demonstrating TOTP via auth-pending

 Changes.rst                          |  18 ++
 doc/man-sections/generic-options.rst |   3 +-
 doc/man-sections/script-options.rst  |  45 ++++-
 doc/man-sections/server-options.rst  |   4 +
 doc/man-sections/tls-options.rst     |   4 +
 doc/management-notes.txt             |  39 +++-
 include/openvpn-plugin.h.in          |  15 +-
 sample/sample-scripts/totpauth.py    | 107 ++++++++++
 src/openvpn/Makefile.am              |   1 +
 src/openvpn/forward.c                |  27 ++-
 src/openvpn/forward.h                |   9 +
 src/openvpn/init.c                   |   1 +
 src/openvpn/integer.h                |  25 +++
 src/openvpn/manage.c                 |  29 ++-
 src/openvpn/manage.h                 |   5 +-
 src/openvpn/multi.c                  |  29 +--
 src/openvpn/openvpn.h                |   2 +-
 src/openvpn/openvpn.vcxproj          |   2 +
 src/openvpn/openvpn.vcxproj.filters  |   6 +
 src/openvpn/options.c                |  15 ++
 src/openvpn/options.h                |   1 +
 src/openvpn/platform.c               |  35 ++++
 src/openvpn/platform.h               |   5 +-
 src/openvpn/push.c                   | 157 ++++++++++++++-
 src/openvpn/push.h                   |  23 ++-
 src/openvpn/run_command.c            |  25 ++-
 src/openvpn/run_command.h            |  14 +-
 src/openvpn/ssl.c                    |   8 +-
 src/openvpn/ssl.h                    |   3 +
 src/openvpn/ssl_common.h             |   4 +
 src/openvpn/ssl_ncp.c                |  20 +-
 src/openvpn/ssl_util.c               |  59 ++++++
 src/openvpn/ssl_util.h               |  49 +++++
 src/openvpn/ssl_verify.c             | 283 +++++++++++++++++++++++++--
 src/openvpn/ssl_verify.h             |  25 ++-
 tests/unit_tests/openvpn/Makefile.am |   3 +-
 36 files changed, 982 insertions(+), 118 deletions(-)
 create mode 100755 sample/sample-scripts/totpauth.py
 create mode 100644 src/openvpn/ssl_util.c
 create mode 100644 src/openvpn/ssl_util.h

-- 
2.26.2


