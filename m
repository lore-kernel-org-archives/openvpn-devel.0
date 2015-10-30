MIME-Version: 1.0
In-Reply-To: <563371FD.70206@...1516...>
References: <1397645317-20116-2-git-send-email-Holger.Kummert@...1516...>
	<1404459325-11064-1-git-send-email-Holger.Kummert@...1516...>
	<561D8BCF.60304@...1856...> <563371FD.70206@...1516...>
From: Steffan Karger <steffan@...1856...>
Date: Fri, 30 Oct 2015 14:58:21 +0100
Message-ID: <CAA1AbxKuF3ewuhn_XTvymCfq_my8vqK+-Q1mj59VBZp4jOK7VA@...278...>
Subject: Re: [Openvpn-devel] [PATCHv2 1/2] Get NTLMv1 and NTLMv2 up and
	running
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
To: Holger Kummert <Holger.Kummert@...1489...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi Holger,

On Fri, Oct 30, 2015 at 2:34 PM, Holger Kummert
<Holger.Kummert@...1489...> wrote:
>>>    static void
>>> -add_security_buffer(int sb_offset, void *data, int length, unsigned char *msg_buf, int *msg_bufpos)
>>> +add_security_buffer(int sb_offset, void *data, int length, unsigned char *msg_buf, int *msg_bufpos, int msg_buflen)
>>>    {
>>> +  if ((*msg_bufpos - *msg_buf) + length > msg_buflen) {
>>> +    msg (M_INFO, "Warning: Not enough space in destination buffer");
>>> +    return;
>>> +  }
>>> +
>>
>> I don't think this is what you intended, or does *msg_buf contain some
>> magic length field?  You probably want something like:
>>
>>     ASSERT (length > 0 && *msg_bufpos > 0 && msg_buflen > 0);
>>     if (msg_buflen - length < msg_bufpos) { /* error */ }
>>
>> That should be an integer-overflow safe overflow check.
>
> Hmm, I think it won't work as msg_bufpos is a pointer into memory, right?
> What about improving the first version with
>
>    ASSERT (length > 0 && *msg_bufpos > 0 && msg_buflen > 0);
>    if ((msg_bufpos - msg_buf) + length > msg_buflen) {
>      ...

Seems I forgot the * before the second msg_bufpos, sorry.  msg_bufpos
itself is a pointer indeed, but *msg_bufpos is (used as) an offset
into msg_buf:

   memcpy(&msg_buf[*msg_bufpos], data, msg_buf[sb_offset]);

msg_bufpos (without the *) is not related to msg_buf.

-Steffan

On Fri, Oct 30, 2015 at 2:34 PM, Holger Kummert
<Holger.Kummert@...1489...> wrote:
>
> Hello Steffan,
>
> Am 14.10.2015 um 00:55 schrieb Steffan Karger:
>> Hi Holgert,
>>
>> Apologies for taking so long to respond.  This patch came up again at
>> the hackathon last weekend.  Since we can not thoroughly test this
>
> no problem. I'm glad that someone picks this topic up.
>
>> ourselves, but the patch is coming from a known source and you report
>> successful tests, we decided that 'stare at code' should suffice.
>> Hereby the results of my staring.
>>
>> First, ntlm.c was a type mess before your patch, and still is after.
>> I'll not comment on that any further, but will send a follow-up patch to
>> fix it later on.  It would be highly appreciated if you could give that
>> patch a test spin for me.
>
> Hmm, setting up an environment for testing is a bit lengthy.
> But let's see ...
>
>>
>> On 04-07-14 09:35, Holger Kummert wrote:
>>> +  const char trailingBytesForUTF8[256] = {
>>> +              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
>>> +              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
>>> +              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
>>> +              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
>>> +              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
>>> +              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
>>> +              1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
>>> +              2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2, 3,3,3,3,3,3,3,3,4,4,4,4,5,5,5,5
>>> +  };
>>
>> Not sure if the compiler will actually put this on the stack, but this
>> can be static const.
>>
>>> +        if (ch >= UNI_SUR_HIGH_START && ch <= UNI_SUR_LOW_END) {
>>> +          msg (M_INFO, "Warning: Illegal character value: %x is in reserved area of UTF-16 [%x, %x]", UNI_SUR_HIGH_START, UNI_SUR_LOW_END);
>>> +          return -1;
>>> +        }
>>
>> This msg() call is missing an argument (I think 'ch').
>
> Yes, obviously true.
>
>>
>>>    static void
>>> -add_security_buffer(int sb_offset, void *data, int length, unsigned char *msg_buf, int *msg_bufpos)
>>> +add_security_buffer(int sb_offset, void *data, int length, unsigned char *msg_buf, int *msg_bufpos, int msg_buflen)
>>>    {
>>> +  if ((*msg_bufpos - *msg_buf) + length > msg_buflen) {
>>> +    msg (M_INFO, "Warning: Not enough space in destination buffer");
>>> +    return;
>>> +  }
>>> +
>>
>> I don't think this is what you intended, or does *msg_buf contain some
>> magic length field?  You probably want something like:
>>
>>     ASSERT (length > 0 && *msg_bufpos > 0 && msg_buflen > 0);
>>     if (msg_buflen - length < msg_bufpos) { /* error */ }
>>
>> That should be an integer-overflow safe overflow check.
>
> Hmm, I think it won't work as msg_bufpos is a pointer into memory, right?
> What about improving the first version with
>
>    ASSERT (length > 0 && *msg_bufpos > 0 && msg_buflen > 0);
>    if ((msg_bufpos - msg_buf) + length > msg_buflen) {
>      ...
> ?
>
>>
>> Since we're also writing to sb_offset to sb_offset+5, we should also add
>> a check on sb_offset:
>>
>>     if (msg_buflen - 5 >= sb_offset) { /* error */ }
>
> Yes, makes sense.
>
>
> Regards,
> Holger
>
>>
>> (And wow, this function was/is absolutely terrifying.  It seems like a
>> miracle that this code ever worked...)
>>
>> -Steffan
>>
>> ------------------------------------------------------------------------------
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
>
> ------------------------------------------------------------------------------
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

