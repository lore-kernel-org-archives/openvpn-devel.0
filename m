From: Arne Schwabe <arne@...1227...>
References: <20210922211254.7570-1-selva.nair@...277...>
 <a7c18fd1-7c90-c353-8506-e6ccb36282e6@...1227...>
 <CAKuzo_jQvbGX8OEM4-c82F77gqyiCEyeVW-fVbt7EK=0p9kFZw@...278...>
 <CAKuzo_iGD2MGVOBf6+pegEYA0_VdnWKZbheaizshvqbOHB=h8g@...278...>
 <6a3a0ed8-5c38-a29d-bf71-a7555950e0c2@...1227...>
 <CAKuzo_gYfbtxiyW1HggYtGsFDdva_buegw0eSi=KFrQ-Yy9WXQ@...278...>
 <CAKuzo_iMTaRMNM2b_GsYDwFzMXw=Aw0UP+5e04QqGgLHQaPPEQ@...278...>
Message-ID: <882f9257-9c7e-8a08-2324-76c182ac0f9d@...1227...>
Date: Sun, 26 Sep 2021 03:15:41 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iMTaRMNM2b_GsYDwFzMXw=Aw0UP+5e04QqGgLHQaPPEQ@...278...>
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


> 
>     We can treat management-external key as special and optionally
>     provide the digest to sign. OpenSSL 3.0 with provider always seem to
>     call DigestSign and never Sign directly so we have the info. 
> 
> 
> Turns out to be easier than I thought. I have added a patch to
> optionally send the undigested message to the management client.
> Indicate support for digesting operation in --management-external-key
> and you get the message to sign with data=message

That is great. I tested it and TLS 1.3 is working nicely with
"SHA256withRSA/PSS" on the java side. So that is great.

But then it went downhill from that with things unrelated to the xkey
provider. I wanted to see if it works with TLS 1.1 (ie.. forcing a pkcs1
signature) and found out tls-version-max no longer work on OpenSSL 3.0
nor on my Ubuntu 20 with OpenSSL 1.1.

I decided then to replace SSLv23_client_method with TLS11_client_method,
which ended with an internal SSL error in my client.

So instead I tried to see tls-version-max still works with mbed TLS only
to discover that my OpenSSL 3.0 client does not connect to my mbed TLS
at all and instead the server says "TLS_ERROR: read tls_read_plaintext
error: SSL - Bad input parameters to function" (Ubuntu 20/mbed TLS
2.16.0). Switching the app back to OpenSSL 1.1.1l still works.

Then tested again with OpenSSL 3.0 but forgot to reenable
HAVE_XKEY_PROVIDER and now the RSA_method/EC_method works but I was
fairly sure that it didn't before. Maybe there is some obscure side
effect from your branch or I misremembered before ...

But for some reason having the HAVE_XKEY_PROVIDER define enabled breaks
connecting to an mbed TLS 2.16 server. I can also reproduce that with my
a version on my mac.

> 
> See the commit message. It's
> in  https://github.com/selvanair/openvpn/tree/xkey-provider-v3
> <https://github.com/selvanair/openvpn/tree/xkey-provider-v3>   (only
> compile tested). 
> 
> Selva
> PS. I'm supposed to be holidaying, but basking in LCD glow instead of sun..


Hehe, and I am supposed to be sleeping but instead I am testing some
obscure software part that is even hard to explain to other IT (non
crypto) people what it does ....



