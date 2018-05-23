References: <20180417165000.3872-1-Jason@...2390...>
 <10978590-889a-0ccc-4cb8-31c862ee565c@...1856...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <33fe1382-9dd6-82b4-1215-7f748e521a48@...1147...>
Date: Wed, 23 May 2018 16:30:20 +0200
MIME-Version: 1.0
In-Reply-To: <10978590-889a-0ccc-4cb8-31c862ee565c@...1856...>
Content-Language: nl-NL
Subject: Re: [Openvpn-devel] [PATCH] Support fingerprint authentication
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

Hi Steffan,

On 17/05/18 20:31, Steffan Karger wrote:
> Hi Jason,
>
> [ Dumping my thoughts so this doesn't remain completely unanswered for
> even longer. ]
>
> On 17-04-18 18:50, Jason A. Donenfeld wrote:
>> OpenVPN traditionally works around CAs. However many TLS-based protocols also
>> allow an alternative simpler mode in which rather than verify certificates
>> against CAs, the certificate itself is hashed and compared against a
>> pre-known set of acceptable hashes. This is usually referred to as
>> "fingerprint verification". It's popular across SMTP servers, IRC servers,
>> XMPP servers, and even in the context of HTTP with pinning.
>>
>> So, I'd like to propose an extremely simple and non-invasive way of
>> supporting this in OpenVPN, by re-using several features that already
>> basically support it. Namely, what I propose is:
>>
>>     * Allow specifying 'none' to the --ca parameter, to specify that
>>       certificates should not be checked against a CA. Note that 'none'
>>       is already used in other similar options as a special placeholder.
>>
>>     * When '--ca none' is in use, --verify-hash checks all depths instead
>>       of just level 1.
>>
>> With these very simple changes, fingerprint authentication is easily achieved
>> via the --tls-verify script on the server and via --verify-hash on the client.
> Adding support for fingerprint authentication sounds like a good idea to
> me.  Even if it was just to simplify config for peer-to-peer and small
> (home) setups by getting rid of the need to create and maintain a CA.
> So: feature Ack.
>
> However, if we were to add this, I think I'd rather make it a
> first-class citizen.  For example by adding a peer fingerprint
> verification option that works in both client and server configs, and is
> mutually exclusive with --ca.  I'd expect such an option to accept an
> (inline-able) file that contains a list of fingerprints, so one can make
> a config like:
>
> <allowed-peers>
> AA:BB:CC:DD:..
> AA:BB:CC:DE:..
> </allowed-peers>
>
> Or maybe base64 fingerprints, because a lot of people have been trained
> by SSH to recognize short base64 strings as fingerprints.
>
> Anyone else from the community that has some thoughts on this?
>
> As for implementation:  I'm already having problems getting to my review
> queue, so am not promising to implement this.  I would definitely put a
> patch for this on my review queue though :)
>
>
I have some strong thoughts on this, mostly related to:  can someone 
explain to me why this is safe?

I've seen that OpenSSH 7.7 now implements something similar (xmss 
hash-based signatures, 
https://tools.ietf.org/html/draft-irtf-cfrg-xmss-hash-based-signatures-12, 
disabled by default) but that works entirely differently from what is 
proposed here; amongst other things, it uses *one time private keys* to 
maximize security - do we want to add something like that to our TLS 
stuff (my gut answer: no).

How can a hash replace a public key, cryptographically speaking? if you 
are not replacing public keys, then who generates, stores, maintains 
these public keys?  What about accounting in such a setup? with 
certificates, you normally hand out a certificate to a person, with the 
name of the person/entity in it. If that person misbehaves, you revoke 
the certificate and presto. Is it sufficient to remove the hash from the 
config? if so, wouldn't it be better to have a directory with 
hash-files, so that you can add and remove hashes without having to 
update the server config and/or restart the server to pick up new hashes?

JM2CW,

JJK


