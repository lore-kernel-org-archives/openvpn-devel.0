References: <bda8bfa8-701a-99a1-4d02-676918cf1fe2@...2181...>
 <20170716130605.27527-1-coroner@...2290...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <e2b8f8df-5506-e9da-4619-4af83c5867e7@...1856...>
Date: Sat, 19 Aug 2017 10:00:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170716130605.27527-1-coroner@...2290...>
Content-Language: en-GB
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 16-07-17 15:06, Szilárd Pfeiffer wrote:
> Prefer server ciphers over client ciphers during the TLS handshake. Part
> of the ClientHello message client sends supported cipher suites in order
> of its preference. If tls-prefer-server-ciphers is when server choosing
> a cipher, use the server's preferences instead of the client preferences.
> 
> The functionality is the same as the folowings:
> 
> * ssl_prefer_server_ciphers in NGINX
> * SSLHonorCipherOrder in Apache
> * ...

Took me a while to ponder about this one, sorry about that.

You probably know this, but as context for other readers:  OpenVPN uses
TLS differently than HTTP (nginx/apache) do, because we barely use the
TLS record protocol.  The reason to prefer client ciphers, is that a
client can e.g. prefer a cipher that performs better on the client
platform.  Think chacha20-poly1305 on ARM chips without AES hardware
acceleration.  For OpenVPN, this is not really relevant, because the
actual performance-relevant crypto is the data channel, which is
negotiated (or statically configured) separately from the TLS ciphers.

All in all, I don't think we need an option for this, but can simply
always use the server cipher preference.  I think it's a safe bet to say
that server admins are better at updating their configs than client
users are.  And if client do want to restrict their ciphers, they should
simply evict the ciphers they don't want from their cipher suite.

Since mbed TLS by default already prefers the server-side cipher list,
all we would need to do is or in the SSL_OP_CIPHER_SERVER_PREFERENCE
flag in the OpenSSL-specific code.  That makes the patch a lot simpler
*and* we have less option combinations to test and maintain.  We can
even safely do that without #ifdef guards, because this define is
available since OpenSSL 0.9.8, which is the oldest version we support.

-Steffan

