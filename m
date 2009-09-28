MIME-Version: 1.0
In-Reply-To: <4ABE2F80.1080608@...193...>
References: <7bb795fd0909251436v2369d6d5q674e63e0621fcd56@...278...> 
	<h9l743$6ii$1@...1062...> <4ABE2F80.1080608@...193...>
From: JuanJo Ciarlante <jjo+ml@...410...>
Date: Mon, 28 Sep 2009 12:13:24 +0200
Message-ID: <7bb795fd0909280313n27909b32m76d90ff7c3b7310d@...278...>
Subject: Re: [Openvpn-devel] [PATCH] openvpn over ipv6 support -v0.4.6
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
To: Farkas Levente <lfarkas@...193...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Farkas,

On Sat, Sep 26, 2009 at 5:13 PM, Farkas Levente <lfarkas@...193...> wrote:
> any change to megre it into upstream openvpn?

hummm... one important "thing" I've been voiding to face is mgmt console
support (mainly b/c I don't use it), but I'm certainly sure this would be
an absolute requirement for getting it in  ;o)

For the moment, I added this fact to TODO.ipv6 ... so that doesn't appear
that there's no love for that support :)

Cheers,

>
> On 09/26/2009 04:05 PM, Bernhard Schmidt wrote:
>> JuanJo Ciarlante<jjo+ml@...410...> =A0wrote:
>>
>> Hello JuanJo,
>>
>>> I'm(back) working on openvpn/ipv6 endpoint support, aka udp6/tcp6,
>>> please refer to README.ipv6[1] and TODO.ipv6[2] for more details.
>>>
>>> All snapshots are unittested for correct {udp,tcp}v{4,6} operation
>>> under GNU/Linux and win32 (the latter x-compiled under the former ;).
>>
>> Thank you very much, your work is highly appreciated!
>>
>> I've updated my Ubuntu PPA repository of IPv6-enabled OpenVPN with your
>> patch. It contains the Ubuntu Karmic 2.1~rc19-1ubuntu2 package patched
>> for IPv6 transport, compiled for Karmic and Intrepid. The Intrepid
>> version should work fine on Debian Lenny as well.
>>
>> You can find those packages on
>> https://launchpad.net/~berni/+archive/ipv6/+packages . I have not
>> observed any problems in my easy usecase (static Point-to-point tunnel
>> over UDPv6), but no guarantees for anything.
>
>
> --
> =A0 Levente =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "=
Si vis pacem para bellum!"
>
> -------------------------------------------------------------------------=
-----
> Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay
> ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#3=
3;
> http://p.sf.net/sfu/devconf
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--=20
--JuanJo ; echo jAjo@...1263... | sed 's/[SPAM]//g'

