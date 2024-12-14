Message-ID: <7e42399c-3a94-40a2-bcaa-15545c3b761c@...68...>
Date: Sun, 15 Dec 2024 00:18:14 +0100
MIME-Version: 1.0
Content-Language: de-CH
From: corubba <corubba@...68...>
Subject: [Openvpn-devel] [PATCH 0/2] proxy protocol v2 for port-share
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hello,

since v2.1 (released 2009) OpenVPN has the "port-share" feature, where
it listens on a tcp port (like 443) and forwards/proxies all incoming
non-OpenVPN connections (like HTTPS) to a different server/port
(hereafter called the "downstream server"). Because this terminates the
tcp connection and the downstream server does not see the actual client
ip, in v2.3 (released 2013) a "journal directory" feature was added
where OpenVPN writes temporary files for every forwarded connection
which the downstream server can use to determine the real client ip.
While this works okay, it has a few drawbacks:

1) Since this is a custom solution, you also need a custom integration
   in the downstream server software to consume the journal files.
2) It is relatively straight forward to use on the same host, getting it
   to work across hosts is more difficult; but not impossible.
3) Because it basically is an side channel, there is the potential for
   race conditions. For example is the journal file written *after* the
   connection to the downstream server is opened, so it may not exist
   yet when the downstream server tries to access/read it.

The goal of this patch set is to add an additional mechanism for
transmitting the real client ip to the downstream server using the
PROXY protocol [0]. It was created by the fine people from HAProxy,
releasing the specification of protocol version 1 in 2010, followed by
version 2 in 2012. OpenVPNs port-share feature behaves like a "dumb
proxy", for which that protocol was designed. Compared to the "journal
directory" feature, it does not suffer from the above-mentioned
drawbacks:

1) Standardized protocol which is natively supported by a wide range of
   software, allowing plug-and-play deployment.
2) Easy to use on the same or across different hosts.
3) Uses in-band transmission, no side-channel required.

The first patch adds normalization of IPv4-mapped IPv6 addresses to
plain IPv4 addresses, which can be seen as a general improvement of the
"journal" feature. The second patch adds the PROXY protocol (version 2)
implementation.

The third patch extends the PROXY protocol implementation beyond what
is currently required. It is not meant to be merged as-is right now, but
only attached for completeness should these features ever be needed.

This patch set was not created out of necessity, but rather as an
exercise while playing around with the port-share feature. Feel free to
consider accepting this patch set without any pressure. I do believe it
has merit thought, and it may be worth considering to go as far as to
completely deprecate/replace the "journal directory" with it.


[0] https://www.haproxy.org/download/1.8/doc/proxy-protocol.txt


Best regards
--
Corubba

