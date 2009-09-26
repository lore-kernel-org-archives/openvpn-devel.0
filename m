Message-ID: <4ABE2F80.1080608@...193...>
Date: Sat, 26 Sep 2009 17:13:04 +0200
From: Farkas Levente <lfarkas@...193...>
MIME-Version: 1.0
References: <7bb795fd0909251436v2369d6d5q674e63e0621fcd56@...278...>
	<h9l743$6ii$1@...1062...>
In-Reply-To: <h9l743$6ii$1@...1062...>
Subject: Re: [Openvpn-devel] [PATCH] openvpn over ipv6 support -v0.4.6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

any change to megre it into upstream openvpn?

On 09/26/2009 04:05 PM, Bernhard Schmidt wrote:
> JuanJo Ciarlante<jjo+ml@...410...>  wrote:
>
> Hello JuanJo,
>
>> I'm(back) working on openvpn/ipv6 endpoint support, aka udp6/tcp6,
>> please refer to README.ipv6[1] and TODO.ipv6[2] for more details.
>>
>> All snapshots are unittested for correct {udp,tcp}v{4,6} operation
>> under GNU/Linux and win32 (the latter x-compiled under the former ;).
>
> Thank you very much, your work is highly appreciated!
>
> I've updated my Ubuntu PPA repository of IPv6-enabled OpenVPN with your
> patch. It contains the Ubuntu Karmic 2.1~rc19-1ubuntu2 package patched
> for IPv6 transport, compiled for Karmic and Intrepid. The Intrepid
> version should work fine on Debian Lenny as well.
>
> You can find those packages on
> https://launchpad.net/~berni/+archive/ipv6/+packages . I have not
> observed any problems in my easy usecase (static Point-to-point tunnel
> over UDPv6), but no guarantees for anything.


-- 
   Levente                               "Si vis pacem para bellum!"

