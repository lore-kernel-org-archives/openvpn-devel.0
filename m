References: <5710B96E.6070603@...515...>
	<CAKuzo_gObagUmAuwRzh8vRPiP0Z0YG5GtOamtyKQX3W4q6xNfA@...278...>
	<5714AA48.8090507@...515...>
	<CAKuzo_gS7BXxkHZ1X0sqWEnhXieKSS3d4W1QSQV+sujpod1yxQ@...278...>
	<5715ED48.2010005@...515...> <57163836.4080404@...515...>
	<571726E9.1080304@...515...>
	<CAKuzo_gxRSf1n6ZnB=odEw-U1k8rs+mY_-cOzG=7DdPrPoW4qg@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <57187661.5090709@...515...>
Date: Thu, 21 Apr 2016 09:42:41 +0300
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gxRSf1n6ZnB=odEw-U1k8rs+mY_-cOzG=7DdPrPoW4qg@...278...>
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

Hi Selva,

Thanks for doing the tests!

> Hi,
>
> On Wed, Apr 20, 2016 at 2:51 AM, Samuli Sepp=C3=A4nen <samuli@...515...
> <mailto:samuli@...515...>> wrote:
>
>     Hi,
>
>     So far the new driver (tap6-dual-sha1-sha2ev) looks promising: it
>     works on 64-bit Vista, 7 and 10:
>
>     <https://community.openvpn.net/openvpn/wiki/TapWindows6CodesignTests>
>
>     Selva: can you try this new driver on your Vista 32-bit and Windows
>     Server 2008? If you still have not updated them then please don't:
>     it's probably best to test again systems which are more likely to
>     cause issues.
>
>
> To add to what's already confirmed, the new driver works for me too on
> Windows 10 and window 7 (both 64bit) -- no problems with installation or
> use; same as the earlier sha2-only version.

Great! I added all of your results to the Wiki page.

> The behaviour on vista 32 (still not updated) is somewhat strange --
> both the -sha2 and -sha1-sha2 now installs without any warning after the
> first forced installation  --- i.e.,  install ignoring a stern warning,
> remove, and then install again and the second time onwards there are no
> warnings. I did not select the "trust this publisher" button or
> anything, but it behaves as if.  Anyway, dual signatures appear to be
> fine even with this out-of-date vista machine though it may be seeing
> only the first signature: file properties shows only one digest -- sha2
> on the first version and sha1 on the second one.

Ok, if Vista can only see one signature then making SHA1 the primary one=20
made perfect sense. Interestingly the capability to add multiple=20
signatures/timestamps to a file has appeared relatively recently:=20
signtool.exe bundled with WinDDK 7600.* does not support it.. Windows=20
Kit 10 (successor to WinDDK I presume) does have multiple signature support.

> Updating the vista machine is probably not going to happen -- too many
> failures trying to do so and considering this was booted into vista
> first time in 2 years, it looks like a lost battle.

Yeah, don't worry about it. I think the driver has proven itself to the=20
degree it can without actually being tested in the wild.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

