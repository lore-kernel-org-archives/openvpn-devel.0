From: David Sommerseth <openvpn@...2080...>
References: <1462457808-18833-1-git-send-email-steffan@...1856...>
	<1462479247-21854-1-git-send-email-steffan@...1856...>
	<36991fa1-26a3-15a5-a4a2-aaecf9e3f128@...2080...>
	<CAA1AbxLSFbG1+JVAsfCKPRi2gAUo8Aa2AvUDULus4-Cv8A7aUg@...278...>
Message-ID: <75084ad5-c8fc-2a87-7828-8270ed6ba88a@...2080...>
Date: Fri, 26 Aug 2016 13:08:59 +0200
MIME-Version: 1.0
In-Reply-To: <CAA1AbxLSFbG1+JVAsfCKPRi2gAUo8Aa2AvUDULus4-Cv8A7aUg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add SHA256 fingerprint support
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 26/08/16 09:19, Steffan Karger wrote:
> Hi,
> 
> On 26 August 2016 at 00:49, David Sommerseth 
> <openvpn@...2080...> wrote:
>> Finally some time to review this :)
> 
> Great!  You having more time to spend on the codebase is really 
> helping the project move forward.
> 
>> if (error_depth >= 0 && error_depth < MAX_CERT_DEPTH) { if
>> (!session->cert_hash_set) ALLOC_OBJ_CLEAR
>> (session->cert_hash_set, struct cert_hash_set); *     if
>> (!session->cert_hash_set->ch[error_depth]) ALLOC_OBJ
>> (session->cert_hash_set->ch[error_depth], struct cert_hash); { 
>> struct cert_hash *ch = session->cert_hash_set->ch[error_depth]; 
>> ASSERT (sizeof (ch->sha256_hash) == BLEN (cert_hash)); memcpy
>> (ch->sha256_hash, BPTR (cert_hash), sizeof (ch->sha256_hash)); } 
>> }
>> 
>> Look careful, the * marked if-line is only doing the ALLOC_OBJ,
>> but it looks like the {} below is part of the if statement at
>> first glance.  It actually took me a few reads to see that they
>> were not related.  I'm concerned this style can hide bugs in
>> future.  Ideally we should avoid such local scopes when we need
>> to declare new variables, especially so close to for/while/if
>> blocks.
> 
> I agree that the code is confusing this way, but I'd blame the
> missing scope of the if statements, rather than the local scope.
> Do you want me to send a follow-up patch for cleanup, or resend in
> ta 1/2 cleanup + 2/2 SHA256?

Depends on how you clean it up ;-)  I've been thinking about this, and I
think just adding an extra blank line after each if() statement and
perhaps adding a comment above the {} local scope would suffice.

But if you do more thorough clean-up, it's probably better to split it
up into separate patches.

Does this make sense?

> 
>>> void cert_hash_free (struct cert_hash_set *chs) { @@ -251,7
>>> +233,8 @@ cert_hash_compare (const struct cert_hash_set *chs1,
>>> const struct cert_hash_set
>>> 
>>> if (!ch1 && !ch2) continue; -       else if (ch1 && ch2 &&
>>> !memcmp (ch1->sha1_hash, ch2->sha1_hash, SHA_DIGEST_LENGTH)) +
>>> else if (ch1 && ch2 && !memcmp (ch1->sha256_hash,
>>> ch2->sha256_hash, +           sizeof(ch1->sha256_hash))) 
>>> continue; else return false;
>> 
>> This looks sane.  I just got uncertain if we will always have
>> SHA256 hashes from certificates, or do they need be signed with a
>> SHA256 signature by the CA?   My gut feeling says me we will
>> always have have this, as it should just be a hash of the
>> certificate itself as is.
>> 
>> I have only glared at the code so far, and it looks reasonable.
>> Will test it a bit more thorough in the coming days.
> 
> This hash is internal to openvpn, and has nothing to do with the
> CA signatures.  We can use whatever we want.  I'm not aware of any
> reason to assume SHA256 will be broken anytime soon, and if there
> is some day, we will just switch to SHA-newest ;)  (We can't do
> SHA3 now, because our backends do not support is yet.)

Ahh, good, then I won't worry about this.  We could do SHA512 though,
but not sure it's really worth it in this context ;-)


David S.



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJXwCNLAAoJEIbPlEyWcf3yuSQQAKyS25Dk8Ipvb2IPIYZvZPgO
QOQRYjuq7Nv3AdG9fMq7sEs7AymHP5vNRZUoGR0ev5AbhX6gEysIxvrg+gxuqBDx
wUKvplomkqUSxBwYNWTsTcqkW4IpduYNhJdpiXfFN30bRcePBm7HZvkShG9FsgzR
hfAHPXH/TD5ConJPB8WiYO2sbkD86o6Ik7Ur6Iu5aI2vWneTFCU/gPOz/oj6Ad07
ERGyBk3DSbyVuQ9BjvCRWZ6m/BSlt4NF86wWkijCbcgNRoZufyO2PAHZ0o59Yzpa
ZdaFPl044zV9FHhbSL4Zx09Mw99+DrA333gbbIajWRQGtkjAjIasNb3R7O7R1+Xm
E90aUemfQikC4aRG1rkgMCyUGy9H9Ywe7Thpvi72xtxvxRH34XtCFibFfdDuc1KO
ufYuyFyAahkarAmhjsV/Dm3Loy6Fedmcv31Ice8heZJ/4GSyexp3M7Aimpo9RIck
9UkJ7lha7ExlpoGnwq15BsARLDhXMC0sjuQ9PCv4ExezofBmHgo+1Vxg7L7DCSia
zi3e3PqX81eYgG1uKZJEiTa8lqo11cuNOM3+N9ruWJBLDqZu7YgTa/MCoPDfQXoe
x8yFIRwqOSW++7L9ebCwBxaoxY/5ADeVcDxdV7KhYMIgYsvtsLnLRWG6jPrpDGl8
R9jFm+XTNuCYQyfHhlti
=94yV
-----END PGP SIGNATURE-----

