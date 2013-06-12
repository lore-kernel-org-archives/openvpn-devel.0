Message-ID: <51B8CE21.6080203@...515...>
Date: Wed, 12 Jun 2013 13:38:09 -0600
From: James Yonan <james@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN Versioning
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

I'm going to present some ideas and patches to make OpenVPN more solid 
in the area of versioning.  The overall goal is to make OpenVPN more 
robust with respect to differences between client and server in OpenVPN 
version, TLS version, protocol capabilities, and config file grammar.

Specifically:

1. Allow one OpenVPN config file to be universally used by different 
clients on different platforms, even if some of the directives target 
capabilities only available in newer OpenVPN versions or specific kinds 
of platforms (i.e. mobile).

2. Allow TLS versions higher than 1.0 to be negotiated when both client 
and server support them.

3. Improve the flexibility of the OpenVPN protocol negotiation so that 
parameters such as cipher and HMAC digest can be dynamically negotiated.

Versioning robustness is also a practical security feature, because it 
allows gradual rollout of updated security parameters in a large network 
without loss of service.  Security parameters might include minimum TLS 
version, allowed TLS ciphersuites, and OpenVPN cipher and HMAC digests.


Specific use case examples
--------------------------

(1) OpenVPN protocol negotiation: You are managing an OpenVPN server 
configured with the BF-128-CBC cipher.  You want to upgrade to 
AES-128-CBC to take advantage of hardware AES acceleration on the 
server, but not all clients in the field support AES yet.  With cipher 
negotiation, you could set up a mechanism where the server would 
negotiate AES-128-CBC with clients that support it, but downgrade to 
BF-128-CBC on clients that don't support either AES or the cipher 
negotiation capability itself.

(2) TLS version negotiation: You are managing an OpenVPN network and 
want to migrate to TLS 1.2 but still allow older clients to connect with 
TLS 1.0 for some period of time until it is phased out.

(3) Config file grammar: You are a developer and want to add a new 
OpenVPN config file directive, but don't want older clients to abort 
because they don't understand the directive.

Within these use cases are three areas where versioning is an issue, and 
I'll discuss each of them separately:

TLS Protocol
------------

Since day 1, OpenVPN has used TLS 1.0 as a control channel and key 
exchange mechanism.  But now we have TLS 1.1 and 1.2, each of which 
addresses significant shortcomings in its predecessor.  Fortunately, 
SSL/TLS already includes dynamic version negotiation.  So I've put 
together a patch that leverages on this, by allowing OpenVPN client and 
server to negotiate the TLS version and use the highest version 
supported by both peers.  The patch also adds a new directive 
"tls-version-min" that allows either client or server to specify a 
minimum required TLS version from the peer.

https://github.com/jamesyonan/openvpn/commit/6ee8faade224cc346d67a7f1716df4012782999a

OpenVPN Protocol
----------------

The OpenVPN protocol did not originally support handshaking, i.e. having 
the client and server mutually communicate their capabilities and use 
this info to dynamically select protocol parameters such as cipher, HMAC 
digest, compression algorithm, etc.

Instead of handshaking, we would manually add compatible directives to 
both client and server configs.  But this approach is not very flexible, 
because in the absence of a handshaked protocol negotiation, every time 
a configuration change is made on the server that affects the protocol 
(such as cipher type), all of the client configs must also be upgraded 
or they will fail to connect.

To improve flexibility, we've gradually increased the amount of 
handshaking that occurs in the OpenVPN protocol.  For example, with the 
recent addition of the Snappy compression algorithm, we now have a 
mechanism where the compression algorithm can be dynamically negotiated 
between client and server.

The basic mechanism for how this works is as follows:

After the TLS negotiation has succeeded but before the tunnel is active, 
the client communicates its capabilities to the server using a list of 
key/value pairs sent over the TLS control channel.  We will call this 
the Client Capabilities List (which itself was introduced in OpenVPN 2.1 
and was added to the OpenVPN protocol in a way that older clients would 
ignore it).

For example, running an OpenVPN 3.0 client on my mac, the following 
key/value pairs are sent to the server.

   IV_VER=3.0
   IV_PLAT=mac
   IV_SNAPPY=1
   IV_LZO=1

This tells the server that the client supports both Snappy and LZO 
compression protocols.  Now that the server knows this, it can choose a 
protocol that it also supports, and communicate this back to the client 
via a pushed directive:

   compress snappy

