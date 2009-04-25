Message-ID: <49F34D62.4000302@...1114...>
Date: Sat, 25 Apr 2009 19:50:26 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <49F1B322.6030705@...1032...> <1240630761l.7894l.0l@...1207...>
In-Reply-To: <1240630761l.7894l.0l@...1207...>
Subject: Re: [Openvpn-devel] linux openvpn development job
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net


Karl O. Pinc wrote:
> On 04/24/2009 07:40:02 AM, Siim P=F5der wrote:

[snip]

> Please pardon me for thinking out loud here...

I'll follow in this path, thinking out loud ...

> The problem is that moving data between userspace and kernelspace
> is expensive.  (IIRC you can't just use the CPU to filter the bus
> between nics, you need to deliver data to/receive data
> from RAM because that's where the userland app works
> with it.)  OpenVPN runs in userspace so all the VPN data
> has to pass out of the kernel into userspace and back again.
> To attack the problem directly you need to move all functionality
> into the kernel, which raises a number of problems.
> Such an OpenVPN would not port between OS platforms
> very well.  Someone would have to convince both
> the kernel and OpenVPN developers to maintain the
> code.  And so forth.

This actually made me think a little bit.  For the Windows platform,
OpenVPN ship a TUN/TAP driver as a part of the installation, due to
missing native tun/tap drivers.

What if OpenVPN on selected platforms also provided it's own kernel driver
which would do practically the same as the upstream tun.ko modules -
except it provides a direct API which OpenVPN can utilize, to avoid the
kernel-userspace-kernel ping-pong.

But I also do realise that, a poorly written API can introduce some really
nasty security breaches as well.  And I also realise that it will be more
code to maintain.  Such an implementation should probably try to make use
of the kernel based encryption API as well, as that might be also much
more efficient in this setting.



Just my 2cents.


David Sommerseth

