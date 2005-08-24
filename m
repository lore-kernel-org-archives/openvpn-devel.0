From: James Yonan <jim@...41...>
In-Reply-To: <20050824140000.GJ3666@...441...>
Message-ID: <Pine.LNX.4.58.0508241400250.28422@...41...>
References: <20050824140000.GJ3666@...441...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.0.1 security fixes available as individual & backported
 patches
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Aug 24 13:14:30 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: "Dr. Peter Poeml" <poeml@...441...>
Cc: R P Herrold <herrold@...442...>, openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

Due to several requests, I've put together a set of isolated
patches which fix the individual security issues addressed by OpenVPN 
2.0.1, and which can be applied to any major version of OpenVPN going
back to 1.3.2.

Out of the 4 patches, only CAN-2005-2531 is relevant for the
1.x branch.

These patches will individually apply the specific security fixes
released in OpenVPN 2.0.1 to an OpenVPN 2.0 or 1.x tree.

Patches are available in:

http://openvpn.net/patch/2.0.1-security-patches/

-----------------------------------------

openvpn-2.0-sslerrqfix.patch
openvpn-1.6.0-sslerrqfix.patch (also applicable to 1.5.0)
openvpn-1.4.3-sslerrqfix.patch (also applicable to 1.3.2)

* Security Fix -- DoS attack against server when run with "verb 0" and
  without "tls-auth".  If a client connection to the server fails
  certificate verification, the OpenSSL error queue is not properly
  flushed, which can result in another unrelated client instance on the
  server seeing the error and responding to it, resulting in disconnection
  of the unrelated client (CAN-2005-2531).  Affects OpenVPN 1.x and 2.0.

-----------------------------------------

openvpn-2.0-sslerrqfix.patch

* Security Fix -- DoS attack against server by authenticated client.
  This bug presents a potential DoS attack vector against the server
  which can only be initiated by a connected and authenticated client.
  If the client sends a packet which fails to decrypt on the server,
  the OpenSSL error queue is not properly flushed, which can result in
  another unrelated client instance on the server seeing the error and
  responding to it, resulting in disconnection of the unrelated client
  (CAN-2005-2532).  Affects OpenVPN 2.0 only, 1.x is unaffected.

-----------------------------------------

openvpn-2.0-iroutequota.patch

* Security Fix -- DoS attack against server by authenticated client.
  A malicious client in "dev tap" ethernet bridging mode could
  theoretically flood the server with packets appearing to come from
  hundreds of thousands of different MAC addresses, causing the OpenVPN
  process to deplete system virtual memory as it expands its internal
  routing table.  A --max-routes-per-client directive has been added
  (default=256) to limit the maximum number of routes in OpenVPN's
  internal routing table which can be associated with a given client
  (CAN-2005-2533).  Affects OpenVPN 2.0 only, 1.x is unaffected.

-----------------------------------------

openvpn-2.0-assert-mtcp411.patch

* Security Fix -- DoS attack against server by authenticated client.
  If two or more client machines try to connect to the server at the
  same time via TCP, using the same client certificate, and when
  --duplicate-cn is not enabled on the server, a race condition can
  crash the server with "Assertion failed at mtcp.c:411"
  (CAN-2005-2534).  Affects OpenVPN 2.0 only, 1.x is unaffected.

-----------------------------------------

James

