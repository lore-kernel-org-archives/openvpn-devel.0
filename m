MIME-Version: 1.0
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 18 Jul 2024 14:04:09 +0200
Message-ID: <CAGyAFMXbmKKYELg4P4zJkxoHNSB1rt+7zVzG0xTpfp6NbjD48g@...278...>
Subject: [Openvpn-devel] PUSH_UPDATE
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

We've recently discussed internally the PUSH_UPDATE protocol
extension, which is required for corp products, and want to share our
thoughts with the community to ensure that all implementations are in
sync.

Need for PUSH_UPDATE

As we discussed before, there might be a need to push certain options
to the client while the connection is active. The most obvious example
would be new routes or DNS settings. Other options could be
considered, such as ping (suppose the client has switched from a
stable to an unstable connection) or mssfix.

Client Capability Indication

To indicate the client's capability to receive PUSH_UPDATE, the client
sends IV_PROTO_PUSH_UPDATE in IV_PROTO, which is 1<<12.

Combining PUSH_REPLY and PUSH_UPDATE Options

Now we have to define how we should combine options already received
with PUSH_REPLY and PUSH_UPDATE. For example, if we want to push only
a new auth-token or DNS, do we also have to push all other options
such as routes, ifconfig, etc.? My initial thought was to allow only
tun-specific options to be pushed, define them in the RFC, and make it
so that PUSH_UPDATE includes all those options. If some of those were
presented in PUSH_REPLY but missing in PUSH_UPDATE, they will be
undone. This would require the server to always send, for example,
ifconfig. Other options, which are not tun-specific and not listed in
the RFC in the PUSH_UPDATE section (for example, cipher), will be
inherited from PUSH_REPLY and do not have to be re-sent.

Revised Approach for PUSH_UPDATE

After some thinking, we decided that this approach doesn't scale well
and would require constant synchronization between implementations and
RFC. So we agreed that PUSH_UPDATE will replace options with the same
name, which have been previously received by PUSH_REPLY and
PUSH_UPDATE messages. All missing options will be inherited. This
means that if one needs to update DNS settings, it is enough to send
only

  PUSH_UPDATE,dns xxx

For updating routes, one needs to send all route options (yes, if we
had 1000 routes and want to add one more, we would have to send 1001
routes).

Removing Options

This approach would require introducing a way to remove options. For
options which can be presented multiple times, such as route, it is
easy just by sending all routes again except the one we want to
remove. But what about, say, mssfix or if we want to remove all
routes? We propose to add a minus sign before the option name:

  PUSH_UPDATE,-route,-mssfix,ifconfig 10.8.0.4 255.255.255.0

This will push a (new) IP address and remove all routes and mssfix.

Handling Unsupported Options

Next, we need to define what to do if a client supports push updates
but doesn't (yet) support all pushed options. In the end, it is up to
the client to decide to reconnect or just ignore unsupported options.
However, we think that some options are critical, such as new routes
or DNS settings, and some are not, such as ping. Leaving a connection
with sub-optimal keepalive timeouts is not great, but not terrible. On
the other hand, missing routes might result in non-working VPN
connections.

Classifying Options

We propose to classify options as "mandatory" or "optional" and prefix
them. For example, mandatory options could be prefixed with "+". If a
client receives a mandatory option which it cannot act upon, it should
reconnect. Unsupported optional options should be just ignored.
Implementation-wise, options classification could be added later. By
default, we could assume that all options are "optional".

-- 
-Lev

