Message-ID: <5614C4BB.2000006@...515...>
Date: Wed, 07 Oct 2015 10:07:39 +0300
From: =?windows-1252?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <5605377D.9040401@...515...>
	<20151006113144.GX22054@...1296...>
In-Reply-To: <20151006113144.GX22054@...1296...>
Subject: Re: [Openvpn-devel] Help with build-testing a patched OpenVPN tree
 with Cygwin and Visual Studio?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

I added this as a Trac "volunteer" task:

<https://community.openvpn.net/openvpn/ticket/615>

We have not advertised the "[needs] volunteer" tasks much, so here they are:

<https://community.openvpn.net/openvpn/report/20>

Samuli


> Hi,
>
> jftr...
>
> On Fri, Sep 25, 2015 at 03:01:01PM +0300, Samuli Sepp=E4nen wrote:
>> We'd need some help build-testing a patched[*] OpenVPN version with
>> Cygwin and Visual Studio:
>>
>> <http://build.openvpn.net/downloads/temp/openvpn-2.3_git.tar.gz>
>>
>> This tree already builds fine on mingw_w64 which is enough for doing the
>> official builds.
>
> Heiko tested on Cygwin, Lev made it work on MSVC2013 (and the necessary
> changes for that have been merged).
>
> So, now this needs people to actually run IPv6-over-IPv6 to *use* the
> functionality and report whether it breaks in their setup.
>
> What you need: IPv6 connectivity between OpenVPN client and server, and
> IPv6 routing *into* the tunnel, with a route that overlaps the IPv6 addre=
ss
> of the server - either using "redirect-gateway ipv6", or pushing things
> like "route-ipv6 2000::/3" with a server inside 2000::/3...  if you do
> this, you should see something like this in the log:
>
> Tue Oct  6 13:28:57 2015 GDG6: remote_host_ipv6=3D2607:fc50:1001:5200::4
> Tue Oct  6 13:28:57 2015 ROUTE6_GATEWAY 2001:608:4::1 IFACE=3Deth0
> Tue Oct  6 13:28:57 2015 ROUTE6: 2607:fc50:1001::/48 overlaps IPv6 remote=
 2607:fc50:1001:5200::4, adding host route to VPN endpoint
> Tue Oct  6 13:28:57 2015 add_route_ipv6(2607:fc50:1001:5200::4/128 -> 200=
1:608:4::1 metric 1) dev eth0
> Tue Oct  6 13:28:57 2015 /bin/route -A inet6 add 2607:fc50:1001:5200::4/1=
28 dev eth0 gw 2001:608:4::1 metric 1
>
> the first line is "this is the IPv6 address of the VPN server", the
> "ROUTE6_GATEWAY" line is "this is the gateway and interface we have
> discovered!".  The "overlap" notice means the feature will actually
> kick in - it won't, if you have no overlapping routes into the tunnel,
> or connect over IPv4 - and the last two lines are the installing of
> the /128 host route, which better should work as well :-)
>
> I tested this for 6 scenarios on 9 (!) platforms, so I'm reasonably sure
> it works for the common case - but there will be unexpected cases...
>
> gert
>


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

