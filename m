Message-ID: <4D46FEAB.3010804@...1449...>
Date: Mon, 31 Jan 2011 19:25:47 +0100
From: Stefan Hellermann <stefan@...1449...>
MIME-Version: 1.0
References: <4D4208C9.6000206@...1449...>	<201101280951.40901.dave_br@...1278...>	<AANLkTimxnodRxe_mdeFxw=-eB9uQ8EebxLq6=cJNvYWM@...278...>
	<201101281209.29673.dave_br@...1278...>
In-Reply-To: <201101281209.29673.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] udp6 source-address wrong with
 more than one ipv6-address on server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Am 28.01.2011 13:09, schrieb Davide Brini:
> On Friday 28 Jan 2011 11:57:30 Stefan Hellermann wrote:
> 
>>> Are you using the "multihome" option in the server configuration? As far
>>> as I can tell, using "multihome" uses the PKTINFO information to source
>>> UDP replies from the correct IP address; however, while it does work for
>>> IPv4, I don't know if that functionality has been ported to IPv6
>>> already. I'm CC-ing the devel list as well.
>>
>> No I haven't tried multihome, and I don't know why I haven't seen this
>> option before... Why isn't this the default?
>> But, it seems it doesn't work for IPv6 yet, I get this:
>>
>> Jan 28 11:37:22 openvpn(server)[17978]: read UDPv6 [NO-INFO]: Connection
>> refused (code=146)
>> Jan 28 11:37:24 openvpn(server)[17978]: read UDPv6 [NO-INFO]: Connection
>> refused (code=146)
>> Jan 28 11:37:26 openvpn(server)[17978]: read UDPv6 [NO-INFO]: Connection
>> refused (code=146)
>> Jan 28 11:37:29 openvpn(server)[17978]: read UDPv6 [NO-INFO]: Connection
>> refused (code=146)
> 
> Not 100% sure but this may mean that multihome has not been ported to IPv6 
> yet. Perhaps you can open a ticket at
> 
> https://community.openvpn.net/openvpn
> 
> (you have to register and login first).
> 
>> With tcp6-server this works.
> 
> Yes, because with TCP the source address selection is performed directly by 
> the OS internally. Using TCP was indeed the suggested workaround before UDP 
> multihoming was introduced in OpenVPN.
> 

https://community.openvpn.net/openvpn/ticket/84

