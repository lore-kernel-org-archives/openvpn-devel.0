Message-ID: <4C7E0A83.3060206@...1294...>
Date: Wed, 01 Sep 2010 10:10:43 +0200
From: Eike Lohmann <e.lohmann@...1294...>
MIME-Version: 1.0
References: <AANLkTina=B8Z8v2euOJYjZxMQhJ9WB6UMdY0qtnc_qyT@...278...>
	<4C7CD670.4030706@...1147...> <4C7CDAD7.9070500@...1294...>
	<20100831113136.GJ10703@...1296...> <4C7CFD59.8080707@...1294...>
	<20100831165110.GK10703@...1296...>
In-Reply-To: <20100831165110.GK10703@...1296...>
Subject: Re: [Openvpn-devel] Netmask OpenVPN Server
Reply-To: e.lohmann@...1294...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net


My mistake, didn't checked that you allready did my math. ;)
Do you have experience with changing"#define IFCONFIG_POOL_MIN_NETBITS
16", is it realy so simple?

The best way for me would be to define 2 different /16 networks on one
server/instance.
E.g. 172.16.0.0/16 and 10.1.0.0/16

Is it possible to add this to the wishlist for the next community meetings?

Regards, Eike


Am 31.08.2010 18:51, schrieb Gert Doering:
> Hi,
>
> On Tue, Aug 31, 2010 at 03:02:17PM +0200, Eike Lohmann wrote:
>   
>> We are also using old openvpn clients with windows, there we have to use 
>> /30 netmasks (4 ip's) and can only configure 4096 users.
>>     
> 65536 / 4 = 16000 :-) - a /16 pool holds 2^16 addresses, I already took
> that into account when asking for the 16000 users.
>
>   
>> To handle the load on the machines we build a cluster with dynamic 
>> routing and yes, we are getting close to the /16 network limit.
>>     
> Amazing.
>
> gert
>   

