Message-ID: <51C113CE.90809@...515...>
Date: Tue, 18 Jun 2013 20:13:34 -0600
From: James Yonan <james@...515...>
MIME-Version: 1.0
References: <51B8CE21.6080203@...515...>
	<1CED409804E2164C8104F9E623B08B9014555DB21A@...1436...>
	<51BB74B2.9020809@...515...>
	<1CED409804E2164C8104F9E623B08B901455BF7221@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B901455BF7221@...1436...>
Subject: Re: [Openvpn-devel] OpenVPN Versioning
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
To: Joachim Schipper <joachim.schipper@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 18/06/2013 01:41, Joachim Schipper wrote:
> From: James Yonan <james@...515...>:
>> On 14/06/2013 02:47, Joachim Schipper wrote:
>>> >From James Yonan <james@...515...>:
>>>> TLS Protocol
>>>> ------------
>>>>
>>>> Since day 1, OpenVPN has used TLS 1.0 as a control channel and key
>>>> exchange mechanism.  But now we have TLS 1.1 and 1.2, each of which
>>>> addresses significant shortcomings in its predecessor.  Fortunately,
>>>> SSL/TLS already includes dynamic version negotiation.  So I've put
>>>> together a patch that leverages on this, by allowing OpenVPN client
>>>> and server to negotiate the TLS version and use the highest version
>>>> supported by both peers.  The patch also adds a new directive "tls-
>>>> version-min" that allows either client or server to specify a
>> minimum
>>>> required TLS version from the peer.
>>>>
>>>>
>> https://github.com/jamesyonan/openvpn/commit/6ee8faade224cc346d67a7f1
>>>> 7
>>>> 1
>>>> 6df4012782999a
>
> [snip: SSL negotiation. Thanks for the explanation; I agree that speaking
> the highest supported protocol is good.]
>
>>> I'm not sure what purpose the "or-highest" serves. Clients already
>> connect with the newest protocol supported by both client and server;
>> if you want to run a TLSv1.2-only network, just set min-version to 1.2
>> on the server. (...)
>>
>> Suppose a server admin wants to upgrade to TLS 1.2 over some transition
>> period, to allow time to upgrade existing clients in the field.
>
>> The overall goal here is to provide tools that allow a controlled
>> rollout of TLS 1.2 that doesn't break any clients during the rollout
>> period, and to upgrade to 1.2 in a way that doesn't create the
>> potential for MiTM version rollback attacks.
>
> But no modern SSL protocol allows version rollback attacks: modern
> implementations will always speak the highest supported/configured protocol
> version between each other. (Only) SSLv2 allows rollback attacks, which is
> why the only sane way to deal with SSLv2 in 2013 is to unconditionally
> disable support.

Right, and the patch is able to unconditionally disable support for SSL 
2 and 3 since these were never supported by even the earliest versions 
of OpenVPN.

>>> The switch(tls_version_min) needs a default case, just compile the
>> first case/default: unconditionally.
>>
>> There is a default case already -- it's right under "case
>> TLS_VER_1_0:".
>
> Yes, but that's #ifdef'ed. I'd be happier if the default case remained
> present even if PolarSSL foolishly decides to drop TLSv1 support.

Agreed -- there shouldn't be any implicit assumption
that SSL lib might not implement TLS 1.0.

https://github.com/jamesyonan/openvpn/commit/d23005413b0e0f28a3c48a6342f494763d5c9b40

> [snip: ciphersuites]
>>> Negotiating ciphers might be fatal in some configurations that were a
>>> bad idea to begin with. E.g. if you use OpenVPN with a static key and
>>> --auth none (which is a bad idea!), adding this negotation could
>> allow
>>> an attacker to set the cipher to none or, more dangerously, to a very
>>> weak cipher like DES (provided it is mutually supported). An attacker
>>> could then bruteforce the key and use his knowledge of 56 bits of the
>>> key to attack stronger protocols like AES or 3DES. (Or do we only
>>> negotiate in SSL mode? I must admit to being fuzzy on the non-SSL
>>> mode.)
>>
>> Static key mode has no negotiation.
>>
>> Agreed that any negotiation model must have constraints placed on the
>> security of the negotiated cipher and HMAC digest.  You would probably
>> want to disable "cipher none" or "auth none" on the presumption that
>> users who want a cleartext tunnel would explicitly configure the client
>> and server for this.
>
> Sure. Just disabling negotiations unless you have an SSL'd control channel
> works fine against this.
>
>> One thing to keep in mind is that OpenVPN protocol negotiation occurs
>> over the already-negotiated TLS session, so it is immune to being
>> tampered with by a MiTM.  This is in contrast to SSL/TLS where a MiTM
>> can affect the negotiation.
>
> As above, MiTM attackers cannot effect the negotiation step in SSL/TLS
> protocols after SSLv2, except trivially (by causing the negotiation to fail, possibly a couple of protocol steps later, e.g. by dropping all packets.)

Aha, that's good to know.  Apparently browsers are still vulnerable to 
version rollback attacks due to compatibility fallback mechanisms, but 
that's great that SSL/TLS protocols are immune above SSL 3.  There's a 
good writeup on the subject here:

http://www.carbonwind.net/blog/post/Random-SSLTLS-101%E2%80%93SSLTLS-version-rollbacks-and-browsers.aspx

James

