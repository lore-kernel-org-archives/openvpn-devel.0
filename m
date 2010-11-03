Message-ID: <4CD1849D.5070902@...1147...>
Date: Wed, 03 Nov 2010 16:49:49 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <20101103145140.GN7065@...1152...> <4CD179F0.8040503@...1147...>
	<20101103151426.GT7065@...1152...>
In-Reply-To: <20101103151426.GT7065@...1152...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Variable-Expansion withon
	*.ovpn files?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Ralf Hildebrandt <Ralf.Hildebrandt@...1152...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, openvpn-users@lists.sourceforge.net

Ralf Hildebrandt wrote:
> * Jan Just Keijser <janjust@...1147...>:
>
>   
>>> Does openvpn handle Variable-Expansion within its config files?
>>> e.g.pkcs12 %HOMEPATH%\\client.p12
>>>       
>
>   
>> not that I am aware of and not that I can find in the OpenVPN sources ; 
>> the word 'getenv' appears nowhere in the sources, suggesting that 
>> OpenVPN does not look at any environment variables.
>>     
>
> OK. It was just an idea, since it would enable users to keep their
> certificate in their "own" directories.
>
>
>   
I like the idea and I think it's fairly trivial to implement. Let's 
enter it as a feature request ...

cheers,

JJK


