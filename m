References: <5710B96E.6070603@...515...>
	<CAKuzo_gObagUmAuwRzh8vRPiP0Z0YG5GtOamtyKQX3W4q6xNfA@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <5714AA48.8090507@...515...>
Date: Mon, 18 Apr 2016 12:35:04 +0300
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gObagUmAuwRzh8vRPiP0Z0YG5GtOamtyKQX3W4q6xNfA@...278...>
Subject: Re: [Openvpn-devel] New EV-signed tap-windows6 driver ready for
 testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

> - Windows 10 (64 bit): success
>
> Installs without error and works fine.

Excellent!

> - Windows 7 (64 bit): success, but see below
>
> Installs without error and works fine.
> However, the driver details says that its _not_ digitally signed, but
> the driver properties window shows "Digitally signed by OpenVPN
> Technologies Inc."
> Installing KB3123479 (update to support SHA2 signatures) makes no
> difference.

Yeah, I noticed the same. This may just be a glitch in the GUI. Also, I=20
think the same issue was/is present when using the old tap-windows6=20
driver that has a SHA1 signature.

Interestingly Powershell seems to show all signatures I've created as=20
valid, not matter what:

   > Get-AuthenticodeSignature .\tap0901.cat

It could be that the Get-Authenticode only does basic validation and=20
does not lookup the entire certification path, like installing the=20
driver or loading it to the kernel would. That said, the CmdLet=20
occasionally hangs for long periods of time, so it could be doing=20
something (e.g. downloading missing certificates) behind the scenes.

> - Windows server 2008r2 (64bit) : installs ok, but adapter fails
>
> Installs without error, driver properties and driver details display
> same as Windows 7 (i.e one says signed, other says not signed).
> Cannot enable the tap adapter -- fails with the following error
>
> "The TAP-Windows Adapter V9 service failed to start due to the following
> error:
> Windows cannot verify the digital signature for this file. A recent
> hardware or software change might have installed a file that is signed
> incorrectly or damaged, or that might be malicious software from an
> unknown source."

I suspect most of the signature issues are because of an incomplete=20
certification path. I believe the path is viewable from the file=20
properties dialog.

> On installing KB3123479, the error changes to
> "The driver \Driver\tap0901 failed to load for the device ROOT\NET\0004."
> and TAP adapters do no show up in the list of network adapters
>

> - Windows vista (32 bit): installs after ignoring security warning,
> works fine
>
> Installation: Pops up a warning that says no valid signature, publisher
> not verified etc. On choosing to install anyway, completes without error.
> Tap adapter works fine
>
> I thought driver signature is not enforced on 32 bit vista, but this is
> the only platform (among those I tried) that complained loudly at
> installation time.

 From what I read, Windows Vista does not correctly support SHA2=20
signatures (in kernel drivers?). So it seems that 32-bit Vista works=20
fine, but just complains a bit. It would be good to test on Windows=20
Vista 64-bit and see if it outright rejects the driver. If that happens,=20
we need to discuss what to do with Vista 64-bit; its Extended support=20
EOL is due on April 11, 2017 [1].

> Note: none of the above systems are up-to-date with windows updates.

This could cause part of the failures at least. Fully updating the=20
system and retesting would be a good exercise (if possible).

I tested the driver on Windows Server 2012r2:
- installed just fine
- worked just fine

So so far only Windows Server 2008 is giving us headaches. I did receive=20
one private report about Windows 7 64-bit not working, but I'll have to=20
verify all the facts first.

In the worst case I can use dual signatures in the driver files. The=20
main signature would be a non-EV SHA-1 signature, and the SHA-2 EV=20
signature would be a secondary signature. Or the other way around. Some=20
projects such as WinSCP advertise dual signatures on their executables=20
and/or installers, so I guess that's a reasonable way forward. This=20
would of course require a second round of testing.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

[1] <http://windows.microsoft.com/en-us/windows/lifecycle>

