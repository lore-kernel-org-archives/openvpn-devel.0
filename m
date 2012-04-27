MIME-Version: 1.0
In-Reply-To: <4F9A7EEC.5030404@...515...>
References: <CAOazyz3Z3Mr=wBnjZ=PmRV8cMWezzqv6ZgJrNXcxkfj73jUyvA@...278...>
	<4F9A501E.4000409@...515...>
	<CAOazyz17=zbrB91E87p0W4UrrsBRme0wDAsvbBvmiFzXxhG=_A@...278...>
	<4F9A7EEC.5030404@...515...>
Date: Fri, 27 Apr 2012 14:28:44 +0300
Message-ID: <CAOazyz1BmhOThN6f+yc_BqPMeO942iSNydym6ZRzDeSr-KJZLQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] tap-windows - release
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

2012/4/27 Samuli Sepp=C3=A4nen <samuli@...515...>:
>>> James has built and signed our TAP-drivers so far, and I don't have the
>>> signing keys. I'll forward this to him.
>> Great.
>> BTW: Apart from me, I don't think anyone actually tried to use the new
>> tap-windows installer...
> Notified James about the driver building/signing. I'll probably build
> the "official" drivers and James then signs them. Unless James feels
> adventurous and does everything :).
>
> I'll test the tap-windows installers soon, as it's needed for official
> Windows releases anyways.

Hmmm... we need to sign the driver and sign the installer.
The build system already doing this.
So it is not that you can split the build from the signing.
Unless you wish to split the build:
1. build driver binaries, put these in zip.
2. sign binaries and put these in new zip.
3. build installer out of this new zip.
4. sign installer.

Can't you simply have access to the signing key and perform the whole
automotive process I created?

Alon.

