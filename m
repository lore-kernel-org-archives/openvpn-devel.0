Message-ID: <00ef01c2137a$da05db70$1000000a@...4...>
From: "James Yonan" <jim@...3...>
References: <Pine.LNX.4.33.0206131421210.28574-200000@...23...>
Subject: Re: [Openvpn-devel] Porting to an embedded linux
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Fri Jun 14 01:09:02 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: sampo.nurmentaus@...22...
Cc: openvpn-devel@lists.sourceforge.net

Sampo,

Check out the latest OpenVPN beta in CVS or:

http://openvpn.sourceforge.net/beta/openvpn-1.2.1.2.tar.gz

I added a --dev-node option.

James

----- Original Message -----
From: "Sampo Nurmentaus" <audiopoppi-13@...22...>
To: <sampo.nurmentaus@...22...>
Cc: "James Yonan" <jim@...3...>; <openvpn-devel@lists.sourceforge.net>
Sent: Thursday, June 13, 2002 6:27 AM
Subject: Re: [Openvpn-devel] Porting to an embedded linux


>
> Forget it,
>
> It works now. I just found out
> that setting the name of the device
> couses the ioctl to fail.
> Don't know if this is a
> platform dependent issue or
> a feature of the tun driver in 2.4.14
>
> I suppose the latter since tun driver
> is after all a quite high level one.
>
>
> I also added a new optional command line
> parameter to change the /dev/net/tun to
> point somewhere else to avoid reflashing :-)
>
> I included a patch agains openvpn-1.2.0
> if someone else has similar problem.
>
> Syntax is as fallows:
> --tundev /tmp/tun
>
>
> Thanks to you all for this beautiful software.
>
> As an user space program it was mutch more
> easy to port than freeswan, since kernel hackin'
> would have required a million reflashings and
> a great deal of serial debugging, since our
> device has no display.
>
>
> Sampo Nurmentaus
>
> >
> > Thanks James,
> >
> > It really helped. Simple recrosscompiling first kernel
> > and then openvpn fixed it.
> >
> > And now I have faced a new one :-(
> >
> > ioctl on line 216 in tun.c (TUNSETIFF)  seems to fail
> > complainin' about Invalid argument with errno 22.
> > I use tun driver shipped with 2.4.14 kernel and
> > if_tun.h which is identical to one in the kernel
> > source tree.
> >
> > Any ideas?
> >
> >
> > Sampo Nurmentaus
> >
> >
> >
> > > From: "Sampo Nurmentaus" <audiopoppi-13@...22...>
> > > To: <openvpn-devel@lists.sourceforge.net>
> > > Sent: Wednesday, June 12, 2002 8:31 AM
> > > Subject: [Openvpn-devel] Porting to an embedded linux
> > >
> > >
> > > > Hello folks,
> > > >
> > > >
> > > > I have been recently busy porting openssl, openssh
> > > > and openvpn to our embended linux environment
> > > > build on etrax 100lx processor from axis communications.
> > > >
> > > > Openvpn's code was, thanks to you guys, quite easy to
> > > > port but then I ran into problems when open vpn tries
> > > > to ioctl tun device:
> > > >
> > > > ....
> > > > 65: Static Decrypt: Cipher 'BF-CBC' initialized with 128 bit key
> > > > 66: Static Decrypt: Using 160 bit message digest 'SHA1' for HMAC
> > > > authentication
> > > > 67: Data Channel MTU parms: mtu=1456 extra_frame=44 extra_buffer=44
> > > > extra_tun=0
> > > > 68: Cannot ioctl TUNSETIFF tun0: File descriptor in bad state
(errno=77)
> > > > 69: Exiting
> > > >
> > > >
> > > > I have changed device to locate
> > > > in /tmp/tun, but that shuld not couse this kind of problems.
> > > > /dev is on flash image so it is easier to use /tmp for testing.
> > > > I created the device as should with:
> > > > mknod /tmp/tun c 10 200
> > > >
> > > > If I try to cat tun device read returns with the very same
> > > > error text.
> > > >
> > > >  I compiled support to kernel (not as a module)
> > > > so it should always be there.
> > > >
> > > >
> > > > Any ideas?
> > >
> > > Sampo,
> > >
> > > See message below from a previous thread on openvpn-users, and with
> > > references to vtun list.
> > >
> > > James
> > >
> > > >
> > > > Thanx in advange,
> > > >
> > > > Sampo Nurmentaus
> > >
> > > James Yonan wrote:
> > > >>Hi James,
> > > >>
> > > >>Thank you for your prompt and detailed reply.  What was happening
> > > >>earlier was that I built openvpn first, then realized I needed to
build
> > > >>the tun/tap kernel module, so built that and then rebuilt openvpn -
but
> > > >>configure (god bless it) used the cached result of NOT finding
if_tun.h.
> > > >>  I cleared configure's cache and rebuilt it again - this time it
found
> > > >>"tun/tap v1.4".  Now I'm onto a new set of problems though.  Now I
get:
> > > >>
> > > >>34: Cannot ioctl TUNSETIFF tun: File descriptor in bad state
(errno=77)
> > > >
> > > >
> > > > Though I've never seen this error personally, it has been talked
about
> > > > extensively on the vtun list (another tunneling daemon that uses the
> > > TUN/TAP
> > > > driver).
> > > >
> > > > Go to http://sourceforge.net/mailarchive/forum.php?forum_id=1826
> > > >
> > > > and search for "bad state".
> > > >
> > > > It appears to be caused by a mismatch between the tun/tap kernel
module
> > > and
> > > > the kernel itself.
> > > >
> > > > What kernel version are you using?
> > > >
> > > > Because in versions 2.4.6 and higher, the TUN/TAP module is integral
to
> > > the
> > > > kernel -- if you try to build an external version of the module,
rather
> > > than
> > > > using the one already bundled, it will likely fail.
> > >
> > > Also I've read a few posts that suggest that /usr/src/linux needs to
point
> > > to headers that match the running kernel.  Depending on what Sean has,
it
> > > may be worthwhile to ensure all the various versions
> > > (kernel/headers/tunTap) all match.
> > >
> > >
> > >
> > > _______________________________________________________________
> > >
> > > Sponsored by:
> > > ThinkGeek at http://www.ThinkGeek.com/
> > > _______________________________________________
> > > Openvpn-devel mailing list
> > > Openvpn-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> > >
> >
> >
> > _______________________________________________________________
> >
> > Don't miss the 2002 Sprint PCS Application Developer's Conference
> > August 25-28 in Las Vegas -
http://devcon.sprintpcs.com/adp/index.cfm?source=osdntextlink
> >
> > _______________________________________________
> > Openvpn-devel mailing list
> > Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >
>


