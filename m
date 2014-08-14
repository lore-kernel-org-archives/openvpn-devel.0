MIME-Version: 1.0
Date: Thu, 14 Aug 2014 08:00:38 +0000
Message-ID: <CAGyAFMVnFsowuvJayx5sSv6-XzTTWWfBP4Wv4e8aMNbP9yPrkQ@...278...>
From: Lev Stipakov <lstipakov@...277...>
Subject: [Openvpn-devel] Possible memory leaks found by Coverity
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hello,

I have analyzed OpenVPN code with Coverity and I could not explain
some resource leaks Coverity has found.

1) https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/options.c#L4378

char * ipv6_local;
VERIFY_PERMISSION (OPT_P_UP);
if ( get_ipv6_addr( p[1], NULL, &netbits, &ipv6_local, msglevel ) &&
ipv6_addr_safe( p[2] ) ) {
  if ( netbits < 64 || netbits > 124 ) {
    msg( msglevel, "ifconfig-ipv6: /netbits must be between 64 and
124, not '/%d'", netbits );
    goto err;
  }

Coverity claims that "err" branch leaks "ipv6_local". I looked into
"get_ipv6_addr" implementation and noticed that it does not pass any
"gc" to subsequent string_alloc call. To my understanding, in this
case caller is responsible for cleaning up, which is not the case for
"err" branch.


2) https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/proxy.c#L863

char *pa = NULL;
const int method = get_proxy_authenticate(sd, p->options.timeout, &pa,
NULL, signal_received);
if (method != HTTP_AUTH_NONE) {
  if (pa)
    msg (D_PROXY, "HTTP proxy authenticate '%s'", pa);
    if (p->options.auth_retry == PAR_NCT && method == HTTP_AUTH_BASIC) {
      msg (D_PROXY, "HTTP proxy: support for basic auth and other
cleartext proxy auth methods is disabled");
      goto error;
    }

Coverity claims that "error" branch leaks "pa". Same pattern as above,
"get_proxy_authenticate" passes NULL (4th parameter) as "gc" to
"string_alloc".

Do those issues look like problems? Does it make sense to submit a
patch fixing those?

-- 
-Lev

