References: <1397645317-20116-2-git-send-email-Holger.Kummert@...1516...>
	<1404459325-11064-1-git-send-email-Holger.Kummert@...1516...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <561D8BCF.60304@...1856...>
Date: Wed, 14 Oct 2015 00:55:11 +0200
MIME-Version: 1.0
In-Reply-To: <1404459325-11064-1-git-send-email-Holger.Kummert@...1516...>
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
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi Holgert,

Apologies for taking so long to respond.  This patch came up again at 
the hackathon last weekend.  Since we can not thoroughly test this 
ourselves, but the patch is coming from a known source and you report 
successful tests, we decided that 'stare at code' should suffice. 
Hereby the results of my staring.

First, ntlm.c was a type mess before your patch, and still is after. 
I'll not comment on that any further, but will send a follow-up patch to 
fix it later on.  It would be highly appreciated if you could give that 
patch a test spin for me.

On 04-07-14 09:35, Holger Kummert wrote:
> +  const char trailingBytesForUTF8[256] = {
> +              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
> +              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
> +              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
> +              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
> +              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
> +              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
> +              1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
> +              2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2, 3,3,3,3,3,3,3,3,4,4,4,4,5,5,5,5
> +  };

Not sure if the compiler will actually put this on the stack, but this 
can be static const.

> +        if (ch >= UNI_SUR_HIGH_START && ch <= UNI_SUR_LOW_END) {
> +          msg (M_INFO, "Warning: Illegal character value: %x is in reserved area of UTF-16 [%x, %x]", UNI_SUR_HIGH_START, UNI_SUR_LOW_END);
> +          return -1;
> +        }

This msg() call is missing an argument (I think 'ch').

>   static void
> -add_security_buffer(int sb_offset, void *data, int length, unsigned char *msg_buf, int *msg_bufpos)
> +add_security_buffer(int sb_offset, void *data, int length, unsigned char *msg_buf, int *msg_bufpos, int msg_buflen)
>   {
> +  if ((*msg_bufpos - *msg_buf) + length > msg_buflen) {
> +    msg (M_INFO, "Warning: Not enough space in destination buffer");
> +    return;
> +  }
> +

I don't think this is what you intended, or does *msg_buf contain some 
magic length field?  You probably want something like:

   ASSERT (length > 0 && *msg_bufpos > 0 && msg_buflen > 0);
   if (msg_buflen - length < msg_bufpos) { /* error */ }

That should be an integer-overflow safe overflow check.

Since we're also writing to sb_offset to sb_offset+5, we should also add 
a check on sb_offset:

   if (msg_buflen - 5 >= sb_offset) { /* error */ }

(And wow, this function was/is absolutely terrifying.  It seems like a 
miracle that this code ever worked...)

-Steffan

