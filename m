References: <20210922211254.7570-1-selva.nair@...277...>
 <a7c18fd1-7c90-c353-8506-e6ccb36282e6@...1227...>
 <CAKuzo_jQvbGX8OEM4-c82F77gqyiCEyeVW-fVbt7EK=0p9kFZw@...278...>
 <CAKuzo_iGD2MGVOBf6+pegEYA0_VdnWKZbheaizshvqbOHB=h8g@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <6a3a0ed8-5c38-a29d-bf71-a7555950e0c2@...1227...>
Date: Fri, 24 Sep 2021 13:13:36 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iGD2MGVOBf6+pegEYA0_VdnWKZbheaizshvqbOHB=h8g@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 0/9] A built-in OpenSSL3.0 provider for
 external-keys
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 24.09.21 um 00:54 schrieb Selva Nair:
> Hi,
>  
> 
>         from the management interface. But I haven't found the right
>         Signature
>         method from java yet to actually sign it correctly:
> 
>         sig = Signature.getInstance(SHA256withRSA/PSS);
> 
> 
> SHA256withRSA/PSS may be trying to first do Sha256 digest of the data
> and then pad and sign. Instead try this: "NonewithRSASSA-PSS" or
> "NonewithRSA/PSS"

Yeah, That *would* be the correct algorithm for that. Unfortunately the
Android Keystore does not support that one
(https://developer.android.com/training/articles/keystore#SupportedSignatures)


Manually adding the RSA/PSS padding and then signing with
"RSA/ECB/NoPadding" like I did in OpenSSL 1.1 days works. But I would
like to avoid implementing RSA/PSS myself but the crypto libraries seem
not be helpful in providing an implementation for that.

OpenSSL has RSA_padding_add_PKCS1_PSS_mgf1 but it is deprecated in 3.0
and the Java crypto API also does not seem to expose an API for just
padding it seems.

But on the plus side, using that workaround the external key provider
works with EC and RSA on Android.

Arne

