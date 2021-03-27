References: <20200907160224.18670-1-arne@...1227...>
 <20210326175750.4772-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <1174819b-1357-016e-10f5-7a29b297cc29@...2181...>
Date: Sun, 28 Mar 2021 00:07:18 +0100
MIME-Version: 1.0
In-Reply-To: <20210326175750.4772-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3] Cleanup print_details and add
 signature/ED certificate print
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 26/03/2021 18:57, Arne Schwabe wrote:
> This commit cleans up the logic in the function a bit. It also makes it
> more clear the the details printed in the second part of the message are
> details about the peer certificate and not the TLS connection as such.
> Also print the signature algorithm as this might help to identify
> peer certificate that still use SHA1.
> 
> The new format with for TLS 1.3 and an EC certificate.
> 
> Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, peer certificate: 384 bit EC, curve secp384r1, signature: ecdsa-with-SHA256
> 
> Using the more generic OpenSSL functions also allows use to correctly
> print details about ED certificates:
> 
> Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, peer certificate: 253 bit ED25519, signature: ED25519
> 
> Patch v2: Cleanup multiple calls to EVP_PKEY_id, minor code restructuring
> 
> Patch v3: Always initialise sig.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

It looks good now!
Printing of the peer certificate works as expected with both RSA and
ECDSA certificates.


Acked-by: Antonio Quartulli <antonio@...515...>


-- 
Antonio Quartulli

