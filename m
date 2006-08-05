From: Andrew Wenlang Zhu <azhu@...716...>
In-Reply-To: <1154738945.20206.181.camel@...717...>
References: <44D2A3B9.9050506@...277...>
	<1154737023.20206.169.camel@...717...>
	<1154738945.20206.181.camel@...717...>
Date: Fri, 04 Aug 2006 18:32:38 -0700
Message-Id: <1154741558.20206.184.camel@...717...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN dev-type option does not work on	Solaris
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

I forget to mention the the fix is based on Openvpn-2.0.7.

Andrew


On Fri, 2006-08-04 at 17:49 -0700, Andrew Wenlang Zhu wrote:
> The fix is in tun.c 
> 
> diff openvpn-2.0.7/tun.c openvpn-2.0.7-good-andrew/tun.c
> 61c61
> <     return !strcmp (dev_type, match_type);
> ---
> >     return !strncmp (dev, dev_type, strlen (dev_type));
> 68a69
> > 
> 1266c1267
> <   openvpn_snprintf (tt->actual_name, 32, "%s%d", dev_tuntap_type,
> ppa);
> ---
> >   openvpn_snprintf (tt->actual_name, 32, "%s%d", dev_type, ppa);
> 1270a1272
> 
> After recompile and use the same configuration:
> 
> dev atun0
> dev-type atun
> dev-node /dev/atun
> remote 172.16.16.7
> ifconfig 1.1.1.2 1.1.1.1
> secret /static.key
> verb 6
> 
> OpenVPN successfully starts and traffic go through as shown in the log:
> 
> Fri Aug  4 17:34:17 2006 us=828853 -----name  atun0 and id 23
> Fri Aug  4 17:34:17 2006 us=829016 TUN/TAP device atun0 opened
> Fri Aug  4 17:34:17 2006 us=829100 /usr/sbin/ifconfig atun0 1.1.1.1
> 1.1.1.2 mtu 1500 up
> Fri Aug  4 17:34:17 2006 us=853171 /usr/sbin/ifconfig atun0 netmask
> 255.255.255.255
> Fri Aug  4 17:34:17 2006 us=873227 Data Channel MTU parms [ L:1544
> D:1450 EF:44 EB:4 ET:0 EL:0 ]
> Fri Aug  4 17:34:17 2006 us=873440 Local Options String: 'V4,dev-type
> tun,link-mtu 1544,tun-mtu 1500,proto UDPv4,ifconfig 1.1.1.2
> 1.1.1.1,cipher BF-CBC,auth SHA1,keysize 128,secret'
> Fri Aug  4 17:34:17 2006 us=873510 Expected Remote Options String:
> 'V4,dev-type tun,link-mtu 1544,tun-mtu 1500,proto UDPv4,ifconfig 1.1.1.1
> 1.1.1.2,cipher BF-CBC,auth SHA1,keysize 128,secret'
> Fri Aug  4 17:34:17 2006 us=873687 Local Options hash (VER=V4):
> 'b290b507'
> Fri Aug  4 17:34:17 2006 us=873788 Expected Remote Options hash
> (VER=V4): '4d3ccdee'
> Fri Aug  4 17:34:17 2006 us=876963 Socket Buffers: R=[8192->65536]
> S=[8192->65536]
> Fri Aug  4 17:34:17 2006 us=877464 UDPv4 link local (bound):
> [undef]:1194
> Fri Aug  4 17:34:17 2006 us=877724 UDPv4 link remote: 172.16.16.6:1194
> Fri Aug  4 17:34:27 2006 us=882215 UDPv4 WRITE [60] to 172.16.16.6:1194:
> DATA len=60
> Fri Aug  4 17:34:37 2006 us=802075 UDPv4 WRITE [60] to 172.16.16.6:1194:
> DATA len=60
> Fri Aug  4 17:34:47 2006 us=322584 UDPv4 WRITE [60] to 172.16.16.6:1194:
> DATA len=60
> Fri Aug  4 17:34:57 2006 us=622311 UDPv4 WRITE [60] to 172.16.16.6:1194:
> DATA len=60
> Fri Aug  4 17:35:07 2006 us=612453 UDPv4 WRITE [60] to 172.16.16.6:1194:
> DATA len=60
> Fri Aug  4 17:35:07 2006 us=613836 UDPv4 READ [180] from
> 172.16.16.6:1194:  DATA len=180
> Fri Aug  4 17:35:07 2006 us=614193 Peer Connection Initiated with
> 172.16.16.6:1194
> Fri Aug  4 17:35:08 2006 us=656520 UDPv4 READ [60] from
> 172.16.16.6:1194:  DATA len=60
> Fri Aug  4 17:35:08 2006 us=656761 Initialization Sequence Completed
> Fri Aug  4 17:35:08 2006 us=656989 UDPv4 WRITE [180] to
> 172.16.16.6:1194:  DATA len=180
> 
> Andrew Zhu
> 
> 
> On Fri, 2006-08-04 at 17:17 -0700, Andrew Wenlang Zhu wrote:
> > On Solaris 8 and 10, I have to use a different driver other than the
> > Universal Tun driver. My driver name is "atun". However, if I change my
> > driver name to "tun", it works just fine.
> > 
> > Basically, on Solaris, OpenVPN can not take a device type and name if
> > not "tun", and OpenVPN complains:
> > 
> > Thu Aug 3 23:36:04 2006 us=146055 'atun0' is not a TUN/TAP device. The
> > --ifconfig option works only for TUN/TAP devices.
> > Thu Aug 3 23:36:04 2006 us=146097 Exiting
> > 
> > The configuration file I used:
> > 
> > dev atun0
> > dev-type atun
> > dev-node /dev/atun
> > remote 172.16.16.6
> > ifconfig 1.1.1.1 1.1.1.2
> > secret /static.key
> > daemon
> > 
> > I do not know if anyone run into the same problem on other X-nux system.
> > I already have a fix for Solaris and will post the fix shortly.
> > 
> > Andrew 
> >   
> > 
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

