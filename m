Message-ID: <9e0cf0bf0801150522x72621b20pc36373986f2ad8a1@...278...>
Date: Tue, 15 Jan 2008 15:22:25 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <478CAD6A.3010808@...1068...>
MIME-Version: 1.0
References: <478C94C4.1050409@...1068...>
	<9e0cf0bf0801150345i749f5ca6na1f8343b6da390fc@...278...>
	<9e0cf0bf0801150345p4639a831ub8f85fd56bda48db@...278...>
	<478CAD6A.3010808@...1068...>
Subject: Re: [Openvpn-devel] NTLMv2 patch corrected
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Mirek Zajic <zajic@...1068...>
Cc: openvpn-devel@lists.sourceforge.net

On 1/15/08, Mirek Zajic <zajic@...1068...> wrote:
> Thank you for info. I wanted to use equal indentation rules in the whole
> file. I'm sending another patch without these indentation changes.
>
> Also, this code was originally written for x86 processors with 32-bit
> environment. Different wordsize or endian may cause trouble when porting
> to other platforms. Does anybody want to use this feature with some
> strange processor?

Sure!
This should be architecture independent.

Why have you added the keep alive?
If you think this is required, I think you should add a new option for
this unrelated to ntlm. Maybe selecting ntlm should enable it... But I
am not sure these are related.

Some general none logical comments bellow...
After you will have architecture independent code, please resend.

Alon.

> +static void
> +gen_hmac_md5 (const char* data, int data_len, const char* key, int
> key_len,char *result)
> +{
> +    unsigned int len;
> +
> +    HMAC_CTX c;
> +    HMAC_Init (&c, key, key_len, EVP_md5());
> +    HMAC_Update (&c, data, data_len);
> +    HMAC_Final (&c, result, &len);
> +    HMAC_CTX_cleanup(&c);

No return codes?

> +}
> +
> +static void
> +gen_timestamp (unsigned char *timestamp)
> +{
> +    /* Copies 8 bytes long timestamp into "timestamp" buffer.
> +     * Timestamp is Little-endian, 64-bit signed value representing the
> number of tenths of a microsecond since January 1, 1601.
> +     */
> +
> +    unsigned char bufA[8]; /* Buffer for 64-bit computing */
> +    unsigned char bufB[8]; /* Second buffer  */

What is first buffer and second buffer, please find proper names.

> +    int a, b, c, tmp, tmp2, carry;
> +
> +    /* set 64-bit buffer A with current time (seconds since 00:00:00
> 1.1.1970) */
> +    *(unsigned int *)bufA =     (unsigned int)time(NULL);

Use openvpn_time.

> +    *(unsigned int *)&bufA[4] = (unsigned int)0;
> +
> +    /* 64-bit adition of 0x02B6109100 (seconds between 00:00:00
> 1.1.1601 and 00:00:00 1.1.1970) */
> +    *(unsigned int *)bufB =     (unsigned int)0xB6109100;
> +    *(unsigned int *)&bufB[4] = (unsigned int)0x00000002;
> +
> +    carry=0;
> +    for (a=0; a<8; a++){ /* lame adition */
> +        tmp = (unsigned int)bufA[a] + (unsigned int)bufB[a] + carry;
> +        bufA[a] = tmp & 0xFF;
> +        carry = (tmp & 0xFF00) >> 8;
> +    }
> +
> +    /* 64-bit multiply by 10000000 = 0x989680 (converting seconds to
> tenths of microseconds) */
> +    *(unsigned int *)bufB =           (unsigned int)0x00989680;
> +    *(unsigned int *)&bufB[4] =       (unsigned int)0x00000000;
> +    *(unsigned int *)timestamp =      (unsigned int)0x00000000;
> +    *(unsigned int *)&timestamp[4] =  (unsigned int)0x00000000;
> +
> +    for (a=0; a<8; a++){ /* lame multiply */
> +        for (b=0; b<8; b++){
> +            tmp = (unsigned int)bufA[a] * (unsigned int)bufB[b];
> +            carry=0;
> +            for (c=b; (c<8-a) && (c < b + 3); c++){
> +                tmp2 = ((tmp & (0xFF << ((c-b) * 8))) >> ((c-b) * 8)) +
> (unsigned int)timestamp[a+c] + carry;
> +                timestamp[a+c] = tmp2 & 0xFF;
> +                carry = (tmp2 & 0xFF00) >> 8;
> +            }
> +        }
> +    }
> +}

I believe that the above can be achieved using 64bit ops... long long
on none MS compiler and LONGLONG or something similar on Microsoft
ones.

> +
> +static void
> +gen_nonce (unsigned char *nonce)
> +{
> +    /* Generates 8 random bytes to be used as client nonce */
> +    int i;
> +
> +    for(i=0;i<8;i++);
> +        nonce[i] = (unsigned char)random();

Use get_random.

> +}
> +
> +unsigned char *my_strupr(unsigned char *str)
> +{
> +    /* converts string to uppercase in place */
> +
> +    unsigned char *tmp;
> +    tmp = str;

Use toupper

> +    do
> +    {
> +        if (*str >= 'a' && *str <= 'z')
> +            *str -= 32;
> +    }
> +    while (*(++str));
> +    return tmp;
> +}
> +
>  static int
>  unicodize (char *dst, const char *src)
>  {
> @@ -85,6 +169,17 @@
>    return i;
>  }
>
> +static void
> +add_security_buffer(int sb_offset, void *data, int length, unsigned
> char *msg_buf, int *msg_bufpos)
> +{

Well, this is not architecture independent.

> +    /* Adds security buffer data to a message and sets security
> buffer's offset and length */
> +    msg_buf[sb_offset] = (unsigned char)length;
> +    msg_buf[sb_offset + 2] = msg_buf[sb_offset];
> +    msg_buf[sb_offset + 4] = *msg_bufpos;
> +    memcpy(&msg_buf[*msg_bufpos], data, msg_buf[sb_offset]);
> +    *msg_bufpos += length;
> +}
> +

> -  phase3[0x14] = 24; /* ntlm response is 24 bytes long */
> -  phase3[0x16] = phase3[0x14];
> -  phase3[0x18] = 0x40; /* ntlm offset */
> -  memcpy (&(phase3[0x40]), response, 24);
> -
> -
> -  phase3[0x24] = strlen (p->up.username); /* username in ascii */
> -  phase3[0x26] = phase3[0x24];
> -  phase3[0x28] = 0x58;
> -  strncpy (&(phase3[0x58]), p->up.username, sizeof (phase3) - 0x58);
> -
> +    if (ntlmv2_enabled){ /* Generate NTLMv2 response */
> +
> +        /* NTLMv2 hash */
> +        my_strupr(strcpy(userdomain, username));
> +        if (strlen(username) + strlen(domain) < sizeof(userdomain))
> +            strcat(userdomain, domain);

And if not?

