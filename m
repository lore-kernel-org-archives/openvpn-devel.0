Message-ID: <538F27C6.2030203@...1516...>
Date: Wed, 4 Jun 2014 16:05:58 +0200
From: Holger Kummert <Holger.Kummert@...1516...>
MIME-Version: 1.0
References: <1397645317-20116-1-git-send-email-Holger.Kummert@...1516...>
	<1397645317-20116-2-git-send-email-Holger.Kummert@...1516...>
	<20140602182009.GP1118@...1296...>
In-Reply-To: <20140602182009.GP1118@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Get NTLMv1 and NTLMv2 up and running
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net


Hello Gerd,

first of all thank you for doing a first review of the code.
Please find my comments below.

Am 02.06.2014 20:20, schrieb Gert Doering:
> Hi Holger,
>
> sorry for drag this so long.  I'm not trying to stare into this, but
> can't really say "this is correct" or "violating specs", lacking the
> NTLM auth background.
>
> Is this used - and thus tested - by you only, or is it used by UTM
> customers?  (This would give us confidence that it's tested by a larger
> user base, and those tend to uncover issues :-) ).

Well, I thought I let it pass through the review process of the group
first before pushing it to customers.
But if it would help the review we could do it the other way
round and give it to customers first.
No problem.

>
> Can you explain which of these changes actually fix the "not working"
> bits, and which are just "make the code less ugly"?

Roughly: The changes in ntlm.c (PATCH 1) belong to "fix the not 
working", and all
other files (PATCH 2)  are related to "improve code and configuration".

>
> More questions and some comments on style intermixed below...
>
>
> On Wed, Apr 16, 2014 at 12:48:36PM +0200, Holger Kummert wrote:
>> * Force conversion to UTF-16 of username and domain if server requires UTF-16.
>> * Rewrite conversion function to cleanly convert UTF-8 to UTF-16.
>> * Fix bug in length computation in NTLMv2-code.
>> * Architecture independent access to NTLM NegotiateFlags.
>>
>> Signed-off-by: Holger Kummert <Holger.Kummert@...1516...>
>> ---
>>   src/openvpn/ntlm.c | 156 +++++++++++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 134 insertions(+), 22 deletions(-)
>>
>> diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
>> index 3390bdd..ed1e1a8 100644
>> --- a/src/openvpn/ntlm.c
>> +++ b/src/openvpn/ntlm.c
>> @@ -56,6 +56,11 @@
>>   #endif
>>
>>
>> +#define NTLM_NEGOTIATE_UNICODE      (1<<0)
>> +#define NTLM_NEGOTIATE_OEM          (1<<1)
>> +#define NTLM_NEGOTIATE_NTLM2_KEY    (1<<19)
>> +#define NTLM_NEGOTIATE_TARGET_INFO  (1<<23)
>> +
>>
>>
>>   static void
>> @@ -79,8 +84,10 @@ gen_md4_hash (const char* data, int data_len, char *result)
>>     const md_kt_t *md4_kt = md_kt_get("MD4");
>>     char md[MD4_DIGEST_LENGTH];
>>
>> -  md_full(md4_kt, data, data_len, md);
>> -  memcpy (result, md, MD4_DIGEST_LENGTH);
>> +  if (data_len >= 0) {
>> +    md_full(md4_kt, data, data_len, md);
>> +    memcpy (result, md, MD4_DIGEST_LENGTH);
>> +  }
>>   }
>
> Can data_len be < 0 in any reasonable circumstances?
>
> If not, I'd rather have an "ASSERT(data_len>=0)" here - it would be a
> calling convention violation, and just silently not doing anything is
> not how OpenVPN usually handles this (as it might lead to interesting
> effects later on, "result" being uninitialized).  Better crash with a
> clear message pointing to this line of code in that case.

Unfortunately it could be that 'data_len' <= 0 because it's the result of
utf8_to_utf16LE() which returns -1 in case of a conversion error.

>
>
>>   static void
>> @@ -140,18 +147,89 @@ unsigned char *my_strupr(unsigned char *str)
>>   }
>>
>>   static int
>> -unicodize (char *dst, const char *src)
>> +utf8_to_utf16LE (unsigned char *dst, int dst_len, unsigned char *src)
>>   {
>> -  /* not really unicode... */
>> -  int i = 0;
>> -  do
>> +  /* Convert UTF-8 to UTF-16 little endian
>> +   *
>> +   * http://clang.llvm.org/doxygen/ConvertUTF_8c_source.html
>> +   */
>
> I can see why you would want to change this :-) - for clarification, is
> this a true bug in the code, preventing correct operation (... for user
> names / passwords with non-7bit characters in them), or is this just
> unrelated improvement?

This change/function is important because it provides a correct
conversion of non-7bit-characters which are assumed to have utf-8
encoding.
The previous simpler function worked only for 7bit ascii characters.

>
>> +  const unsigned int uni_max_utf16      = 0x0010FFFF,
>> +                     uni_half_base      = 0x00010000,
>> +                     uni_half_mask      = 0x000003FF,
>> +                     uni_half_shift     = 10,
>> +                     uni_sur_high_start = 0xD800,
>> +                     uni_sur_low_start  = 0xDC00,
>> +                     uni_sur_low_end    = 0xDFFF;
>
> I'm feeling slightly uneasy with these.  If these are true constants,
> is there a good reason to use "const int" variables, and not follow
> the usual convention
>
> #define UNI_MAX_UTF16 ...
> #define UNI_HALF_BASE ...
>
> so it's more obvious to the reader of the code that this is not something
> which can change at run time?

