From: "Dave" <dev@...575...>
Date: Sun, 21 Dec 2008 10:23:46 -0600
Message-ID: <601E633B6FBD4BA9B29A9925AE15D4B4@...576...>
MIME-Version: 1.0
In-Reply-To: <200812162214.05751.bf@...1168...>
Subject: Re: [Openvpn-devel] TUN/TAP Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: 'Bernhard Fischer' <bf@...1168...>, openvpn-devel@lists.sourceforge.net

...
> No, I don't need any modification. I know, that the pre-built=20
> one works with=20
> openvpn.
> But if I start the Cygwin shell there's no /dev/tun. Hence, I=20
> thought that I=20
> have to compile and install it from source.
> But maybe I need another method (than /dev/tun) to access the=20
> driver on=20
> Windows. I tried to find the right code parts within the=20
> Opnevpn source but=20
> unfortunately I didn't know where to look...the code base=20
> isn't small ;)
...
> hidden services. That's why I use the TUN/TAP device. It=20
> works very well on=20
> Linux und other Unixoids but now I'd like to port it to=20
> Windows. My biggest=20
> problem seems to be this TUN/TAP driver, hence my posting ;)=20
> Maybe you could give me some hints.

Here's some hints:
*  the TAP usage for Windows is quite different than for the Unices.  The
work is done in tap.c.
*  In Windows, ioctls are used for configuration and control, and ReadFile()
and WriteFile() are used for io
*  there is no /dev/tun in Windows -- even under Cygwin's emulation.  You
will need to be familiar with how the Windows object namespace works, and
the filename for the device will be something like
\\.\Global\{ECFBAB2D-479B-4FE8-87B1-A66FC8DB0EF5}.tap
the funky 'filename' is the GUID of the driver instance, and is not a
constant installation-to-installation.  Fortunately all the code to figure
that stuff out is tun.c as well.
*  the Windows mechanism is implemented via an asynchronous IO mechanism
called 'overlapped io'.  You'll need to be familiar with this mechanism to
make heads-or-tails of what's going on, but short story is that WriteFile
and ReadFile don't block as you might usually expect, but rather return
immediately.  The request is queued to be completed in the kernel later.
When they are completed an 'event' is signaled, which can be waited upon,
which indicates data is available or that the write completed (I believe
that Writes complete immediately in this implementation and are effectively
synchronous, but reads are not).

Other than that, it is fairly straightforward:  open the device, configure
the device-specific parameters, and read/write packets to it to your heart's
content.

-Dave


