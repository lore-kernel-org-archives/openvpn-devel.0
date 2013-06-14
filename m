Message-ID: <51BB74B2.9020809@...515...>
Date: Fri, 14 Jun 2013 13:53:22 -0600
From: James Yonan <james@...515...>
MIME-Version: 1.0
References: <51B8CE21.6080203@...515...>
	<1CED409804E2164C8104F9E623B08B9014555DB21A@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B9014555DB21A@...1436...>
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

On 14/06/2013 02:47, Joachim Schipper wrote:
>>From James Yonan <james@...515...>:
>> TLS Protocol
>> ------------
>>
>> Since day 1, OpenVPN has used TLS 1.0 as a control channel and key
>> exchange mechanism.  But now we have TLS 1.1 and 1.2, each of which
>> addresses significant shortcomings in its predecessor.  Fortunately,
>> SSL/TLS already includes dynamic version negotiation.  So I've put
>> together a patch that leverages on this, by allowing OpenVPN client
>> and server to negotiate the TLS version and use the highest version
>> supported by both peers.  The patch also adds a new directive "tls-
>> version-min" that allows either client or server to specify a minimum
>> required TLS version from the peer.
>>
>> https://github.com/jamesyonan/openvpn/commit/6ee8faade224cc346d67a7f17
>> 1
>> 6df4012782999a
>
> Some comments on the design and implementation here. (I've just looked at the code, not tested it.)
>
> I'm confused by your comments about TLS/SSL versions used. Our own builds using PolarSSL do negotiate TLSv1.1 and TLSv1.2 between themselves and when interoperating with OpenSSL, logging "Control Channel: TLSv1.1, cipher XXX" or even "Control Channel: TLSv1.2, cipher XXX". In general, the highest version supported by both client and server is used, as is normally the case with SSL. However, stock Ubuntu OpenVPN seems to negotiate TLSv1. Huh?

PolarSSL dynamically negotiates the TLS version within the bounds set by 
ssl_set_min_version and ssl_set_max_version.  If these methods haven't 
been called, as is the case with OpenVPN 2.3.2 and earlier, then the 
highest version supported by both peers will be used.  So even in the 
absence of my patch, PolarSSL if used by both client and server, could 
negotiate a higher version than TLS 1.0.

OpenSSL, however, does not appear to negotiate a version other than TLS 
1.0 if TLSv1_server_method() or TLSv1_client_method() is passed to 
SSL_CTX_new, as is done by all versions of OpenVPN up to 2.3.2.

To get the adaptive versioning behavior in OpenSSL, you have to use 
SSLv23_server_method() or SSLv23_client_method() and then explicitly 
disable the versions you don't want to consider, i.e. SSL_OP_NO_SSLv2, 
SSL_OP_NO_SSLv3, SSL_OP_NO_TLSv1, SSL_OP_NO_TLSv1_1, etc.

> I'm not sure what purpose the "or-highest" serves. Clients already connect with the newest protocol supported by both client and server; if you want to run a TLSv1.2-only network, just set min-version to 1.2 on the server. If you're an especially competent and paranoid user, you might want to set min-version on the client, but in that case you hardly need an "or-highest", since you know which cipher suites your client supports.

Suppose a server admin wants to upgrade to TLS 1.2 over some transition 
period, to allow time to upgrade existing clients in the field.

At the end of the transition period, tls-version-min 1.2 would be added 
to the server config, but this can't be done immediately or it might 
lock out older clients (using TLS 1.0) before they have a chance to upgrade.

So a transition plan could start by distributing client config files 
containing:

   setenv opt tls-version-min 1.2 or-highest

Older OpenVPN versions that don't understand tls-version-min would 
simply ignore it, under the presumption that these clients would be 
upgraded before the end of the transition period.

Newer versions of OpenVPN that understand tls-version-min and are linked 
with SSL libraries that support TLS 1.2 would force a TLS 1.2 connection 
with server, so they would be immune to any version rollback attack 
where a MiTM tries to force a lower version negotiation.

However there is a middle ground here:  what about OpenVPN clients that 
understand tls-version-min but are not linked with an SSL library that 
implements TLS 1.2.  The "or-highest" tells the client to use the 
highest TLS version supported by their SSL library as the 
tls-version-min parameter.

If "or-highest" wasn't used, and the SSL lib doesn't implement TLS 1.2, 
then an error would be given that TLS 1.2 is an unrecognized TLS version.

The overall goal here is to provide tools that allow a controlled 
rollout of TLS 1.2 that doesn't break any clients during the rollout 
period, and to upgrade to 1.2 in a way that doesn't create the potential 
for MiTM version rollback attacks.

> Some of the whitespace looks odd/wrong.

Ok.

> Does the change to key_state_ssl_init() do anything?

I had to add ssl_flags (containing tls-version-min parameter) to 
key_state_ssl_init because that seems like the most appropriate place to 
configure tls-version-min for PolarSSL.

For OpenSSL, tls_ctx_set_options is the right place to configure 
tls-version-min.

> The variables polar_{major,minor} in ssl_polarssl.c should be renamed, probably to something like ssl_{major,minor}_version - it's not a PolarSSL version.

Sure.

> The switch(tls_version_min) needs a default case, just compile the first case/default: unconditionally.

There is a default case already -- it's right under "case TLS_VER_1_0:".

>
>> OpenVPN Protocol
>> ----------------
>
>> [Handshaking] could be used to negotiate other protocol capabilities
>> such as cipher and HMAC digest:
>>
>>     IV_CIPHER=BF-CBC,AES-128-CBC
>>     IV_AUTH=SHA1,SHA256,SHA512
>>
>> (...) There
>> is also the issue of the size of the Client Capabilities List.  The
>> IV_CIPHER and IV_AUTH lists might grow to be quite long (...) To
>> reduce the size, we might
>> consider:
>>
>> (a) use a single character designation for ciphers and HMAC digests,
>> such as:
>>
>> Cipher Codes:
>>    A : BF-CBC
>>    B : AES-128-CBC
>>    . . .
>>
>> Then communicate IV_CIPHER using the cipher codes:
>>
>>     IV_CIPHER=AB
>>
>> This would require that the OpenVPN Project standardize on set of
>> codes for ciphers and HMAC digests.
>
> This is a good idea in general, but why not use SSL cipher suites (which already have standardized binary representations)? That has the added advantage of itting AEAD suites like AES-GCM, which are getting more important. (We may need to add some, but note that the { 0xff, X } "namespace" is available for "local and experimental" cipher suites.)

I do like the idea of using SSL ciphersuites.  There are two ways this 
could be done:

(1) extract cipher/auth parameters from the ciphersuite name, using some 
sort of lookup table.  The problem here is that some SSL ciphersuites 
might not be implemented yet in OpenVPN.  For example, if the TLS 
ciphersuite is AES-GCM, it would require a version of OpenVPN that 
understands GCM mode.  Another way to handle this would be to have the 
OpenVPN peer limit the ciphersuites it advertises/accepts to those which 
have a supported cipher/auth translation in OpenVPN.

(2) have OpenVPN actually encrypt/decrypt/MAC data channel packets using 
the ciphersuite algorithm implementation in the underlying SSL library. 
  The main issue here is that SSL implementations don't generally expose 
an API allowing library clients to directly access the ciphersuite 
algorithm implementations.

> Negotiating ciphers might be fatal in some configurations that were a bad idea to begin with. E.g. if you use OpenVPN with a static key and --auth none (which is a bad idea!), adding this negotation could allow an attacker to set the cipher to none or, more dangerously, to a very weak cipher like DES (provided it is mutually supported). An attacker could then bruteforce the key and use his knowledge of 56 bits of the key to attack stronger protocols like AES or 3DES. (Or do we only negotiate in SSL mode? I must admit to being fuzzy on the non-SSL mode.)

Static key mode has no negotiation.

Agreed that any negotiation model must have constraints placed on the 
security of the negotiated cipher and HMAC digest.  You would probably 
want to disable "cipher none" or "auth none" on the presumption that 
users who want a cleartext tunnel would explicitly configure the client 
and server for this.

One thing to keep in mind is that OpenVPN protocol negotiation occurs 
over the already-negotiated TLS session, so it is immune to being 
tampered with by a MiTM.  This is in contrast to SSL/TLS where a MiTM 
can affect the negotiation.

James

