MIME-Version: 1.0
In-Reply-To: <AANLkTim0SDf=7KLqH_BkVwd4UyHLkCUCdn=2ycDRdyNY@...278...>
References: <4D0392A1.3030406@...1114...>
	<AANLkTim0SDf=7KLqH_BkVwd4UyHLkCUCdn=2ycDRdyNY@...278...>
Date: Fri, 21 Jan 2011 08:50:42 -0800
Message-ID: <AANLkTinciwPbV7=j7np45SSBRFNiJDWix12HPEey4U6e@...278...>
From: Blaise Gassend <blaise@...1426...>
Subject: [Openvpn-devel] Fwd:  Follow-up: --tls-float and protocol changes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

I just realized that my reply to Dave's email on floating-tls didn't
go to the list. Here it is below.

---------- Forwarded message ----------
From: Blaise Gassend <blaise@...1426...>
Date: Thu, Dec 16, 2010 at 11:13 PM
Subject: Re: [Openvpn-devel] Follow-up: --tls-float and protocol changes
To: David Sommerseth <openvpn.list@...1114...>


Hi,

Just wanted to put in some quick comments on this floating tls post.
I'm really not convinced by the usefulness of the feature vector
approach.

> To avoid compatibility issues with clients not using --tls-float, a
> separate op-code is used in the scenario when the client sends this
> connection ID. =A0If a server or client receives this op-code and do not
> support it, the packet will be dropped. =A0And, if I have understood it
> correctly, the server will be able to detect if the client is supporting
> - --tls-float or not and will therefore be able to support both clients w=
hich
> supports this feature and not.

Correct. The server can support both types of clients.

> How it works is basically a packet stream which looks like this if
> - --tls-float is enabled [3]:
>
> ~ =A0 TLS_OPCODE | Connection ID | OpenVPN control/data stream

Not quite. It is:
FLOATING_TLS_OPCODE | Connection ID | NORMAL_OPCODE | OpenVPN
control/data stream

The normal packet is completely encapsulated in the floating TLS packet.

> When it comes to the use of an own op-code for --tls-float to work, that =
is
> more tricky. =A0It was identified that the op-code field is only 5 bits[5=
].
> Currently 8 op-codes are already in use, which leaves 23 op-codes availab=
le
> now. =A0Rightfully enough, it is not often you need to extend a protocol =
like
> this, but we know that OpenVPN 3 will most likely extend the protocol even
> further. =A0So to be sure we don't limit us self in the future, the use of
> op-codes needs a broader discussion.

Most enhancements do not require a new opcode. Are there any proposed
OpenVPN 3 enhancements that will require a new opcode? What are they?

75% of opcodes are still free. It doesn't strike me that there is a
scarcity yet. If you actually do run out of opcodes, you can use one
of them as an escape opcode that is followed by an extension opcode,
allowing you to get a whole new set of opcodes (256 for one byte).
Contrast this with the feature vector proposal which is suggesting
using a larger 4 byte feature vector, that will run out after 32
features. The feature vector tradeoff doesn't make sense to me.

Encapsulation arises very naturally by using an extra opcode. Other
ways of achieving the same effect require a patch that is a lot more
intrusive and error prone.

Are there any other examples of features that would be better served
by the feature vector approach than by having options negociated
during session initiation?

> So, why not just let give --tls-float an op-code and skip this feature
> stuff now? (or: let's postpone the feature stuff until we really need it)
> We all agreed that the --tls-float feature is useful in several scenarios,
> but as it was requested this feature will be compile-time disabled by
> default [6]. =A0In my opinion, it would be wasting of an op-code slot if
> a feature is not enabled by default. =A0Therefore I suggest that the
> - --tls-float will use a solution like described above.

Again, I would want to see a case that there actually are other
features that could benefit from their own opcode.

> Why should we spend time and energy implementing a FEAT_OPCODE solution?
> First of all to be sure we can expand the wire-protocol in the future
> without breaking compatibility with older clients.

Adding a new opcode or using an unsupported feature bit will break
compatibility with older clients just as much.

Cheers,
Blaise

