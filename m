References: <20210319142001.2201-3-arne@...1227...>
 <20210322091414.7533-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <90feb1ab-ddd0-1875-4371-d0033cb4b2d8@...2181...>
Date: Mon, 22 Mar 2021 10:40:42 +0100
MIME-Version: 1.0
In-Reply-To: <20210322091414.7533-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 3/5] Support fingerprint
 authentication without CA certificate
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 22/03/2021 10:14, Arne Schwabe wrote:
> From: "Jason A. Donenfeld" <Jason@...2390...>
> 
> OpenVPN traditionally works around CAs. However many TLS-based protocols also
> allow an alternative simpler mode in which rather than verify certificates
> against CAs, the certificate itself is hashed and compared against a
> pre-known set of acceptable hashes. This is usually referred to as
> "fingerprint verification". It's popular across SMTP servers, IRC servers,
> XMPP servers, and even in the context of HTTP with pinning.
> 
>    * Allow not specifying the --ca parameter, to specify that
>      certificates should not be checked against a CA.
> 
> I've included some instructions on how to use all of this.
> 
> Server side:
> ============
> 
> Make self-signed cert:
> $ openssl req -x509 -newkey ec:<(openssl ecparam -name secp384r1) -keyout serverkey.pem -out servercert.pem -nodes -sha256 -days 3650 -subj '/CN=server'
> 
> Record our fingerprint in an environment variable for the client to use later:
> $ server_fingerprint="$(openssl x509 -in servercert.pem -noout -sha256 -fingerprint | sed 's/.*=//;s/\(.*\)/\1/')"
> 
> Client side:
> ============
> Make self-signed cert:
> $ openssl req -x509 -newkey ec:<(openssl ecparam -name secp384r1) -keyout clientkey.pem -out clientcert.pem -nodes -sha256 -days 3650 -subj '/CN=client'
> 
> Record our fingerprint in an environment variable for the server to use later:
> $ client_fingerprint="$(openssl x509 -in clientcert.pem -noout -sha256 -fingerprint | sed 's/.*=//;s/\(.*\)/\1/')"
> 
> Start server/client
> ===================
> 
> Start openvpn with peer fingerprint verification:
> 
> $ sudo openvpn --server 10.66.0.0 255.255.255.0 --dev tun --dh none --cert servercert.pem --key serverkey.pem --peer-fingerprint "$client_fingerprint"
> 
> $ sudo openvpn --client --remote 127.0.0.1 --dev tun --cert clientcert.pem --key clientkey.pem --peer-fingerprint "$server_fingerprint" --nobind
> 
> Signed-off-by: Jason A. Donenfeld <Jason@...2390...>
> 
> Patch V2: Changes in V2 (by Arne Schwabe):
>           - Only check peer certificates, not all cert levels, if you need
>             multiple levels of certificate you should use a real CA
>           - Use peer-fingerprint instead tls-verify on server side in example.
>           - rename variable ca_file_none to verify_hash_no_ca
>           - do no require --ca none but allow --ca simply
>             to be absent when --peer-fingprint is present
>           - adjust warnings/errors messages to also point to
>             peer-fingerprint as valid verification method.
>           - Fix mbed TLS version of not requiring CA
>             not working
> 
> Patch v3: Fix minor style. Remove unessary check of verify_hash_no_ca in ssl.c.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Acked-by: Antonio Quartulli <antonio@...515...>

It looks good and works as expected!

-- 
Antonio Quartulli

