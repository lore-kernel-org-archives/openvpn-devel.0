References: <20180417165000.3872-1-Jason@...2390...>
 <10978590-889a-0ccc-4cb8-31c862ee565c@...1856...>
 <33fe1382-9dd6-82b4-1215-7f748e521a48@...1147...>
 <fd348cf4-8d17-24b1-cace-f238d319c550@...1227...>
 <03f8402c-a603-3405-543a-e5eaa1ebc224@...1147...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <1d803ca0-2f28-585c-eeca-4c64ac2d745f@...1227...>
Date: Thu, 24 May 2018 12:17:56 +0200
MIME-Version: 1.0
In-Reply-To: <03f8402c-a603-3405-543a-e5eaa1ebc224@...1147...>
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
To: Jan Just Keijser <janjust@...1147...>, Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net


>> When you sign a certificate you are actually singing the hash of the
>> certificate. So you essentially are saying: "This certificate with the
>> hash xxxyyy is trusted by my CA". Traditionally we used the MD5 of the
>> certificate, then SHA1 and now SHA256 which we signed. (See the weak md5
>> discussion).
>>
>> The reason that the hash is signed instead of the public is that this
>> way you are also signing the other properties of the certificate (e.g.
>> CN, extensions, etc.). If you can the public key (or any other property
>> of the certificate) also the hash of the certificate changes.
>>
>> If you just have a list of hashes that you trust you just cut out the
>> middle man (the CA) that establishes the trust relationship for you.
>>
>>
> I understand that part - it's how certificate pinning etc work. However,
> for a "regular" TLS connection (or any assymmetric encryprion scheme)
> you normally need a public key and a private key in order to establish a
> connection. However, with certificate pinning all you do is *ADD* an
> extra check, not replace a check. You will need and use both the public
> and the private key to establish security. How is this done in the
> proposed patch?

Private and public key are still used. The patch stil uses certificates
and TLS, it only replaces the check certificate of the peer's
certificate against the CA with a hash check (certificate pinning if you
want).

So basically instead of saying that you trust all certificates signed by
a CA, you only trust only those certifcates of which have hashes. A
certificate pinning of an unknown CA is exactly the same. Since you
cannot verify that certificate you add a one off certificate in your
list of trusted certificates.

Arne

