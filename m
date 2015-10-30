References: <1397645317-20116-2-git-send-email-Holger.Kummert@...1516...>
	<1404459325-11064-1-git-send-email-Holger.Kummert@...1516...>
	<561D8BCF.60304@...1856...> <563371FD.70206@...1516...>
	<CAA1AbxKuF3ewuhn_XTvymCfq_my8vqK+-Q1mj59VBZp4jOK7VA@...278...>
From: Holger Kummert <Holger.Kummert@...1516...>
Message-ID: <563379B3.90905@...1516...>
Date: Fri, 30 Oct 2015 15:07:47 +0100
MIME-Version: 1.0
In-Reply-To: <CAA1AbxKuF3ewuhn_XTvymCfq_my8vqK+-Q1mj59VBZp4jOK7VA@...278...>
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
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>



Am 30.10.2015 um 14:58 schrieb Steffan Karger:
> Hi Holger,
>
> On Fri, Oct 30, 2015 at 2:34 PM, Holger Kummert
> <Holger.Kummert@...1489...> wrote:
>>>>     static void
>>>> -add_security_buffer(int sb_offset, void *data, int length, unsigned char *msg_buf, int *msg_bufpos)
>>>> +add_security_buffer(int sb_offset, void *data, int length, unsigned char *msg_buf, int *msg_bufpos, int msg_buflen)
>>>>     {
>>>> +  if ((*msg_bufpos - *msg_buf) + length > msg_buflen) {
>>>> +    msg (M_INFO, "Warning: Not enough space in destination buffer");
>>>> +    return;
>>>> +  }
>>>> +
>>>
>>> I don't think this is what you intended, or does *msg_buf contain some
>>> magic length field?  You probably want something like:
>>>
>>>      ASSERT (length > 0 && *msg_bufpos > 0 && msg_buflen > 0);
>>>      if (msg_buflen - length < msg_bufpos) { /* error */ }
>>>
>>> That should be an integer-overflow safe overflow check.
>>
>> Hmm, I think it won't work as msg_bufpos is a pointer into memory, right?
>> What about improving the first version with
>>
>>     ASSERT (length > 0 && *msg_bufpos > 0 && msg_buflen > 0);
>>     if ((msg_bufpos - msg_buf) + length > msg_buflen) {
>>       ...
>
> Seems I forgot the * before the second msg_bufpos, sorry.  msg_bufpos
> itself is a pointer indeed, but *msg_bufpos is (used as) an offset
> into msg_buf:
>
>     memcpy(&msg_buf[*msg_bufpos], data, msg_buf[sb_offset]);
>
> msg_bufpos (without the *) is not related to msg_buf.

Ah, then your first proposal makes sense
(i.e. if (msg_buflen - length < *msg_bufpos) )

We could take that.

Sry, didn't look into the ntlm-code ...


Regards,
Holger

