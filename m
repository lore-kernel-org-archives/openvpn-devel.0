Message-ID: <47152879.6070106@...1060...>
Date: Tue, 16 Oct 2007 17:09:13 -0400
From: Barry Michels <bmichels@...1060...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Strange VPN Problem
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

Client's firewall is off.  I have full access from my home pc (which is 
another network on our 4 network routed VPN).

In an attempt to relieve bandwidth bottlenecks, I've converted our 
network into a mesh.  It used to be our main office was the central hub 
for all VPN traffic.  But, when these weird issues started coming up, I 
made a mesh network.  However, the same problems still exist.  It did 
relieve the slow RDP connections between 2 of our offices, but this one 
problem (having some ports work, but not others) was present before and 
after the change.


Barry

Ross Cameron wrote:
> perhapse firewall settings on the machine u're trying to RDP to?
>
> On 15/10/2007, Barry Michels <bmichels@...1060...> wrote:
>  
>> I am having a strange problem with 2.0.9.  I have a routed VPN
>> connection and can ping from/to any pc between networks.  I can even VNC
>> into any machine.  But, RDP fails.  I have the MTU set to 1000 after
>> finding a reference that indicated that may fix the problem.
>>
>> Any suggestions?
>>
>> Barry
>>
>>     



