References: <20180417165000.3872-1-Jason@...2390...>
 <10978590-889a-0ccc-4cb8-31c862ee565c@...1856...>
 <33fe1382-9dd6-82b4-1215-7f748e521a48@...1147...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <fd348cf4-8d17-24b1-cace-f238d319c550@...1227...>
Date: Wed, 23 May 2018 16:46:58 +0200
MIME-Version: 1.0
In-Reply-To: <33fe1382-9dd6-82b4-1215-7f748e521a48@...1147...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Support fingerprint authentication
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jan Just Keijser <janjust@...1147...>, Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net


>>
> I have some strong thoughts on this, mostly related to:  can someone
> explain to me why this is safe?
> 
> I've seen that OpenSSH 7.7 now implements something similar (xmss
> hash-based signatures,
> https://tools.ietf.org/html/draft-irtf-cfrg-xmss-hash-based-signatures-12,
> disabled by default) but that works entirely differently from what is
> proposed here; amongst other things, it uses *one time private keys* to
> maximize security - do we want to add something like that to our TLS
> stuff (my gut answer: no).
> 
> How can a hash replace a public key, cryptographically speaking? if you
> are not replacing public keys, then who generates, stores, maintains
> these public keys?  What about accounting in such a setup? with
> certificates, you normally hand out a certificate to a person, with the
> name of the person/entity in it. If that person misbehaves, you revoke
> the certificate and presto. Is it sufficient to remove the hash from the
> config? if so, wouldn't it be better to have a directory with
> hash-files, so that you can add and remove hashes without having to
> update the server config and/or restart the server to pick up new hashes?
> 
When you sign a certificate you are actually singing the hash of the
certificate. So you essentially are saying: "This certificate with the
hash xxxyyy is trusted by my CA". Traditionally we used the MD5 of the
certificate, then SHA1 and now SHA256 which we signed. (See the weak md5
discussion).

The reason that the hash is signed instead of the public is that this
way you are also signing the other properties of the certificate (e.g.
CN, extensions, etc.). If you can the public key (or any other property
of the certificate) also the hash of the certificate changes.

If you just have a list of hashes that you trust you just cut out the
middle man (the CA) that establishes the trust relationship for you.


Arne

