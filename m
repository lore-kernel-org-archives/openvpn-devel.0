From: Antonio Quartulli <a@...2181...>
Date: Thu, 26 Apr 2018 03:57:14 +0800
Message-Id: <20180425195722.20744-1-a@...2181...>
Subject: [Openvpn-devel] [RFC 0/8] server: support listening on multiple
 ports/IPs
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

This patchset allows a server to listen on multiple sockets
concurrently.

Practically this means that an admin can configure his/her server to
listen on multiple IPs and/or multiple ports at the same time.

The new behaviour can be configured by using an extension of the current
"--local" option.
In particular, the new directive syntax is  "--local IP [port]" and it
can appear multiple times in the same server config. Each occurrence
represents a single socket.

"IP" can be an IPv4, IPv6, an hostname or *.
Multiple "--local" directives can combine all of the above.

The special case "*" will mimic what currently happens on a server when
no "--local" is specified, but in this case it gives a chance to specify
a port.

The special addresses 0.0.0.0 and :: are also allowed and they can be
used to explicitly bind only IPv4 o v6.

If no port is specified, the value coming from "lport" is used
(1194 by default).

At the moment the protocol cannot be customized and the one specified by
the "--proto" directive will always be used.
Future development will aim at making the protocol part of the "--local"
directive and finally have multi protocol support on the same instance.


This patchset is an RFC because it requires feedback and testing,
especially when used in client mode with all kind of weird options.


It currently passes "make check" and our "internal buildbot"
tests.

Interested users can also get this code branch from:
https://github.com/ordex/openvpn/tree/multiport

Cheers,


Antonio Quartulli (8):
  event/multi: add event_arg object to make event handling more generic
  pass link_socket object to i/o functions
  io_work: convert shift argument to uintptr_t
  io_work: pass event_arg object to event handler in case of socket
    event
  allow tcp/udp server to listen on multiple ports at the same time
  if a local IPv6 address is provided, socket must be v6-only
  allow user to specify 'local' multiple times in config files
  override ai_family if 'local' numeric address was specified

 doc/openvpn.8                |  10 +-
 src/openvpn/event.h          |  22 ++++
 src/openvpn/forward-inline.h |  15 ++-
 src/openvpn/forward.c        | 137 +++++++++++++++---------
 src/openvpn/forward.h        |  35 ++++---
 src/openvpn/init.c           | 198 +++++++++++++++++++++++------------
 src/openvpn/init.h           |   3 +-
 src/openvpn/mtcp.c           | 113 ++++++++++++--------
 src/openvpn/mudp.c           |  19 +++-
 src/openvpn/mudp.h           |   6 +-
 src/openvpn/multi.c          |  27 +++--
 src/openvpn/multi.h          |  15 ++-
 src/openvpn/openvpn.c        |   2 +-
 src/openvpn/openvpn.h        |   9 +-
 src/openvpn/options.c        | 162 +++++++++++++++++++++++-----
 src/openvpn/options.h        |  15 ++-
 src/openvpn/ping-inline.h    |   2 +-
 src/openvpn/socket.c         |  55 ++++++++--
 src/openvpn/socket.h         |   8 +-
 19 files changed, 602 insertions(+), 251 deletions(-)

-- 
2.17.0


