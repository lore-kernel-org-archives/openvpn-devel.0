Message-Id: <26151F83-CD19-4608-9F19-B3D0D2590B46@...1198...>
From: Andy Sykes <a.sykes@...1198...>
In-Reply-To: <4A5C362C.5020703@...1164...>
Mime-Version: 1.0 (Apple Message framework v935.3)
Date: Tue, 14 Jul 2009 10:09:14 +0100
References: <4A5C362C.5020703@...1164...>
Subject: Re: [Openvpn-devel] [Fwd: [Openvpn-users] Bridging OpenVPN on an
	interface that has multiple virtual aliases]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Emrah <eka@...1164...>
Cc: openvpn-devel@lists.sourceforge.net

I use aliases of the bridge device instead.

So instead of eth0:0, eth0:1, I have br0:0, br0:1, etc. Works fine for  
me. I have a startup script that sets up the interfaces and starts  
OpenVPN.

It starts the bridge between eth0 and tap0, then adds aliases to the  
new br0 interface.

Works fine for me on a bunch of boxes.

Andy.

On 14 Jul 2009, at 08:39, Emrah wrote:

> Hello Dev guys,
>
> Any idea here about my issue?
>
> Best regards,
> Emrah
>
>
> I am trying to use OpenVPN in bridge mode on a box that has multiple  
> IP
> aliases. eth0, eth0:0, eth0:1 and so on.
> My questions are:
> * What are the interfaces I am supposed to bridge? Only eth0 or
> additional stuff?
> * Once eth0 and tap0 become br0, how do I listen to my IP addresses  
> like
> I used to do with eth0:x?
>
> For instance, when I bridge eth0 and I boot a virtual server that is
> supposed to listen on eth0:0, my ifconfig shows br0 with the main IP  
> and
> eth0 with the alias IP address. Both are reachable but users are not
> bridged anymore.
>
>
> Your help will be greately appreciated. I'm stuck!
>
> Cheers,
> Emrah
>
> ------------------------------------------------------------------------------
> Enter the BlackBerry Developer Challenge
> This is your chance to win up to $100,000 in prizes! For a limited  
> time,
> vendors submitting new applications to BlackBerry App World(TM) will  
> have
> the opportunity to enter the BlackBerry Developer Challenge. See  
> full prize
> details at: http://p.sf.net/sfu/Challenge
> _______________________________________________
> Openvpn-users mailing list
> Openvpn-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-users
>
>
> ------------------------------------------------------------------------------
> Enter the BlackBerry Developer Challenge
> This is your chance to win up to $100,000 in prizes! For a limited  
> time,
> vendors submitting new applications to BlackBerry App World(TM) will  
> have
> the opportunity to enter the BlackBerry Developer Challenge. See  
> full prize
> details at: http://p.sf.net/sfu/Challenge_______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


