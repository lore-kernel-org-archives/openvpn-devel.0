Resent-To: openvpn-devel@lists.sourceforge.net
Resent-Message-Id: <4F32DB41.1030504@...1547...>
MIME-Version: 1.0
Sender: Fabian Knittel <fabian@...1547...>
In-Reply-To: <CA+3tv21sZAxo0hKF_tVrpmxCc3Uzcmv1fAiqaSDsyAhcavLdvQ@...278...>
References: <CA+3tv22Xq447J_EXKM4SYP-45V7LN0NJfH6o9skUNPPij3PDuQ@...278...>
	<1CED409804E2164C8104F9E623B08B90129328AD5E@...1436...>
	<20120208080953.GS13929@...1296...>
	<CA+3tv2064zxi_v1hJPWaF+bd5FUrXYm+h+qYDnorHz8OrpxyGQ@...278...>
	<CA+3tv20-SBYOaDZG_+DgmVvAgkAYVR=CoWJ_dyzMjf2yFdLMGA@...278...>
	<20120208182413.GB13929@...1296...>
	<CA+3tv21sZAxo0hKF_tVrpmxCc3Uzcmv1fAiqaSDsyAhcavLdvQ@...278...>
Date: Wed, 8 Feb 2012 20:47:20 +0100
Message-ID: <CAP+U6tL7Szb-t5Jm6wPuyraF-wnN7NPFHpaJRCfYV4mL5wswzQ@...278...>
From: Fabian Knittel <fabian.knittel@...1547...>
Subject: Re: [Openvpn-devel] OpenVPN and Android 4.0 VPN API
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
To: James Ring <sjr@...1546...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi James,

2012/2/8 James Ring <sjr@...1546...>:
> On Wed, Feb 8, 2012 at 10:24 AM, Gert Doering <gert@...1296...> wrote:
>> Exactly. =C2=A0The first three things are sort of "nearly done", the
>> "receive file descriptor to use for tun/tap" would need to be
>> implemented (tun.c, open_tun(), #ifdef ANDROID_MAGIC_VPN :-) )
>
> I was thinking about this a little more. Presumably openvpn will be
> forked and exec'd before the file descriptor is available. Presumably
> openvpn could connect to a UNIX domain socket inside open_tun() if
> ANDROID_MAGIC_VPN is specified.
>
> Does other code within openvpn care whether the fd is a UNIX socket or
> a tun/tap device? I'm guessing there may be some ioctls it wants to
> perform on the device. Other than that, openvpn would be reading and
> writing IP packets with an encrypted payload and the Java wrapper
> would be responsible for forwarding the bytes between the UNIX domain
> socket and the actual tun device.

Unless Android's Linux is stripped down in this respect, you can pass
file descriptors over UNIX domain sockets. (The first google hit is
[0]. The interface isn't beautiful, but it works nicely.)

This would allow you to take the java wrapper out of the loop as far
as the raw data shuffling is concerned.

Cheers
Fabian

0: http://www.lst.de/~okir/blackhats/node121.html

