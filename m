Message-ID: <4BD0BFAF.4060002@...1147...>
Date: Thu, 22 Apr 2010 23:29:19 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <20100422111337.7ABB521DCF7@...1353...>	<201004221829.13824.dave_br@...1278...>	<201004222153.28610.dave_br@...1278...>
	<201004222206.26989.dave_br@...1278...>
In-Reply-To: <201004222206.26989.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [PATCH-fixed] revocation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net

Davide Brini wrote:
> On Thursday 22 April 2010, Davide Brini wrote:
>   
>> (moving to -devel as this is obviously pertains there more than -users)
>>     
>
> Sorry, too quick! I posted an incomplete version of the patch. The attached 
> one should be better.
>
> The only doubt I have is about error handling; in this case, if the allocation 
> of the BIO fails, an error message is logged and nothing is done. Is this the 
> right thing to do?
>
>   
I don't know if a FATAL error is such a good thing - not being able to 
set an env var does not warrant a server crash , I'd say.
Also, you're not freeing the BIO as far as I can tell.

apart from that: nice patch !

cheers,

JJK


