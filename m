Message-ID: <53BFAF81.2080705@...1147...>
Date: Fri, 11 Jul 2014 11:33:53 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <53BF9998.5020906@...1921...> <53BFA5AA.4070305@...1147...>
	<53BFA759.7060307@...1227...> <53BFA9A0.3020605@...1147...>
	<53BFACDE.9050609@...1227...>
In-Reply-To: <53BFACDE.9050609@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Add topology in sample server
 configuration file
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Arne,

Arne Schwabe wrote:
>> This is really not *necessary*, but the way the code does tun & tap and
>> net30 & subnet, it gets confused about things.  Needs fixing, sorry for
>> that.
>>
>>
>>
>> so in some cases a server-side statement
>>  route 192.168.1.0 255.255.255.0
>> works fine with 'topology net30' but NOT with 'topology subnet'.
>>
>> This is a long standing bug that needs to be fixed before we can
>> forcefeed everybody 'topology subnet'.
>>     
>
> Okay. I see where the confusion is coming from. if you have net30, the
> second parameter for the ifconfig is always the gateway. In subnet you
> explicity need to set the gateway by setting/pushing route-gateway.
>
> In normal setups the --server macro automatically does that for you.
>   
I wish this were true. Consider the following server config:

proto udp
port 1194
dev tun
server 192.168.200.0 255.255.255.0
ca       /etc/openvpn/cookbook/ca.crt
cert     /etc/openvpn/cookbook/server.crt
key      /etc/openvpn/cookbook/server.key
dh       /etc/openvpn/cookbook/dh1024.pem
tls-auth /etc/openvpn/cookbook/ta.key 0
persist-key
persist-tun
keepalive 10 60
push "route 10.198.0.0 255.255.0.0"
user  nobody
group nobody
client-config-dir /etc/openvpn/cookbook/clients
route 192.168.4.0 255.255.255.0

(example from my cookbook)
this example works fine 'as is' but if you add
  topology subnet
you get

Fri Jul 11 11:31:28 2014 OpenVPN ROUTE: OpenVPN needs a gateway 
parameter for a --route option and no default was specified by either 
--route-gateway or --ifconfig options
Fri Jul 11 11:31:28 2014 OpenVPN ROUTE: failed to parse/resolve route 
for host/network: 192.168.4.0
Fri Jul 11 11:31:28 2014 TUN/TAP device tun0 opened


so the 'server' macro does not seem to properly publish this in all cases.

JJK


