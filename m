Message-ID: <5206A56A.1040408@...515...>
Date: Sat, 10 Aug 2013 14:41:14 -0600
From: James Yonan <james@...515...>
MIME-Version: 1.0
References: <0fd116f0-0192-489f-a313-8e7a6cc9a184@...1835...>
In-Reply-To: <0fd116f0-0192-489f-a313-8e7a6cc9a184@...1835...>
Subject: Re: [Openvpn-devel] TLSv1.2 and Suite B
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
To: openvpn-devel@lists.sourceforge.net

Interesting paper...  So what are the current blockers for OpenVPN 
supporting ECC with OpenSSL?

We will certainly consider any patch that addresses these issues.

James

On 05/08/2013 10:30, Asim Ali wrote:
>> I would like to know where OpenVPN stands on having TLS 1.2 working
>> with Suite B cryptography (http://tools.ietf.org/html/rfc6460
>> <mailto:openvpn-devel@lists.sourceforge.net>).
>>
>>
>> My colleagues and I want to use
>> TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384 ciphersuite which is supported
>> by OpenSSL. But cannot get it to work with OpenVPN.
>>
>>
>> The closest we can get to work is TLS_ECDH_ECDSA_WITH_AES_256_CBC_SHA
>> which is only TLS 1.0.
>>
>>
>> Our push for Suite B is coming from this...
>> https://media.blackhat.com/us-13/us-13-Stamos-The-Factoring-Dead.pdf
>>
>>
>> Please let me know your thoughts on this matter.
>>
>>
>> Thank you.
>>
>>
>> Asim
>
>
> ------------------------------------------------------------------------------
> Get your SQL database under version control now!
> Version control is standard for application code, but databases havent
> caught up. So what steps can you take to put your SQL databases under
> version control? Why should you start doing it? Read more to find out.
> http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

