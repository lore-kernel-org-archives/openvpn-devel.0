MIME-Version: 1.0
In-Reply-To: <36991fa1-26a3-15a5-a4a2-aaecf9e3f128@...2080...>
References: <1462457808-18833-1-git-send-email-steffan@...1856...>
	<1462479247-21854-1-git-send-email-steffan@...1856...>
	<36991fa1-26a3-15a5-a4a2-aaecf9e3f128@...2080...>
From: Steffan Karger <steffan@...1856...>
Date: Fri, 26 Aug 2016 09:19:48 +0200
Message-ID: <CAA1AbxLSFbG1+JVAsfCKPRi2gAUo8Aa2AvUDULus4-Cv8A7aUg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add SHA256 fingerprint support
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 26 August 2016 at 00:49, David Sommerseth
<openvpn@...2080...> wrote:
> Finally some time to review this :)

Great!  You having more time to spend on the codebase is really
helping the project move forward.

>   if (error_depth >= 0 && error_depth < MAX_CERT_DEPTH)
>     {
>       if (!session->cert_hash_set)
>         ALLOC_OBJ_CLEAR (session->cert_hash_set, struct cert_hash_set);
> *     if (!session->cert_hash_set->ch[error_depth])
>         ALLOC_OBJ (session->cert_hash_set->ch[error_depth], struct cert_hash);
>       {
>         struct cert_hash *ch = session->cert_hash_set->ch[error_depth];
>         ASSERT (sizeof (ch->sha256_hash) == BLEN (cert_hash));
>         memcpy (ch->sha256_hash, BPTR (cert_hash), sizeof (ch->sha256_hash));
>       }
>     }
>
> Look careful, the * marked if-line is only doing the ALLOC_OBJ, but it
> looks like the {} below is part of the if statement at first glance.  It
> actually took me a few reads to see that they were not related.  I'm
> concerned this style can hide bugs in future.  Ideally we should avoid
> such local scopes when we need to declare new variables, especially so
> close to for/while/if blocks.

I agree that the code is confusing this way, but I'd blame the missing
scope of the if statements, rather than the local scope.  Do you want
me to send a follow-up patch for cleanup, or resend in ta 1/2 cleanup
+ 2/2 SHA256?

>>  void
>>  cert_hash_free (struct cert_hash_set *chs)
>>  {
>> @@ -251,7 +233,8 @@ cert_hash_compare (const struct cert_hash_set *chs1, const struct cert_hash_set
>>
>>         if (!ch1 && !ch2)
>>           continue;
>> -       else if (ch1 && ch2 && !memcmp (ch1->sha1_hash, ch2->sha1_hash, SHA_DIGEST_LENGTH))
>> +       else if (ch1 && ch2 && !memcmp (ch1->sha256_hash, ch2->sha256_hash,
>> +           sizeof(ch1->sha256_hash)))
>>           continue;
>>         else
>>           return false;
>
> This looks sane.  I just got uncertain if we will always have SHA256
> hashes from certificates, or do they need be signed with a SHA256
> signature by the CA?   My gut feeling says me we will always have have
> this, as it should just be a hash of the certificate itself as is.
>
> I have only glared at the code so far, and it looks reasonable.  Will
> test it a bit more thorough in the coming days.

This hash is internal to openvpn, and has nothing to do with the CA
signatures.  We can use whatever we want.  I'm not aware of any reason
to assume SHA256 will be broken anytime soon, and if there is some
day, we will just switch to SHA-newest ;)  (We can't do SHA3 now,
because our backends do not support is yet.)

-Steffan

