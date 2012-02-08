MIME-Version: 1.0
Sender: fabian@...1547...
In-Reply-To: <20120208203948.GD13929@...1296...>
References: <CA+3tv22Xq447J_EXKM4SYP-45V7LN0NJfH6o9skUNPPij3PDuQ@...278...>
	<1CED409804E2164C8104F9E623B08B90129328AD5E@...1436...>
	<20120208080953.GS13929@...1296...>
	<CA+3tv2064zxi_v1hJPWaF+bd5FUrXYm+h+qYDnorHz8OrpxyGQ@...278...>
	<CA+3tv20-SBYOaDZG_+DgmVvAgkAYVR=CoWJ_dyzMjf2yFdLMGA@...278...>
	<20120208182413.GB13929@...1296...>
	<CA+3tv21sZAxo0hKF_tVrpmxCc3Uzcmv1fAiqaSDsyAhcavLdvQ@...278...>
	<20120208203948.GD13929@...1296...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Wed, 8 Feb 2012 21:55:31 +0100
Message-ID: <CAP+U6tL7_n5-QoNcVrTyyp=oSw2CefpeHttN9gjdSPahqg44ag@...278...>
Subject: Re: [Openvpn-devel] OpenVPN and Android 4.0 VPN API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Gert,

2012/2/8 Gert Doering <gert@...1296...>:
> On Wed, Feb 08, 2012 at 11:27:10AM -0800, James Ring wrote:
>> Does other code within openvpn care whether the fd is a UNIX socket or
>> a tun/tap device? I'm guessing there may be some ioctls it wants to
>> perform on the device.
>
> There aren't any ioctl()s (I'm aware of) for tun/tap devices, but
> blocking/non-blocking behaviour might be an interesting problem,

"The file descriptor is put into non-blocking mode by default to avoid
blocking Java threads." [0]

>> Other than that, openvpn would be reading and
>> writing IP packets with an encrypted payload and the Java wrapper
>> would be responsible for forwarding the bytes between the UNIX domain
>> socket and the actual tun device.
>
> Don't show idea that to Jan-Just, he's already complaining that OpenVPN
> wastes too many CPU cycles...

So let's hope the fd passing I mentioned in my other mail works on Android. :)

Cheers
Fabian

0: http://developer.android.com/reference/android/net/VpnService.Builder.html#establish()

