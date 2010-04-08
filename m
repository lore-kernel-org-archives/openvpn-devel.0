In-Reply-To: <4BBCF086.2060005@...1147...>
References: <OF16C98C16.EEA12E96-ONC12576FD.006F673E-C12576FD.00713519@...1343...>	<201004070959.09215.hhund@...194...>
	<OF83959B35.6804C8B1-ONC12576FE.0041E6AD-C12576FE.00424FE8@...1343...>	<201004071526.06006.hhund@...194...>
	<OF815ED8F1.B831009E-ONC12576FE.0049FAB0-C12576FE.004A9529@...1343...>
	<4BBCF086.2060005@...1147...>
Message-ID: <OF879B156A.CA01CFA3-ONC12576FF.001EF181-C12576FF.00215109@...1343...>
From: Johan Ymerson <johan.ymerson@...1342...>
Date: Thu, 8 Apr 2010 08:03:54 +0200
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] DNS problems with openvpn 2.1 on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net



Jan Just Keijser <janjust@...1147...> wrote on 2010-04-07 22:52:22:
> what exactly do you mean with 'nslookup always works' ?
nslookup always seem to use the correct dns server. For example, we have an internal website called 'intranet'.
I can do `nslookup intrnet`, and it will return the correct internal ip address. But `ping intranet` will fail with:
Ping request could not find host intranet. Please check the name and try again.

> > I bet this actually is a change in the behavior of the userspace part, not
> the driver. Something userspace did after configuring the interface, but it
> doesn't do anymore. Something that made Windows re-examine the DNS order.
> >
> this could be a timing issue, which could be caused by changes to the
> userspace openvpn part; did you try playing with the
>   route-delay
>   tap-sleep
>   dhcp-renew
> flags ? did that have any affect?

dhcp-renew fails with:
Thu Apr 08 07:37:12 2010 WARNING: Failed to renew DHCP IP address lease on TAP-Win32 adapter: The system cannot find the file specified.   (code=2)
Does dhcp-renew apply even when using the openvpn internal "dhcp" (ie. 'dev tun' and 'server 192.168.105.0 255.255.255.128' on the server side)?

I have tried different values for route-delay and tap-sleep, but it doesn't help.

/Johan


