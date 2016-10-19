From: Antonio Quartulli <a@...2181...>
Date: Wed, 19 Oct 2016 14:22:28 +0800
Message-Id: <20161019062231.2845-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 0/3] implement crl-persist logic
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
Cc: Antonio Quartulli <a@...2181...>

Hello OpenVPN community,

this is my first contribution (attempt) to the OpenVPN project.
Please be gentle ;)

With this small patchset I am introducing a simple logic that
reduces the overall client connection time when the CRL file is quite big.

Basically it consists in pre-loading the CRL file and storing it in the
OpenVPN context, so that it can be later re-used for faster lookups.

The connection delay in my tests has dropped significantly (I am using a 143MB
large CRL file having around 5 million entries).
Basically the delay (about 5 seconds on average) is moved from "every" client
connection event to the instance bootup (or file reload).

This new behaviour can be enabled by specifying "--crl-persist" after the
"--crl-file" option.

As of now, the CRL is updated only upon SIGHUP. Later this could be improved
by hooking the update to another signal (i.e. SIGUSR2), or when stat() would
detect a file update or even hook into inotify.

Patch 1 introduces the general logic in the openvpn code, like the new config
option and the hooks to the crypto modules.

Patch 2 implements the related functions in the mbedTLS module.

Patch 3 implements the related functions in the OpenSSL module.

(Please check the specific patch commit messages for more details).

Please, have a look at my style and the way I used the various data structures.
Being this my first time into the OpenVPN code base, I may have misused
some objects like "c1" and similar..

Comments are welcome!


Cheers,


Antonio Quartulli (3):
  openvpn: implement crl-persist logic
  mbedtls: implement crl-persist related functions
  openssl: implement crl-persist related functions

 src/openvpn/init.c               |   7 ++
 src/openvpn/openvpn.h            |   6 ++
 src/openvpn/options.c            |  21 +++++
 src/openvpn/ssl_common.h         |  23 ++++-
 src/openvpn/ssl_verify.c         |   5 ++
 src/openvpn/ssl_verify_backend.h |  31 +++++++
 src/openvpn/ssl_verify_mbedtls.c | 102 ++++++++++++++++++----
 src/openvpn/ssl_verify_openssl.c | 183 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 355 insertions(+), 23 deletions(-)

-- 
2.10.1


