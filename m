MIME-Version: 1.0
In-Reply-To: <566FE713.2090208@...1147...>
References: <1450131285-30182-1-git-send-email-steffan@...1856...>
	<566FD25F.7080804@...1147...>
	<CAA1AbxJVpBGqOLVzqPpbTPMcO4DQzM=_a9=i+yMHpcPnApDG_A@...278...>
	<566FE713.2090208@...1147...>
From: Steffan Karger <steffan@...1856...>
Date: Tue, 15 Dec 2015 13:21:03 +0100
Message-ID: <CAA1AbxJQTFPumc5y3OvGdendwsx7zWhLD4+RWmAYf=FGj7bpeQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Disable certificate notBefore/notAfter
 sanity check on OpenSSL < 1.0.2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

>>>> The SSL_CTX_get0_certificate() function I used in 091edd8e is available
>>>> in
>>>> OpenSSL 1.0.2+ only.  Older versions seem to not have a useful
>>>> alternative.
>>>> The remaining option would then be to create a cache for our parsed
>>>> certificate, but that would mean adding more struct members and code for
>>>> the select group of people that do use an up-to-date openvpn, but do not
>>>> update their openssl.  I don't think that's worth it.  So just disable
>>>> the
>>>> code for older openssl versions.
>>>
>>> I have code lying around for checking certificate dates for openssl
>>> v0.9.7+
>>> ; you can find it here:
>>>    https://www.nikhef.nl/~janjust/proxy-verify/
>>>
>>> the function of interest is grid_asn1TimeToTimeT ; it was/is on my TODO
>>> list
>>> to convert this code into a similar patch - perhaps we can integrate the
>>> two?
>>
>> But before we extract the time from the certificate, we need to either
>> cache our own x509 certificate (in the certificate file reading code,
>> the pkcs11 code, the management-external-key code, the ms crapi code,
>> etc...) or find a way to extract our own x509 cert from an SSL_CTX
>> (which SSL_CTX_get0_certificate() does, since from that part of the
>> code it *can* peek into the opaque 'struct cert_st').
>>
>> Looking at the mess, I still think it is just not worth the extra
>> code.  But if you (or someone else) manage to find a clean and simple
>> way to perform the check pre-1.0.2, I will gladly review a patch :)
>>
> err, isn't it much easier to check the certificate expiry date when loading
> the cert, e.g. in "tls_ctx_load_cert_file_and_copy"  in ssl_openssl.c ? or
> am I missing something here?

Yes, we could do that.  But we would have to do that for both crypto
libraries separately, and at each place where we load certificates
(same list as above; file, pkcs#11, ms crapi,
management-external-cert, maybe more?).  Not as nice as a single check
after all certificate processing.

-Steffan