Yes, you're right, they are actually constants.
The reason why I defined them as variables is because I wanted to keep
things together that belong together. I'm a bit unhappy with defining a
constant in a separate .h file that is used only once somewhere in the code.

So what about defining them as constants, but at the same location in the
code as the variable definitions are now?

>
>
>> +      if (ch <= 0xFFFF)
>> +      {
>> +        if (ch >= uni_sur_high_start && ch <= uni_sur_low_end) {
>> +          msg (M_INFO, "Warning: Illegal character value: %x is in reserved area of UTF-16 [%x, %x]", uni_sur_high_start, uni_sur_low_end);
>> +          return -1;
>> +        }
>> +        else {    /* normal case */
>> +          if (dst_len - (dst - dst_start) < 2) {
>> +            msg (M_INFO, "Warning: To less space in destination buffer for conversion to UTF-16");
>
> Grammar nit ;-) - "not enough space".

Ok.

>
>
> [..]
>>     /* fill 1st 16 bytes with md4 hash, disregard terminating null */
>> -  gen_md4_hash (pwbuf, unicodize (pwbuf, p->up.password) - 2, md4_hash);
>> +  gen_md4_hash (pwbuf, utf8_to_utf16LE(pwbuf, sizeof (p->up.password) * 2, (unsigned char*)p->up.password), md4_hash);
>
> I'm a bit confused (again).  It's called "utf8_to_utf16LE()", but the stuff
> we have in OpenVPN variables, at least on unix systems, is not always
> UTF8 - it's "bytes as typed", and they might be ISO8859-1.
>
> All my systems do *not* use UTF8.
>
> So what happens if a user uses a German umlaut as part of his password,
> and types this into an password: prompt given by OpenVPN on an ISO8859-1
> system?

Well, Heiko told me that you guys decided that "we are now in 21st
century and we can assume utf-8 internally" a couple of years ago
(maybe at the first FOSDEM meeting, but he can't recall exactly). If 
other encodings
than utf-8 should also be supported then the input filter of username
and password should take the local encoding into account and provide a
conversion to utf-8.

>
> (Yeah, this sucks, but this issue needs to be well understood before
> merging)

The problem is - to some extend - well understood but we have to agree
on what we can expect as input encoding on the different layers in the 
software.

>
>>
>> +  /* extract NegotiateFlags from bytes 20-23 */
>> +  ntlm_negotiate_flags = (buf2[0x14] & 0xff) | (buf2[0x15] & 0xff) << 8 | (buf2[0x16] & 0xff) << 16 | (buf2[0x17] & 0xff) << 24;
>
> We could make "buf2" an "unsigned char", and save ourselves the & 0xff
> orgy here... and further down setting tib_len.

Well, I'm unsure if that would work on all platforms.
In my experience the above orgy works always under all circumstances
and doesn't give me restless nights ...
But if you're convinced that your proposal works (I just tried it
in a separate test successfully) we could give it a try.

>
>> -		if (( *((long *)&buf2[0x14]) & 0x00800000) == 0x00800000){ /* Check for Target Information block */
>> -			tib_len = buf2[0x28];/* Get Target Information block size */
>> +		if (ntlm_negotiate_flags & NTLM_NEGOTIATE_TARGET_INFO){    /* Check for Target Information block */
>> +			tib_len = buf2[0x28] & 0xff | (buf2[0x29] & 0xff) << 8;  /* Get Target Information block size */
>
> Yeah.  Thanks for this.  Whoever thought that accessing an arbitrary
> and potentially unaligned block of memory as a (long) on "all architectures
> that OpenVPN runs on" should propably be tasked with maintaining options.c
> for the next 10 years, or so.

I think that the main error in the previous implementation lies in the 
assumption of a certain byte order which the new code eliminates.

>
>
>>   		/* Get blob length */
>> -		ntlmv2_blob_size = 0x20 + tib_len;
>> +		ntlmv2_blob_size = 0x1c + tib_len;
>
> What are these magic numbers?  Was 0x20 a bug, and 0x1c is right, or is
> the context different, so the magic number needs to be different?

The 0x20 was a big, big bug which had cost me a long time to find out.
The new number corresponds to the field descriptions in Microsofts' spec.

>
>> +    len = utf8_to_utf16LE(username_u, sizeof(username_u), username);
>> +    if (len>=0) {
>> +      add_security_buffer(0x24, username_u, len, phase3, &phase3_bufpos);
>> +    }
>> +  }
>> +  else {
>> +    add_security_buffer(0x24, username, strlen(username), phase3, &phase3_bufpos);
>> +  }
>> +
>
> I can see that you did not invent add_security_buffer(), but "copying
> arbitrary strings provided by other bits of OpenVPN into a buffer of
> limited length, with no overrun checking" is not *exactly* making me
> feel good at night.  So maybe this should be extended to ensure that
> "*msg_bufpos + length" is not overring sizeof(phase3)...

Agreed. What about adding an additional parameter to 
add_security_buffer() for the total length of 'msg_buf'?


Best regards,
Holger

>
> gert
>

