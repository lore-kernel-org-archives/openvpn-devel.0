Message-ID: <5918d25b-d6a1-0d20-68ee-b1b760ec05d2@...1227...>
Date: Wed, 26 Jan 2022 11:27:05 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20220125025128.2117-1-selva.nair@...277...>
 <20220125025128.2117-2-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220125025128.2117-2-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] Fix max saltlen calculation in
 cryptoapi.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: selva.nair@...277..., "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 25.01.22 um 03:51 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> (nbits - 1)/8 should have been rounded up. Fix and move it to
> an inlined function for reuse in pkcs11_openssl.c (used in the
> next commit).
> 
> Note: The error is not triggered in normal use as OpenSSL
> always seems to use saltlen="digest" for signing.

That calculation is just too familiar.

Acked-By: Arne Schwabe <arne@...1227...>

