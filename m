Message-ID: <008501c212ee$62683c70$1000000a@...4...>
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
Date: Thu Jun 13 08:23:06 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: sampo.nurmentaus@...22...
Cc: openvpn-devel@lists.sourceforge.net

> Forget it,
>
> It works now. I just found out
> that setting the name of the device
> couses the ioctl to fail.
> Don't know if this is a
> platform dependent issue or
> a feature of the tun driver in 2.4.14

Note the distinction between --dev and --dev-type with respect to device
selection and naming.

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

I would probably change the syntax somewhat and use "--dev-dir /tmp" to keep
in line with --dev and --dev-type.  If --dev-dir is unspecified, it defaults
to /dev.

Also, if possible, please use "diff -ur" for generating patches, since the
"unified" format is more flexible for patch merging.

> Thanks to you all for this beautiful software.
>
> As an user space program it was mutch more
> easy to port than freeswan, since kernel hackin'
> would have required a million reflashings and
> a great deal of serial debugging, since our
> device has no display.

Cool!  I'm glad it worked out for you.

James



