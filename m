Subject: Re: [Openvpn-devel] OpenVPN 2.0 and udev
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1098020193.10343@...41...>
In-Reply-To: <20041017102652.GC1621@...30...>
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
Date: Sun Oct 17 06:37:01 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Alberto Gonzalez Iniesta <agi@...64...>, OpenVPN devel <openvpn-devel@lists.sourceforge.net>

Alberto Gonzalez Iniesta <agi@...64...> said:

> Hi all,
> 
> After I decided to push OpenVPN 2.0 into Debian for future inclusion in
> Sarge, I got this [1] bug report from one Debian user. It seems that 2.0
> doesn't get along well with udev, as opposed to 1.6. I don't use udev,
> so I can't really tell, but has anything changed from 1.6 to 2.0 in the
> way the device is handled?
> 
> The suspicious message is:
> 
> Oct 16 16:31:12 gimli wait_for_sysfs[5873]: error: wait_for_sysfs needs an
update to handle the device '/class/net/tun0' properly, please report to
<linux-hotplug-devel@lists.sourceforge.net>
> 
> The bug submitter claims that OpenVPN 1.6 deals correctly with it. Maybe
> it has something to do with device probing?

The TUN/TAP handling code in 2.0 is nearly identical to the 1.6 code.  The
only change I can think of is the setting of txqueuelen on the TUN/TAP driver.

Incidentally, the error shown in the bug report looks like he is trying to
make a tunnel between 1.6 and 2.0 using incompatible key-method parameters. 
He needs to set --key-method 2 on the 1.6 side.

> Thanks,
> 
> Alberto
> 
> [1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=276799
> 
> 
> P.S. James, did you find out anything about this [2]? Do you think it
> could be due to hardware (RAM) problem? I'm thinking about tagging it
> irreproducible.

Yes, I would tend to mark it as irreproducible for now.  I tried to contact
him for more info, but haven't received any response.

> [2] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=265632

James


