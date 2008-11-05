Message-ID: <4911D76D.7020202@...1140...>
Date: Wed, 05 Nov 2008 18:27:09 +0100
From: Frank Behrens <frank@...1140...>
MIME-Version: 1.0
References: <200810271301.m9RD1BKT006709@...1141...>
	<49109F75.8000804@...41...>
In-Reply-To: <49109F75.8000804@...41...>
Subject: Re: [Openvpn-devel] [patch] enhance compatibility with HTTP/1.1
	proxies
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
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

James Yonan schrieb:
> Frank Behrens wrote:
>> May I propose the following patch to enhance openvpn's compatibility 
>> with HTTP/1.1 proxies?
>> See
>> http://tools.ietf.org/html/rfc2616#section-14.23
>> and
>> http://tools.ietf.org/html/rfc2817#section-5.2
>>
>> --- proxy.c.orig    2008-10-06 09:22:20.000000000 +0200
>> +++ proxy.c    2008-10-27 13:30:48.000000000 +0100
>> @@ -348,6 +348,12 @@
>>    if (!send_line_crlf (sd, buf))
>>      goto error;
>>  
>> +  /* send Host: header */
>> +  openvpn_snprintf (buf, sizeof(buf), "Host: %s:%d",
>> +            host, port);
>> +  if (!send_line_crlf (sd, buf))
>> +    goto error;
>> +
>>    /* send User-Agent string if provided */
>>    if (p->options.user_agent)
>>      {
>
> Shouldn't you check p->options.http_version and make sure it's >= 1.1 
> before sending the Host header?
>
> James

Cuurently I can not imagine a server/proxy, that does not understand the 
Host header?
see also http://www.w3.org/Protocols/rfc2616/rfc2616-sec19.html#sec19.6.1.1

But to be on the safe side we can make this check. I would check for 
http_version != "1.0". Currently I'm not able to send a revised patch, 
if desired I can make this until weekend.

Thanks for your attention!
   Frank



