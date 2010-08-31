Message-ID: <4C7CFD59.8080707@...1294...>
Date: Tue, 31 Aug 2010 15:02:17 +0200
From: Eike Lohmann <e.lohmann@...1294...>
MIME-Version: 1.0
References: <AANLkTina=B8Z8v2euOJYjZxMQhJ9WB6UMdY0qtnc_qyT@...278...>
	<4C7CD670.4030706@...1147...> <4C7CDAD7.9070500@...1294...>
	<20100831113136.GJ10703@...1296...>
In-Reply-To: <20100831113136.GJ10703@...1296...>
Subject: Re: [Openvpn-devel] Netmask OpenVPN Server
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net


We are also using old openvpn clients with windows, there we have to use 
/30 netmasks (4 ip's) and can only configure 4096 users.
To handle the load on the machines we build a cluster with dynamic 
routing and yes, we are getting close to the /16 network limit.


Am 31.08.2010 13:31, schrieb Gert Doering:
> Hi,
>
> On Tue, Aug 31, 2010 at 12:35:03PM +0200, Eike Lohmann wrote:
>> In the past only /16 networks were possibel per openvpn instance.
>> Is it now possibel to define larger networks or define 2x /16 networks
>> on one openvpn instance?
> I assume that you're talking about this error message:
>
>    --server directive netmask allows for too many host addresses (subnet must be %s or higher)
>
> right?  If yes, it should work to change
>
> #define IFCONFIG_POOL_MIN_NETBITS    16
>
> in pool.h to "14" (etc) and recompile - every extra bit will double
> memory consumption [for the pool handling, of I remember right], so
> use with care.
>
> (You really have more than 16000 users on a single OpenVPN instance?
> Wow, I'm impressed!)
>
> gert
>


