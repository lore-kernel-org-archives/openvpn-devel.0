Message-ID: <41922817.9070309@...289...>
From: Vlada Macek <tuttle@...289...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Re: [Openvpn-users] IANA has approved a unique
 port number for OpenVPN
References: <twig.1100040511.60533@...41...> <20041110000335.GB17347@...307...> <pan.2004.11.10.00.13.04.776012@...294...>
In-Reply-To: <pan.2004.11.10.00.13.04.776012@...294...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Nov 10 06:40:01 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: openvpn-users@lists.sourceforge.net

>On Wed, 10 Nov 2004 01:03:35 +0100, Stefan `Sec` Zehl wrote:
>  
>
>>Can the server support listening on two ports at the same time? This
>>would make migration much easier.
>>    
>>
>
>It should be straightforward enough to have your firewall redirect
>incoming connections from the old port to the new.
>  
>
Congrats for the assigned port number, James.


If I may express my opinion, I think the change should be made ASAP.
IMO, duping the listening port is the right job for the protecting
firewall (that I presume everyone is running), not the end-listening
software. Please, don't make OpenVPN more complex than necessary. There
are already so many features!

I see default listening port as a rather smaller issue, every decent
admin should be able to spot the change between releases when he/she
read the announcements and change the configuration accordingly. No need
for such concession from my point of view.

-- 

\//\/\
(Sometimes credited as 1494 F8DD 6379 4CD7 E7E3 1FC9 D750 4243 1F05 9424.)


