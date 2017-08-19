Reply-To: openvpn-devel@lists.sourceforge.net
References: <bda8bfa8-701a-99a1-4d02-676918cf1fe2@...2181...>
 <20170716130605.27527-1-coroner@...2290...>
 <e2b8f8df-5506-e9da-4619-4af83c5867e7@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <3069bcad-548c-4f90-91ce-b8950095bfd9@...2080...>
Date: Sat, 19 Aug 2017 23:06:22 +0200
MIME-Version: 1.0
In-Reply-To: <e2b8f8df-5506-e9da-4619-4af83c5867e7@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="uWlCu8FlsMjjRai6MmK3xdjhs2Ob7oP3p"
Subject: Re: [Openvpn-devel] [PATCH v2] Implement tls-prefer-server-ciphers
 option to prefer server cipher order
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uWlCu8FlsMjjRai6MmK3xdjhs2Ob7oP3p
Content-Type: multipart/mixed; boundary="XNCjjDpNv4sKdHA9PjAViLF5KJUCi5xqf";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: openvpn-devel@lists.sourceforge.net
Message-ID: <3069bcad-548c-4f90-91ce-b8950095bfd9@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Implement tls-prefer-server-ciphers
 option to prefer server cipher order
References: <bda8bfa8-701a-99a1-4d02-676918cf1fe2@...2181...>
 <20170716130605.27527-1-coroner@...2290...>
 <e2b8f8df-5506-e9da-4619-4af83c5867e7@...1856...>
In-Reply-To: <e2b8f8df-5506-e9da-4619-4af83c5867e7@...1856...>

--XNCjjDpNv4sKdHA9PjAViLF5KJUCi5xqf
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 19/08/17 10:00, Steffan Karger wrote:
> Hi,
>=20
> On 16-07-17 15:06, Szil=C3=A1rd Pfeiffer wrote:
>> Prefer server ciphers over client ciphers during the TLS handshake. Part
>> of the ClientHello message client sends supported cipher suites in order
>> of its preference. If tls-prefer-server-ciphers is when server choosing
>> a cipher, use the server's preferences instead of the client preferences.
>>
>> The functionality is the same as the folowings:
>>
>> * ssl_prefer_server_ciphers in NGINX
>> * SSLHonorCipherOrder in Apache
>> * ...
>=20
> Took me a while to ponder about this one, sorry about that.
>=20
> You probably know this, but as context for other readers:  OpenVPN uses
> TLS differently than HTTP (nginx/apache) do, because we barely use the
> TLS record protocol.  The reason to prefer client ciphers, is that a
> client can e.g. prefer a cipher that performs better on the client
> platform.  Think chacha20-poly1305 on ARM chips without AES hardware
> acceleration.  For OpenVPN, this is not really relevant, because the
> actual performance-relevant crypto is the data channel, which is
> negotiated (or statically configured) separately from the TLS ciphers.
>=20
> All in all, I don't think we need an option for this, but can simply
> always use the server cipher preference.  I think it's a safe bet to say
> that server admins are better at updating their configs than client
> users are.  And if client do want to restrict their ciphers, they should
> simply evict the ciphers they don't want from their cipher suite.
>=20
> Since mbed TLS by default already prefers the server-side cipher list,
> all we would need to do is or in the SSL_OP_CIPHER_SERVER_PREFERENCE
> flag in the OpenSSL-specific code.  That makes the patch a lot simpler
> *and* we have less option combinations to test and maintain.  We can
> even safely do that without #ifdef guards, because this define is
> available since OpenSSL 0.9.8, which is the oldest version we support.


This corresponds very well with my own conclusion as well; but as I'm
not the crypto guru I hoped Steffan would respond in a reasonable time :)

I do like that we make mbed TLS and OpenSSL behave more similar with the
SSL_OP_CIPHER_SERVER_PREFERENCE flag.

Regarding OpenSSL 0.9.8 support, that is nice to have - but if we need
to move to 1.0.1 in release/2.4, I won't be hard to convince.  We've
already made that move for git master (future release/2.5).  There are
some SUSE Linux releases still shipping OpenSSL 0.9.8 (but also provides
a 1.0.x package too, iirc).


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--XNCjjDpNv4sKdHA9PjAViLF5KJUCi5xqf--

--uWlCu8FlsMjjRai6MmK3xdjhs2Ob7oP3p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZmKhOAAoJEIbPlEyWcf3yN3QQAKCds6FbBN/a7BKDCrP9uDPX
1s9G2U1Guce35pMRTPumN5zi4zBGE88GKd4zW0dX017FAJ9F0B7IKdL8Jgqguuzf
FwDfLKhvoiFJEwlIo18BBTkXbYTYq+qxLDKZX19IOIxoK+1h2wvHDxDpQGjUYYOg
/hXKz9kPOfwmVWQToKghNBpGc1B77ZFhHoT7WbHwklEQNIuaS/V9Y6+5eMV2Qjgp
wAk4xFPTekU8Y81MVkFYgZsbn1DrM4HyMJ4h9d9VWriR3Fd1csuaNRG4W4aueoGA
KBXb/axKPKW8IAwsvvsidHnY9QxTiY72u2ykcQcqTxpzwVoW30zJLpbfKYuxZieH
IS7sP3og33ilq84DW+pHqs31/sjKY4eHGKhraYIFITIQvtZqt2QAMG7IpNgcDK2s
fzEsEgTbEi12LLO3LrELhtd/YpyHpBPAmqX/xmvZ5kFhg7FXrPKcHmzx7d4TVTL8
xdFRwO+3JkR9r+BP6tmy/FxYhzWWsICoO8DSlY3xbjWEWzqt24CHiLPgbUL2AzoZ
aocDDx16EPIvUVGUoNuuQskpdhAeHX1eMT/mlCjDIwasRooVhTp7HGBR0sQiNMVq
p6vFtlkdL/vMmReaW1NMgvj2g19XFvwiIEb2aUnxSnNMLnWaUkoij2aJaBZgrdG+
sK0bd1FkOAN4DZL1puTg
=/C0Q
-----END PGP SIGNATURE-----

--uWlCu8FlsMjjRai6MmK3xdjhs2Ob7oP3p--

