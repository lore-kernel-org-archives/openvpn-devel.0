Message-ID: <53502E71.8070503@...515...>
Date: Thu, 17 Apr 2014 13:41:37 -0600
From: James Yonan <james@...515...>
MIME-Version: 1.0
References: <1393530007-6225-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1393530007-6225-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] PolarSSL 1.3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 27/02/2014 12:40, steffan.karger@...1435... wrote:
> Hi,
>
> The attached patches add support for PolarSSL 1.3. These patches are for
> master only, as they drop support for PolarSSL 1.2. Supporting both versions
> would require a lot of #ifdef's, so I opted for dropping 1.2.
>
> Along with PolarSSL 1.3 comes support for AES-NI and elliptic curve crypto.
> PolarSSL requires no specific initialization for EC crypto; everything just
> works out-of-the-box.

Just tested this on server side -- works great so far.

But I scanned the patch and noticed this:

   sig_len = ctx->signature_length;
   if ( (SIZE_MAX - hashlen) > asn_len || (hashlen + asn_len) > sig_len )
     return POLARSSL_ERR_RSA_BAD_INPUT_DATA;

I'm not sure I understand the (SIZE_MAX - hashlen) > asn_len part. 
Wouldn't this always be true for reasonable values of hashlen and asn_len?

And the *p++ lines below, I assume that the buffer's size is 
ctx->signature_length?  Maybe add some comments about buffer-sizing 
assumptions?

James

