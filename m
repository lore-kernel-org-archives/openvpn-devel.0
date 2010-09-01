Message-ID: <4C7E1228.5040103@...1147...>
Date: Wed, 01 Sep 2010 10:43:20 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <AANLkTina=B8Z8v2euOJYjZxMQhJ9WB6UMdY0qtnc_qyT@...278...>	<4C7CD670.4030706@...1147...>
	<4C7CDAD7.9070500@...1294...>	<20100831113136.GJ10703@...1296...>
	<4C7CFD59.8080707@...1294...>	<20100831165110.GK10703@...1296...>
	<4C7E0A83.3060206@...1294...>	<20100901082202.GR10703@...1296...>
	<4C7E10E9.8000000@...1294...>
In-Reply-To: <4C7E10E9.8000000@...1294...>
Subject: Re: [Openvpn-devel] Netmask OpenVPN Server
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
To: e.lohmann@...1294...
Cc: openvpn-devel@lists.sourceforge.net

Hi Eike,

Eike Lohmann wrote:
> We are working with static assignments and if the 2 networks are side by
> side I can recompile the code and define a larger mask.
> Is this also working if I have 2 networks far away from each other (10.x
> and 192.168.x), with defining a 'all your base belong to us' netmask in
> the code e.g. 0.0.0.0 :)
>
> We don't have client-2-client and didn't use the ifconfig-pool.
>
>
>   
if you're not using ifconfig-pool then you can do this without 
recompiling anything; use a 'learn-addr' script or 'client-connect' 
script to assign addresses and do NOT use the 'server' statement (see my 
previous posting).

cheers,

JJK

> Am 01.09.2010 10:22, schrieb Gert Doering:
>   
>> Well, this really depends on what you want to do with it.  If you want
>> to do static assignments (ifconfig-push in ccd/ or via radius-plugin),
>> this can be done today.  If you want the ifconfig-pool to span two 
>> different networks, this can not be done today - there can only be one 
>> pool, and it must be contiguous.
>>   
>>     


