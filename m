From: Bernhard Fischer <bf@...1168...>
Date: Sun, 21 Dec 2008 22:33:06 +0100
References: <601E633B6FBD4BA9B29A9925AE15D4B4@...576...>
In-Reply-To: <601E633B6FBD4BA9B29A9925AE15D4B4@...576...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3135038.AOxbdB9JAT";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200812212233.13021.bf@...1168...>
Subject: Re: [Openvpn-devel] TUN/TAP Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Dave <dev@...575...>
Cc: openvpn-devel@lists.sourceforge.net

--nextPart3135038.AOxbdB9JAT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 21 December 2008, Dave wrote:
> ...
>
> > No, I don't need any modification. I know, that the pre-built
> > one works with
> > openvpn.
> > But if I start the Cygwin shell there's no /dev/tun. Hence, I
> > thought that I
> > have to compile and install it from source.
> > But maybe I need another method (than /dev/tun) to access the
> > driver on
> > Windows. I tried to find the right code parts within the
> > Opnevpn source but
> > unfortunately I didn't know where to look...the code base
> > isn't small ;)
>
> ...
>
> > hidden services. That's why I use the TUN/TAP device. It
> > works very well on
> > Linux und other Unixoids but now I'd like to port it to
> > Windows. My biggest
> > problem seems to be this TUN/TAP driver, hence my posting ;)
> > Maybe you could give me some hints.
>
> Here's some hints:
> *  the TAP usage for Windows is quite different than for the Unices.  The
> work is done in tap.c.
> *  In Windows, ioctls are used for configuration and control, and
> ReadFile() and WriteFile() are used for io
> *  there is no /dev/tun in Windows -- even under Cygwin's emulation.  You
> will need to be familiar with how the Windows object namespace works, and
> the filename for the device will be something like
> \\.\Global\{ECFBAB2D-479B-4FE8-87B1-A66FC8DB0EF5}.tap
> the funky 'filename' is the GUID of the driver instance, and is not a
> constant installation-to-installation.  Fortunately all the code to figure
> that stuff out is tun.c as well.
> *  the Windows mechanism is implemented via an asynchronous IO mechanism
> called 'overlapped io'.  You'll need to be familiar with this mechanism to
> make heads-or-tails of what's going on, but short story is that WriteFile
> and ReadFile don't block as you might usually expect, but rather return
> immediately.  The request is queued to be completed in the kernel later.
> When they are completed an 'event' is signaled, which can be waited upon,
> which indicates data is available or that the write completed (I believe
> that Writes complete immediately in this implementation and are effectively
> synchronous, but reads are not).
>
> Other than that, it is fairly straightforward:  open the device, configure
> the device-specific parameters, and read/write packets to it to your
> heart's content.
>
> -Dave

Wow, thanks a lot!
That sounds great. I'll immediately try those things.

Thanks,
Bernhard

--nextPart3135038.AOxbdB9JAT
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQEcBAABAgAGBQJJTrYSAAoJEB2of8NcX/1HJ4QIAJFn2jeSX8kAXYBaIgMNe0FB
ZQ0F3cz5GD6YsCTGQ/msdY0c/QmQqBRzGYwk/k2D15VwFw5BrxJ1ke8Xi6SGREU+
kPTJc7Pku8rfj05CiPPASLf0deh0KhqsKUhKRGZnHLWZWslqVpWox9WwoJtwojLf
2FRodGQR+a78Sv96iJ4i4pofxURQKIFh50Lw9KaCWJ95u8lcRB5G25WleqkS9NjS
naBnSAdyUISA70QqoaBv+VdjbfJCF7HLfctwSVvJ+Rk22fGGZYJ5HyMvk92PiHX3
v5GYw8GtgYIpcB+ldvpMjYjR7SjVkYEtdvZPp/1BkVOSl9EOQgi1p2TSTZe+x5k=
=1ASO
-----END PGP SIGNATURE-----

--nextPart3135038.AOxbdB9JAT--

