Subject: Re: [Openvpn-devel] Working with 2.6
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1069195404.87396@...41...>
In-Reply-To: <Pine.LNX.4.58.0311181109080.17332@...136...>
References: <Pine.LNX.4.58.0311180916570.17332@...136...> <200311181004.25751.matt@...137...>, <200311181004.25751.matt@...137...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Nov 18 14:44:06 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jon Nelson <jnelson-openvpn@...135...>, Matt <matt@...137...>
Cc: openvpn-devel@lists.sourceforge.net

Jon Nelson <jnelson-openvpn@...135...> said:

> On Tue, 18 Nov 2003, Matt wrote:
> 
> > I've had a simular problem too. 2.6 and Openvpn are a no go.
> 
> Why?  I easily got it running after just a few minutes of debugging.
> Indeed, it's been working fine for me for the last few days.
> Didn't you read the whole email?  The solution is contained within.
> If you want to simply test it out, do this:
> 
> cd /dev/net
> ln -s ../misc .
> 
> That should allow openvpn to open the tun interface.
> If that works, and you can't figure out what lines in the devfs
> configuration to edit, post to this list and I'll see if I can determine
> what exactly it is that I changed in the (devfsd) config.

I'm not running 2.6 yet, but if someone gives me ssh access, I will fix.

What precisely needs to be done?

Is it just a matter of trying an alternate device node name, or is there more
involved in porting to 2.6?

James

> > On Tuesday 18 November 2003 08:18 am, Jon Nelson wrote:
> > > Just so you all know, I'm using OpenVPN 1.5beta12 (soon to be beta14)
> > > with Linux 2.6.0-test9 (vanilla, no patching).
> > >
> > > The only problem I encountered is that I had to alter by devfs
> > > configuration because the tun device has moved from /dev/net/tun to
> > > /dev/misc/net/tun -- fortunately there are existing (commented out)
> > > directives in the devfs configuration for this.
> 
> --
> Democracy is two wolves and a sheep voting on what to have for dinner.
> Liberty is two wolves attempting to have a sheep for dinner and
> finding a well-informed, well-armed sheep.
> 
> Jon Nelson <jnelson-openvpn@...135...>
> 
> 
> -------------------------------------------------------
> This SF. Net email is sponsored by: GoToMyPC
> GoToMyPC is the fast, easy and secure way to access your computer from
> any Web browser or wireless device. Click here to Try it Free!
> https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 



-- 




