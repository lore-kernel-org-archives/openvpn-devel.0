References: <5710B96E.6070603@...515...>
	<CAKuzo_gObagUmAuwRzh8vRPiP0Z0YG5GtOamtyKQX3W4q6xNfA@...278...>
	<5714AA48.8090507@...515...>
	<CAKuzo_gS7BXxkHZ1X0sqWEnhXieKSS3d4W1QSQV+sujpod1yxQ@...278...>
	<5715ED48.2010005@...515...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <57163836.4080404@...515...>
Date: Tue, 19 Apr 2016 16:52:54 +0300
MIME-Version: 1.0
In-Reply-To: <5715ED48.2010005@...515...>
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
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

I produced a new set of drivers with dual signatures. See 
"tap6-dual-sha1-sha2ev" download links and test results here:

<https://community.openvpn.net/openvpn/wiki/TapWindows6CodesignTests>

The driver passed basic testing on my Windows 7 test laptop.

Samuli

> Hi,
>
> I just received a report from a colleague that the tap6-ev-signed driver
> failed on one particular instance of Windows 10. I will query for more
> details. In any case, there seems to be little coherence in Windows'
> behavior with the signatures.
>
> Another colleague of mine had noticed strange behavior on Windows 10:
> when Windows updates are being downloaded/installed, tapinstall.exe just
> hangs, and the driver is in a non-functional state, and tap-windows6
> installation times out in 5 minutes or so. When the Windows updates are
> finished, tap-windows6 installation completes automatically. However, if
> the update are not stopped, then the tap-windows6 driver will remain in
> non-functional state indefinitely, unless Windows update is disabled
> completely. I assume that Windows update can be re-enabled after
> tap-windows6 installation completes.
>
> Anyways, I created a Wiki page with current test results and more
> thorough instructions:
>
> <https://community.openvpn.net/openvpn/wiki/TapWindows6CodesignTests>
>
> Hopefully we can figure out a way to make all Windows versions accept a
> single driver package. If that fails, the least bad approach is probably
> to have three drivers embedded into one installer:
>
> - tap-windows  (NDIS5), non-EV SHA1 for Windows XP
> - tap-windows6 (NDIS6), non-EV SHA1 for Windows Vista - 8.1
> - tap-windows6 (NDIS6), EV SHA2 for Windows 10
>
> Hopefully we can avoid that mess...
>
>> Only the old 32-bit vista machine is badly out-of-date and bringing it
>> up-to-date is a major pain. Will try.
>
> Ok, great! Based on my experiences with updating badly out-of-date
> Windows 7 installations we'll be hearing more about this in 2 weeks or
> so :).
>
>> Dual signatures sounds like a good plan provided all these older windows
>> versions are capable of reading dual signatures.  We should test this.
>
> Definitely. I will produce two different driver packages today:
>
> 1) tap6-dual-sha2ev-sha1
>
> Primary signature is EV SHA2, secondary non-ev SHA1.
>
> 2) tap6-dual-sha1-sha2ev
>
> Same as above, but the other way around. I suspect this will be more
> likely to succeed.
>
> ---
>
> That said, I can see several ways how even the dual signature strategy
> could fail. For example:
>
> - Cross-certificates cannot be added to the secondary certificate,
> possibly resulting in incomplete certification path.
>
> - When adding a secondary certificate Signtool.exe does not allow
> timestamping, which may or may not be an issue.
>
> - Older / unupdated Windows versions might get confused about the
> primary/secondary certificates and/or unsupported hashes. This is just a
> hunch.
>
> I'll report back when the drivers are ready.
>


