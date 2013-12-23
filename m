References: <l8qvsn$jif$1@...1062...> <52B79339.2040202@...1800...>
Mime-Version: 1.0 (1.0)
In-Reply-To: <52B79339.2040202@...1800...>
Message-Id: <6F368953-E43A-4309-A6A7-9056227C9853@...1286...>
From: Eric Crist <ecrist@...1286...>
Date: Sun, 22 Dec 2013 22:21:15 -0600
Subject: Re: [Openvpn-devel] Easy-RSA v3 release planning
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Mike Tancsa <mike@...1800...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

If you want specific hardware support, your best bet is to send a hardware =
token we can test to a developer. Contact me if you need help.=20

> On Dec 22, 2013, at 7:34 PM, Mike Tancsa <mike@...1800...> wrote:
>=20
>> On 12/17/2013 9:05 PM, Josh Cepek wrote:
>> Here's an update about Easy-RSA v3 in case there were any
>> lingering contributions or ideas. At this point, the notable thing
>> missing compared to the 2.x-series is PKCS#11 support. My thought
>> here is that it should either have universal support for both
>> Windows and *nix platforms or be exposed as distro-centric
>> additions. I'd rather see a pkcs11 frontend script that is targeted
>> to each platform, and envision this as a 3.1 release target=20
>> feature.
>=20
> Hi,
> Its been a while since I tried / checked, but is there any support for
> generating keys on an actual hardware token in Windows ?
> Specifically, it would be great if I could do this with the
> Safenet/Aladin java etoken.
>=20
> I can do it on Unix using the older non java version keys, but I never
> quite figured out how to do it in Windows, and there is no Java etoken
> support that I have found on FreeBSD as it requires pkcs15 via OpenSC.
>=20
>    ---Mike
>=20
> --=20
> -------------------
> Mike Tancsa, tel +1 519 651 3400
> Sentex Communications, mike@...1800...
> Providing Internet services since 1994 www.sentex.net
> Cambridge, Ontario Canada   http://www.tancsa.com/
>=20
> -------------------------------------------------------------------------=
-----
> Rapidly troubleshoot problems before they affect your business. Most IT=20
> organizations don't have a clear picture of how application performance=20
> affects their revenue. With AppDynamics, you get 100% visibility into you=
r=20
> Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics=
 Pro!
> http://pubads.g.doubleclick.net/gampad/clk?id=3D84349831&iu=3D/4140/ostg.=
clktrk
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

