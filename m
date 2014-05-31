Message-ID: <538A00AA.7090007@...1856...>
Date: Sat, 31 May 2014 18:17:46 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1345106302-22850-1-git-send-email-heiko.hund@...1489...>	<1345106302-22850-2-git-send-email-heiko.hund@...1489...>	<510D0687.1030503@...1227...>
	<510E6C5D.4080008@...1147...>
In-Reply-To: <510E6C5D.4080008@...1147...>
Content-Type: multipart/mixed; boundary="------------080505050603000704040207"
Subject: Re: [Openvpn-devel] [PATCH 1/7] refine assertion to allow other
 modes than CBC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080505050603000704040207
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

ACK (see attached and below for more details).

On 03-02-13 14:55, Jan Just Keijser wrote:
> Arne Schwabe wrote:
>> Am 16.08.12 10:38, schrieb Heiko Hund:
>>   
>>> cipher_ctx_final() only returns an outlen in CBC mode. If CFB or OFB
>>> are used the assertion outlen == iv_len is always false.
>>>
>>> There's no CBC mode defined for the GOST 28147-89 block cipher. Hence
>>> this patch is needed for it to work. It's needed for other ciphers like
>>> BF-CFB as well, though.
>>>
>>> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
>>> ---
>>>  src/openvpn/crypto.c |    2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
>>> index ac2eecd..2f67e5e 100644
>>> --- a/src/openvpn/crypto.c
>>> +++ b/src/openvpn/crypto.c
>>> @@ -153,7 +153,7 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
>>>  	  /* Flush the encryption buffer */
>>>  	  ASSERT(cipher_ctx_final(ctx->cipher, BPTR (&work) + outlen, &outlen));
>>>  	  work.len += outlen;
>>> -	  ASSERT (outlen == iv_size);
>>> +	  ASSERT (mode != OPENVPN_MODE_CBC || outlen == iv_size);
>>>  
>>>  	  /* prepend the IV to the ciphertext */
>>>  	  if (opt->flags & CO_USE_IV)
>>>     
>>
>> I have a user of my app that also tripped over this asssert line:
>>
>>   
> eeeehhh - removing the assert is nice, but do the other ciphers actually 
> *WORK* after that? does the test
>   openvpn --test-crypto
> pass after that? I remember commenting out the assert for a few elliptic 
> curve ciphers, but openvpn was still not able to encrypt/decrypt  
> traffic successfully.

I came up with (almost) the same patch to fix OFB and CFB modes last
week, but then came across this almost 2 years old patch from Heiko
while searching for the history on these modes in OpenVPN. I rebased it
on master and ran some tests (attached the updated patch).

Manual --test-crypto and t_lpback tests for CBC, OFB and CFB, as well as
the regular t_client tests for CBC succeed. Everything looks good to me.

-Steffan

--------------080505050603000704040207
Content-Type: text/x-patch;
	name="0001-refine-assertion-to-allow-other-modes-than-CBC.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-refine-assertion-to-allow-other-modes-than-CBC.patch"

From 606ed6ba90b1705de1546f4f151b524f46393082 Mon Sep 17 00:00:00 2001
From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 16 Aug 2012 10:38:50 +0200
Subject: [PATCH] refine assertion to allow other modes than CBC

cipher_ctx_final() only returns an outlen in CBC mode. If CFB or OFB
are used the assertion outlen == iv_len is always false.

There's no CBC mode defined for the GOST 28147-89 block cipher. Hence
this patch is needed for it to work. It's needed for other ciphers like
BF-CFB as well, though.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index c4c356d..d0dc069 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -171,7 +171,7 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
 	  /* Flush the encryption buffer */
 	  ASSERT(cipher_ctx_final(ctx->cipher, BPTR (&work) + outlen, &outlen));
 	  work.len += outlen;
-	  ASSERT (outlen == iv_size);
+	  ASSERT (mode != OPENVPN_MODE_CBC || outlen == iv_size);
 
 	  /* prepend the IV to the ciphertext */
 	  if (opt->flags & CO_USE_IV)
-- 
1.9.1


--------------080505050603000704040207--

