MIME-Version: 1.0
In-Reply-To: <20120208182413.GB13929@...1296...>
References: <CA+3tv22Xq447J_EXKM4SYP-45V7LN0NJfH6o9skUNPPij3PDuQ@...278...>
	<1CED409804E2164C8104F9E623B08B90129328AD5E@...1436...>
	<20120208080953.GS13929@...1296...>
	<CA+3tv2064zxi_v1hJPWaF+bd5FUrXYm+h+qYDnorHz8OrpxyGQ@...278...>
	<CA+3tv20-SBYOaDZG_+DgmVvAgkAYVR=CoWJ_dyzMjf2yFdLMGA@...278...>
	<20120208182413.GB13929@...1296...>
Date: Wed, 8 Feb 2012 11:27:10 -0800
Message-ID: <CA+3tv21sZAxo0hKF_tVrpmxCc3Uzcmv1fAiqaSDsyAhcavLdvQ@...278...>
From: James Ring <sjr@...1546...>
Subject: Re: [Openvpn-devel] OpenVPN and Android 4.0 VPN API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hey Gert,

On Wed, Feb 8, 2012 at 10:24 AM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Wed, Feb 08, 2012 at 04:47:35AM -0800, James Ring wrote:
>> Perhaps I wrote this too hastily. I wasn't thinking of how OpenVPN
>> actually works. OpenVPN would:
>>
>> * open the connection (tcp or udp) to the remote end
>> * negotiate session parameters
>> * provide the Android Java wrapper with the session parameters via the
>> service pipe
>> * receive the file descriptor to use as the tun/tap device from the
>> Android Java wrapper via the service pipe
>
> Exactly. =A0The first three things are sort of "nearly done", the
> "receive file descriptor to use for tun/tap" would need to be
> implemented (tun.c, open_tun(), #ifdef ANDROID_MAGIC_VPN :-) )

I was thinking about this a little more. Presumably openvpn will be
forked and exec'd before the file descriptor is available. Presumably
openvpn could connect to a UNIX domain socket inside open_tun() if
ANDROID_MAGIC_VPN is specified.

Does other code within openvpn care whether the fd is a UNIX socket or
a tun/tap device? I'm guessing there may be some ioctls it wants to
perform on the device. Other than that, openvpn would be reading and
writing IP packets with an encrypted payload and the Java wrapper
would be responsible for forwarding the bytes between the UNIX domain
socket and the actual tun device.

Regards,
James

