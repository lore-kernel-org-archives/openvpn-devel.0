From: Arkadiusz Patyk <areq@...104...>
Subject: Re: [Openvpn-devel] Re: [Openvpn-users] OpenVPN 2.0 and firewall
Message-ID: <kj4m60ho79bletouqcqtjgfdun8ndmgsuq@...105...>
References: <3g1m601tpk17aspv8aqck8fufppj7td0k7@...105...> <twig.1080758385.28854@...41...>
In-Reply-To: <twig.1080758385.28854@...41...>
MIME-Version: 1.0
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
Date: Wed Mar 31 11:07:12 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Wed, 31 Mar 2004 18:39:45 -0000, you wrote:

>Arkadiusz Patyk <areq@...104...> said:
>
>> Hi
>> 
>> Two very significant things for me are:
>> 1. In my configurations, VPN users have different rights to resources
>> (access list on firewall - iptables).   I have to know client IP to
>> correctly setup firewall, how can i do this in 2.x ?   How can i
>> achieve this, in case of dynamic IP assignment
>
>You can use the --ipchange script which is passed the common name and source
>IP address every time a client connects.  I probably need to add a new
>environmental variable that contains the dynamically allocated --ifconfig-pool
>subnet.

with dropping privileges and chroot  it could be difficult  ;(

Is any script executed after the connection termination?

>> 2. Is it possible to run few servers (each of them on their own tap)
>> on the same machine?
>
>Yes, it is possible to run many '--mode server' servers on the same machine,
>each having their own tun interface (tap interfaces are not supported yet in
>--mode server mode).
>
>This would be a good way to differentiate access rights for different client
>classes.

Not in my particular case - i have diffrent access list for each user
- N users  = N server = openvpn 1.x ;-)


-- 
Arkadiusz Patyk [areq(at)pld-linux.org] [http://rescuecd.pld-linux.org/]
[IRC:areq ICQ:16231667  GG:1383]  [AP3-6BONE] [AP14126-RIPE]