With this model, the client suggests a list of capabilities that it is 
willing to support, and the server makes the final selection from that 
list.  But this also gives the client some discretion, as it can choose 
to veto certain capabilities by not including them in the list sent to 
the server.  For example, suppose the client end-user chooses to disable 
compression.  In this case, the client will simply tell the server that 
it doesn't support compression, i.e.

   IV_VER=3.0
   IV_PLAT=mac
   IV_LZO_STUB=1
   IV_COMP_STUB=1

The "STUB" parameters indicate support for null compression algorithms 
that include the compression framing byte, but don't actually compress 
any data.

So this basic model of the client sending a key/value list of protocol 
capabilities to the server, and the server responding with push 
directives to select the actual protocol feature can be a basic building 
block for adding additional negotiated features to the OpenVPN protocol.

For example, this model could be used to negotiate other protocol 
capabilities such as cipher and HMAC digest:

   IV_CIPHER=BF-CBC,AES-128-CBC
   IV_AUTH=SHA1,SHA256,SHA512

After receiving this info from the client, the server could choose a 
cipher and auth parameter and push it back to the client.  Among other 
things, this requires that the client supports pushed "cipher" and 
"auth" directives (currently only the 3.0 core supports this).  There is 
also the issue of the size of the Client Capabilities List.  The 
IV_CIPHER and IV_AUTH lists might grow to be quite long, and the current 
Client Capabilities List is limited in size to 2048 bytes based on the 
TLS_CHANNEL_BUF_SIZE constant in common.h.  To reduce the size, we might 
consider:

(a) use a single character designation for ciphers and HMAC digests, 
such as:

Cipher Codes:
  A : BF-CBC
  B : AES-128-CBC
  . . .

Then communicate IV_CIPHER using the cipher codes:

   IV_CIPHER=AB

This would require that the OpenVPN Project standardize on set of codes 
for ciphers and HMAC digests.

(b) remove the 2048 byte limitation on the Client Capabilities List. 
The limitation arises because of the packetization of messages over the 
OpenVPN control channel.  One way to resolve this would be to 
standardize on a continuation marker that tells the peer that another 
packet of Client Capabilities List data is forthcoming.  This would be 
similar to how the same problem was solved with the pushed directives 
list using continuations.

Rather than choosing either (a) or (b) I would suggest implementing them 
both.  The number of ciphers and digests is always increasing and using 
a one or two-character code to denote a cipher or digest will make the 
Client Capabilities List smaller and faster to pass over the wire.  It 
would also be good to fix (b) since it seems like an arbitrary 
limitation that could cause issues as the Client Capabilities List grows.

Config file grammar
-------------------

Originally, OpenVPN was strict about config file directives that it 
didn't recognize -- it was a fatal error to specify an unrecognized 
directive.

In many cases this is beneficial for security in the sense that a 
directive such as ns-cert-type or tls-remote, if not understood by the 
client and ignored, could render the connection much less secure than 
intended.

But it also reduces flexibility because it makes adding new directives 
unnecessarily difficult if the new directive crashes an older client 
that doesn't yet recognize it.

One solution that was introduced in OpenVPN 2.1 added a new directive 
that would cause any unrecognized directive to be ignored.

   setenv FORWARD_COMPATIBLE 1

In hindsight, this is probably too broad.  It would be better to allow 
individual directives to specify whether older clients that don't 
recognize them should ignore them or abort.

I've put together a new (and very small) patch that I believe solves the 
problem in a better way.

https://github.com/jamesyonan/openvpn/commit/037690df22a4604a556c9b470d1f5e891991834b

This patch defines a new directive prefix "setenv opt" that if prepended 
to an existing directive, will cause it to be ignored by clients that 
don't understand it (starting the directive with "setenv" is useful 
because OpenVPN clients going back to 2.0 don't really care what comes 
after the "setenv", so older clients should simply ignore the prefix).

To look at an example, the TLS versioning patch above adds a new 
directive "tls-version-min" to set the minimum allowed TLS version used 
by the peer.  Example client usage might be:

   tls-version-min 1.2

Suppose I want to put this directive in the config files I distribute to 
clients, but have it be ignored by older clients that don't recognize 
it.  I could do this as follows on the client:

   setenv opt tls-version-min 1.2

Suppose I also want to handle the case where some clients understand the 
tls-version-min directive but are not linked with an SSL library that 
supports TLS 1.2.  To allow these clients to gracefully degrade to the 
highest TLS version they can support, a variation of the directive could 
be used on the client:

   setenv opt tls-version-min 1.2 or-highest

Now suppose that after some upgrade period, we now want to require that 
all clients connect at TLS 1.2 or higher, and that 1.1 and 1.0 are no 
longer allowed.  This can be done by limiting TLS to 1.2 or higher on 
the server:

   tls-version-min 1.2

James

