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
 <a549cef5-4775-5b65-e160-ba9fc8e653cf@...1147...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <638c48e0-5c8b-387c-156c-51d07905fad2@...1227...>
Date: Mon, 28 May 2018 18:18:31 +0200
MIME-Version: 1.0
In-Reply-To: <a549cef5-4775-5b65-e160-ba9fc8e653cf@...1147...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH] Support fingerprint authentication
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Jan Just Keijser <janjust@...1147...>, Simon Rozman <simon@...2293...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> 
> 2. instead of storing a certificate on each side, wouldn't it be nice to
> be able to store the public key only of the certificate, or perhaps even
> a hash of the public key of the certificate?
> To me, storing either the certificate itself is not a problem (I recall
> Jason Donenfeld wanting to get rid of X509 certs altogether - something
> I strongly disagree with), but storing its public key should also be
> good - this mimicka SSH pub/priv key, so we could even re-use parts of
> the SSH code for this. One could even imagine getting the public key for
> a particular user out of his/her ~/.ssh/authorized_keys file.
> Then, to make things even shorter, it was proposed to add *hashes* of
> public keys of certificates. To me, the added value of using a 256 bit
> hash instead of a 1024/2048 bit pubkey is limited, and I would like some
> assurance that this indeed foolproof. Other than that, I wouldn't NACK
> this feature, as long as it remains optional.

There seem to be some confusion about what is secure here and what not.
I will give a bite more detailed example here to explain the pubkey vs
hash check.

Simplified a X509 looks like this:

X509Cert {
  CN=foo.example.net
  PUBKEY=00:aa:bb:cc
  usage="TLSServer"
  other attributes
}
Signature {
  SigningCAHash=00:bb:cc
  SHA1Signature=binarysting
}

On a normal CA Check, the client will do a hash over the whole of the
X509Cert (including CN and all other attributes). Then it will fetch the
CA that signed the certificate, gets its public key and checks if the
signature that is appended to the certifcate is valid and signs the hash
it calculated before.

The reason that we hash the whole certificate and sign the hash and also
check the hash against the signature instead of the pubkey is that we
want to have the other attributes to be validated as well. If we only
signed the pubkey, a malicious party could just edit the CN of the
certificate and the certificate would still be valid.

What is proposed here is that instead of taking the signature of the
certificate and checking if the signature sign that hash, we just look
if we can find the hash in our list of trusted hash.

I have not check the proposol in detail but if we implment something
like this (especially with server side support), I would strongly
suggest verify the hash/fingerprint of the certificate instead of using
only the pubkey. Then there are no surprises for people that are not
intimate with X509/SSL that client can fake the CN.


> 
> 3. how a person gets the public key or hash of the client or server side
> certificate to the "other side" is pretty much out of scope: it simply
> requires "a secure channel". I am fine with that.
> 
> Note that browser certificate pinning is something else entirely: that
> is an *extra* check , on top of the cert chain check, to ensure that a
> server certificate (for, e.g. google.com) was signed by one of the
> "pinned" CA certificates. Browsers tend to trust a large number of CA
> certs, so this extra check makes sense there. As long as OpenVPN is not
> configured to trust 100+ CA's then this check does not make a lot fo
> sense in OpenVPN.

For self signed certificates checking the hash against the well known
exception list (add this certificate as exception) also becomes the only
check.

Arne

