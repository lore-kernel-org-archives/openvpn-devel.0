From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] OpenVPN 2.0 and udev
In-Reply-To: <20041017161506.GC5221@...30...>
Message-ID: <Pine.LNX.4.58.0410171615360.3395@...269...>
References: <20041017102652.GC1621@...30...> <twig.1098020193.10343@...41...>
 <20041017161506.GC5221@...30...>
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
Date: Sun Oct 17 15:21:03 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Alberto Gonzalez Iniesta <agi@...64...>
Cc: openvpn-devel@lists.sourceforge.net


On Sun, 17 Oct 2004, Alberto Gonzalez Iniesta wrote:

> On Sun, Oct 17, 2004 at 01:36:33PM -0000, James Yonan wrote:
> > Alberto Gonzalez Iniesta <agi@...64...> said:
> > 
> > > Hi all,
> > > 
> > > After I decided to push OpenVPN 2.0 into Debian for future inclusion in
> > > Sarge, I got this [1] bug report from one Debian user. It seems that 2.0
> > > doesn't get along well with udev, as opposed to 1.6. I don't use udev,
> > > so I can't really tell, but has anything changed from 1.6 to 2.0 in the
> > > way the device is handled?
> > > 
> > > The suspicious message is:
> > > 
> > > Oct 16 16:31:12 gimli wait_for_sysfs[5873]: error: wait_for_sysfs needs an
> > update to handle the device '/class/net/tun0' properly, please report to
> > <linux-hotplug-devel@lists.sourceforge.net>
> > > 
> > > The bug submitter claims that OpenVPN 1.6 deals correctly with it. Maybe
> > > it has something to do with device probing?
> > 
> > The TUN/TAP handling code in 2.0 is nearly identical to the 1.6 code.  The
> > only change I can think of is the setting of txqueuelen on the TUN/TAP driver.
> 
> Ok
> 
> > Incidentally, the error shown in the bug report looks like he is trying to
> > make a tunnel between 1.6 and 2.0 using incompatible key-method parameters. 
> > He needs to set --key-method 2 on the 1.6 side.
> 
> 
> Has this changed between 1.6 and 2 beta11?
> The man page says --key-method defaults to 1 and the ChangeLog does not say otherwise.

Ah yes, the man page entry for --key-method hasn't been updated for 2.0.  
I will fix this for beta12.

> I don't think this guy changed that to 2 just after he upgraded the
> package. I'll ask him anyway, yo never know...
> Could a problem with the TUN/TAP driver confuse the --key-method handling code?

I doubt it.  The SSL/TLS handling code has almost no interactions with the 
TUN/TAP code.

James

