Message-ID: <4D0392A1.3030406@...1114...>
Date: Sat, 11 Dec 2010 16:02:57 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Follow-up: --tls-float and protocol changes
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
To: Openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


In the developers meeting December 2 the patch introducing a --tls-float
feature was discussed.  The feature itself seems reasonable for several
scenarios and makes it possible for a client to change IP address without
needing to re-negotiate the TLS connection [1].

The implementation itself was discussed with James Yonan and the conclusion
was that it was reasonable to prepends a connection ID field in front of
the control and data packets [2].  The server will then use this
connection ID instead of the IP address, as it does today.

To avoid compatibility issues with clients not using --tls-float, a
separate op-code is used in the scenario when the client sends this
connection ID.  If a server or client receives this op-code and do not
support it, the packet will be dropped.  And, if I have understood it
correctly, the server will be able to detect if the client is supporting
- --tls-float or not and will therefore be able to support both clients which
supports this feature and not.

How it works is basically a packet stream which looks like this if
- --tls-float is enabled [3]:

~   TLS_OPCODE | Connection ID | OpenVPN control/data stream

When it is not enabled [4]:

~   "NORMAL_OPCODE" | OpenVPN control/data stream

When it comes to the use of an own op-code for --tls-float to work, that is
more tricky.  It was identified that the op-code field is only 5 bits[5].
Currently 8 op-codes are already in use, which leaves 23 op-codes available
now.  Rightfully enough, it is not often you need to extend a protocol like
this, but we know that OpenVPN 3 will most likely extend the protocol even
further.  So to be sure we don't limit us self in the future, the use of
op-codes needs a broader discussion.

What I am proposing is a separate op-code instead of the TLS_OPCODE which
will give a feature bit-set which can be used to enable different features,
like --tls-float.

The idea is to do it something like this:

~   FEAT_OPCODE | feature_bits | <feature data...> | OpenVPN control/data

The feature_bits section can be f.ex. 32 or 64 bits.  And a bit here can
be used identify that --tls-float is enabled.  A data stream which only
have that FEATURE_OPCODE in use with only the TLS_FLOAT bit set will then
look like this:

~   FEAT_OPCODE | feature(tls_float) | ConnectionID | OpenVPN control/data

If feature X is used in addition, the stream will look like this:

~   FEAT_OPCODE | feature(tls_float,X) | ConnectionID | X-data | OpenVPN data

In this example, it's considered that tls_float is the first bit and X is
the second bit.  One bit can even be set to indicate that there are more
feature bits coming, thus the protocol would be more dynamically
expandable.

The downside of this is that if the feature bits will give more overhead to
the data stream.  A 64 bit mask (8 bytes) might be way too much.  Therefore
a 32bit mask (4 bytes) might be more reasonable.  Maybe even 16 bits, where
one bit is reserved for feature bits chaining.

However, as these feature bits are flexible, the feature data do not need
to be sent over constantly.  And if there are no feature_bits set, the
"NORMAL_OPCODE" will be used instead.  Due to this, protocol compatibility
with older clients should be preserved as well, just as the current
- --tls-float implementation.

Another thing to beware of is that as these feature bits are sent outside
the OpenVPN control/data stream, so these feature data bytes will not be
encrypted.  If the data needs to be encrypted, it should use the control
channel in OpenVPN instead.  But as the --tls-float feature shows,
sometimes the data cannot be encrypted to work.

It will be the "packet parser" which will be responsible for mux/demux
of these data streams.  With a clever (re-?)design of the current code, it
should be pretty straight forward to also make this part more modular so
that even a third-party plug-in can register itself to this packet
parser.  This registration process will indicate which bit it will use.
The packet parser can then send parts of the data stream to the plug-in
and it will report back how many bytes it read of the stream.

Of course, this plug-in support of protocol features must be discussed in
more details, as there are many flaws here.  Compatibility between
client/server if they don't use/support a feature or conflicting feature
bits.  Those details are a different discussion and will need to come in
the next phase, when the --tls-float solution is decided upon.


So, why not just let give --tls-float an op-code and skip this feature
stuff now? (or: let's postpone the feature stuff until we really need it)
We all agreed that the --tls-float feature is useful in several scenarios,
but as it was requested this feature will be compile-time disabled by
default [6].  In my opinion, it would be wasting of an op-code slot if
a feature is not enabled by default.  Therefore I suggest that the
- --tls-float will use a solution like described above.

Why should we spend time and energy implementing a FEAT_OPCODE solution?
First of all to be sure we can expand the wire-protocol in the future
without breaking compatibility with older clients.  Secondly, OpenVPN 3 will
be more modular and flexible so we might see completely different use-cases
than we can imagine today.

It might even be that we need to implement a more advanced control channel
for OpenVPN 3 to support more new features.  In this case, we set a
"openvpn3" feature bit, and encrypt that kind of data separately and put it
in the stream.  That way we can support both the old and the new data
stream simultaneously.  Old clients will not see the OpenVPN v3 control
data, as they don't support it.  And newer clients will receive these data
and can make use of it.


Kind regards,

David Sommerseth



Meeting minutes:
<http://thread.gmane.org/gmane.network.openvpn.devel/4221>

[1] See meeting minutes, 20:17:08 to 20:19:16 and 20:49:25.
[2] See meeting minutes, 20:40:50
[3] See meeting minutes, 21:04:48
[4] See meeting minutes, 21:05:02
[5] See meeting minutes, 21:02:08
[6] See meeting minutes, 20:49:25
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0DkqEACgkQDC186MBRfrqTJwCfW677y4JbjmPlXpU4c63ydbh8
Bu0AoKF/E+4U2LQk1OCWBwiZQRGMREtM
=giIu
-----END PGP SIGNATURE-----

