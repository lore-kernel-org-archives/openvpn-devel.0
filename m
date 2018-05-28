References: <20180417165000.3872-1-Jason@...2390...>
 <10978590-889a-0ccc-4cb8-31c862ee565c@...1856...>
 <33fe1382-9dd6-82b4-1215-7f748e521a48@...1147...>
 <fd348cf4-8d17-24b1-cace-f238d319c550@...1227...>
 <03f8402c-a603-3405-543a-e5eaa1ebc224@...1147...>
 <1d803ca0-2f28-585c-eeca-4c64ac2d745f@...1227...>
 <d8fe4a16-fc48-f1f9-3d4d-b82a906bb322@...2080...>
 <99D61A626FDA8A4B90A270669121BE1086A96359@...2294...>
 <82af2541-5e7a-7ba3-5fea-e11f6a2aa52e@...1147...>
 <CAKuzo_j_W0Op+hN6p4muUhrdi42Vib44Vi_7zFtaG9SRMcb0-g@...278...>
 <eb1f2d00-6780-899d-7c1e-61a771350c31@...1147...>
 <99D61A626FDA8A4B90A270669121BE1086A99E72@...2294...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <a549cef5-4775-5b65-e160-ba9fc8e653cf@...1147...>
Date: Mon, 28 May 2018 17:52:48 +0200
MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE1086A99E72@...2294...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Support fingerprint authentication
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Simon Rozman <simon@...2293...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi all,

On 25/05/18 22:56, Simon Rozman wrote:
>>> JJK, I think you are misreading this proposal. No hash is being sent
>>> as a part of the handshake  -- its still client and server
>>> certificates that are exchanged and checked during handshake. The hash
>>> is exchanged by a separate channel (say snail mail:) in advance, and
>>> serves the purpose of establishing trust (ie., the prior knowledge of
>>> hash replaces the prior knowledge of a trusted CA). How the hash is
>>> exchanged is beyond the scope of openvpn or TLS handshake in this
>>> case.
> Right to the point, Selva. This is the best description of this proposal.
>
>> no, I've heard a lot and talked a lot about this proposal before it ended up
>> on
>> the list. I do know what the purpose is, it's just that I have serious
>> doubts
>> about replacing
>>     ( pub/priv key plus  'trust anchors' such as CA certificates ) by
>>     ( we all trust each other because we know each other's SHA2 hashes )
>> There are downsides to a PKI with certificates but I think we're throwing
>> out
>> too much of the good stuff by allowing "just a hash" as the basis for
>> trust.  And one of my main concerns is that people keep comparing it to
>> "that's just like how SSH does it" - *THAT* is simply not true.
> JJK, I am sorry I brought SSH as an example. I didn't mean "exactly" like SSH.
> Just, "kind of like" SSH.
>
> In this proposal, we leave the TLS handshake to handle public key exchange as
> usual. No need to modify client<->server communication.
> The only difference is how server and client verify peer's certificate
> validity. Normally, they check peer's certificate fields like "Not valid
> before", "Not valid after", "Issued By" etc. In this proposal, they'd only
> check peer certificate by its SHA thumbprint - and skip all other standard
> certificate checks.
>
> This would allow you to have a CA-less OpenVPN setup:
> - Make self-signed certificate on server and each client (with like 100 years
> validity),
> - Deploy server certificate hash in client.ovpn,
> - List acceptable client certificate hashes in server.ovpn (Or use an external
> script to do the hash lookup)
>
>

this discussion has muddled along both off and on this mailing list. I apologize in advance for being nitpicky, but when 
touching the "core" security layer of OpenVPN I think we need to be very careful and express very carefully and precisely what 
it is we want to add/change/remove.

As far as I can now oversee, what the original (off-list) proposal has boiled down (or watered down) to now, is

1. wouldn't it be great to allow users to specify self-signed certificates instead of having to use a full-blown PKI or CA 
certificate?
For this, an option like "ca none" would useful, esp since this is explicitly allowed since the TLV v1.1 spec (before that, it 
was not clear whether it was allowed or not).
Therefore, I tend to ACK the feature request to allow an 'empty' CA list, so that people can more easily use self-signed certs.

Note that it currently is possible to come close to using self-signed certs, by creating CA certificates and use those as 
host/client certs as well (I will need to test this a bit further on different platforms, and I have no clue how mbedTLS likes this)

2. instead of storing a certificate on each side, wouldn't it be nice to be able to store the public key only of the 
certificate, or perhaps even a hash of the public key of the certificate?
To me, storing either the certificate itself is not a problem (I recall Jason Donenfeld wanting to get rid of X509 certs 
altogether - something I strongly disagree with), but storing its public key should also be good - this mimicka SSH pub/priv 
key, so we could even re-use parts of the SSH code for this. One could even imagine getting the public key for a particular user 
out of his/her ~/.ssh/authorized_keys file.
Then, to make things even shorter, it was proposed to add *hashes* of public keys of certificates. To me, the added value of 
using a 256 bit hash instead of a 1024/2048 bit pubkey is limited, and I would like some assurance that this indeed foolproof. 
Other than that, I wouldn't NACK this feature, as long as it remains optional.

3. how a person gets the public key or hash of the client or server side certificate to the "other side" is pretty much out of 
scope: it simply requires "a secure channel". I am fine with that.

Note that browser certificate pinning is something else entirely: that is an *extra* check , on top of the cert chain check, to 
ensure that a server certificate (for, e.g. google.com) was signed by one of the "pinned" CA certificates. Browsers tend to 
trust a large number of CA certs, so this extra check makes sense there. As long as OpenVPN is not configured to trust 100+ CA's 
then this check does not make a lot fo sense in OpenVPN.



