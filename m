From: Kristof Provost <kp@...1376...>
Date: Mon, 22 Aug 2022 14:55:09 +0200
Message-ID: <21B552DE-38FE-41F0-8FC7-606EA4C06093@...1376...>
In-Reply-To: <YwDwvG++hK0nJI2F@...1296...>
References: <20220812134154.16729-3-kprovost@...2661...>
 <202208201401.27KE12Cm014083@...2054...>
 <YwDwvG++hK0nJI2F@...1296...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="=_MailMate_C427DE8D-62AB-4CCF-BAE5-EAC24188FEEF_="
Content-Transfer-Encoding: 8bit
Subject: Re: [Openvpn-devel] route/iroute handling on FreeBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--=_MailMate_C427DE8D-62AB-4CCF-BAE5-EAC24188FEEF_=
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

On 20 Aug 2022, at 16:33, Gert Doering wrote:
>>  - iroute installation works for the easy cases (--route in 
>> server.conf,
>>    --iroute with a more-specific of that in ccd/).  It does not work
>>    for the nasty cases (--route and --iroute with same netbits).
>>
>>    I will send a followup e-mail with more details on this soon.
>
> *This* is the bit I want to cover separately, because this e-mail is
> going to be long :-)
>
> So, here's my test cases, to see if I could get DCO to misbehave.
>
> Server config has:
>
> # grep ^route server.conf
> route 10.114.200.0 255.255.255.0
> route-ipv6 fd00:abcd:114:200::/64
> route 10.114.201.0 255.255.255.0
> route-ipv6 fd00:abcd:114:201::/64
>
> ("pull two /24 and two /64 towards the tun interface")
>
> There is one particular client which has many addresses configured on
> its loopback
>
> lo0: flags=8049<UP,LOOPBACK,RUNNING,MULTICAST> metric 0 mtu 16384
>         inet 10.114.200.74 netmask 0xffffffff
>         inet 10.114.201.74 netmask 0xffffffff
>         inet 10.114.202.74 netmask 0xffffffff
>         inet6 fd00:abcd:114:200::74 prefixlen 128
>         inet6 fd00:abcd:114:201::74 prefixlen 128
>         inet6 fd00:abcd:114:202::74 prefixlen 128
>
> ... and when that client connects, the expectation is that *other* 
> clients
> can ping these 6 addresses (note it's 200, 201, 202 for v4 and v6).
>
> Here's the ccd file for this client:
>
> # cat /root/t_server/tun-udp-p2mp/ccd/freebsd-74-amd64
> # Host iroute
> iroute 10.114.200.74 255.255.255.255
> iroute-ipv6 fd00:abcd:114:200::74/128
> # Subnet-iroute
> iroute 10.114.201.0 255.255.255.0
> iroute-ipv6 fd00:abcd:114:201::/64
> # iroute-without-route
> # 10.114.202, fd00:abcd:114:202::/64
> iroute 10.114.202.74 255.255.255.255
> iroute-ipv6 fd00:abcd:114:202::74/128
>
>
> So the "200" routes are "install a host route for IPv4 or IPv6 that is
> part of an aggregate".  This works fine.
>
> The "202" routes are "install a host route for IPv4 or IPv6 where 
> there
> is no covering --route" - this is basically something OpenVPN could 
> not
> do before DCO (update host routes on-demand on client connect), but is
> something I've long waited for :-) - this also works fine.
>
> Now, the 201 routes are "there whole network specified in --route is
> routed to a single client".  This is not such an unusual setup in
> cases like "there is a central office OpenVPN server, and one of the
> branch offices wants it 192.168.77.0/24 reachable from the other
> clients".  This *fails*.
>
> For IPv4, we end up with "netstat -rn" looking like this:
>
> 10.114.201.0/24    10.114.2.2         UGS        tun1
> 10.114.201.0/24    10.114.2.8         UGS        tun1
>
> and "route get" telling us the the first one is preferred
>
> $ route get 10.114.201.74
>    route to: 10.114.201.74
> destination: 10.114.201.0
>        mask: 255.255.255.0
>     gateway: 10.114.2.2
>         fib: 0
>   interface: tun1
>
> so packets loop... (10.114.2.2 is not an address that belongs to an
> actual client, but "the tun interface peer") the client is 10.114.2.8.
>
> $ traceroute 10.114.201.74
> traceroute to 10.114.201.74 (10.114.201.74), 64 hops max, 40 byte 
> packets
>  1  10.114.2.2 (10.114.2.2)  1.706 ms  1.240 ms  0.921 ms
>  2  localhost (127.0.0.1)  0.865 ms  0.809 ms  0.807 ms
>  3  10.114.2.2 (10.114.2.2)  1.603 ms  1.605 ms  1.595 ms
>  4  localhost (127.0.0.1)  1.533 ms  1.383 ms  1.768 ms
>
>
> For IPv6, things look different - route installation fails
>
> 2022-08-20 15:47:24 freebsd-74-amd64/2001:608:0:814::f000:3 
> /sbin/route -6 add -net fd00:abcd:114:201::/64 fd00:abcd:114:2::1006 
> -fib 0
> add net fd00:abcd:114:201::/64: gateway fd00:abcd:114:2::1006 fib 0: 
> route already in table
>
> so, the iroute never makes it to kernel, "netstat -rn" remains at
>
> fd00:abcd:114:201::/64            link#14                       US     
>     tun1
>
> and packets loop as well
>
> $ traceroute6 fd00:abcd:114:201::74
> traceroute6 to fd00:abcd:114:201::74 (fd00:abcd:114:201::74) from 
> fd00:abcd:114:2::1, 64 hops max, 28 byte packets
>  1  fd00:abcd:114:2::1000  1.749 ms  1.246 ms  0.930 ms
>  2  fd00:abcd:114:2::1  0.836 ms  1.225 ms  1.067 ms
>  3  fd00:abcd:114:2::1000  1.555 ms  1.631 ms  1.575 ms
>  4  fd00:abcd:114:2::1  1.472 ms  1.531 ms  1.677 ms
>
>
>
> So, what we do on *Linux* to handle this, is to work with route 
> metrics
> (10.220.* = "same instances, different host, so different address 
> range")
>
> linux$ ip route |grep tun1
> 10.220.200.0/24 via 10.220.2.2 dev tun1 metric 200
> 10.220.200.74 via 10.220.2.8 dev tun1 metric 100
> 10.220.201.0/24 via 10.220.2.8 dev tun1 metric 100
> 10.220.201.0/24 via 10.220.2.2 dev tun1 metric 200
> 10.220.202.74 via 10.220.2.8 dev tun1 metric 100
> linux$ ip -6 route |grep tun1
> fd00:abcd:220:200::74 via fd00:abcd:220:2::1006 dev tun1 metric 100 
> pref medium
> fd00:abcd:220:200::/64 dev tun1 metric 200 pref medium
> fd00:abcd:220:201::/64 via fd00:abcd:220:2::1006 dev tun1 metric 100 
> pref medium
> fd00:abcd:220:201::/64 dev tun1 metric 200 pref medium
> fd00:abcd:220:202::74 via fd00:abcd:220:2::1006 dev tun1 metric 100 
> pref medium
>
> so there's always 5 routes in the active table - 2 "--route" routes
> (according to server.conf) with *metric 200*, and then 3 "--iroute" 
> routes
> (from ccd/) with metric DCO_IROUTE_METRIC = 100.
>
> Linux handles this as would a "Cisco router" do - if there are two
> identical routes with different metric, the lower-metric route is
> used, and the other one is ignored.  So this works very nicely.
>
>
> Now, back to FreeBSD.
>
>   - our code does not try to set metrics on FreeBSD
>   - my reading of route(8) does not show me anything in that direction
>     (metric, preference, administrative distance, ...)
>   - I do not understand FreeBSD internals well enough to know whether
>     it can be done at all, or not.
>
It’s rather poorly (i.e. not) documented, but it is possible to set a 
route metric. It’s called a ‘weight’, and not actually mentioned 
in the man page. Or shown in netstat output.

But:

	$ sudo route add 172.16.2.0/24 10.0.2.1
	add net 172.16.2.0: gateway 10.0.2.1
	$ sudo route add 172.16.2.0/24 -weight 2 10.0.2.254
	add net 172.16.2.0: gateway 10.0.2.254

So we can add multiple routes for the same network, as long as they have 
a different gateway.

The usual `netstat -rn` doesn’t show the weight. You have to use the 
json/xml output to get it:

	$ netstat -rn --libxo json | jq
	…
               {
                 "destination": "172.16.2.0/24",
                 "gateway": "10.0.2.1",
                 "flags": "UGS",
                 "flags_pretty": [
                   "up",
                   "gateway",
                   "static"
                 ],
                 "weight": 1,
                 "interface-name": "bnxt0"
               },
               {
                 "destination": "172.16.2.0/24",
                 "gateway": "10.0.2.254",
                 "flags": "UGS",
                 "flags_pretty": [
                   "up",
                   "gateway",
                   "static"
                 ],
                 "weight": 2,
                 "interface-name": "bnxt0"
               },

A higher weight gives a higher priority, so that’s the opposite of 
what Linux does with metric, I believe.

> If it can not be done, we need to document this as "one of the issues
> with FreeBSD DCO", and it can of course be easily workarounded in most
> cases
>
>   --route 10.114.201.0/24
>     --iroute 10.114.201.0/25
>     --iroute 10.114.201.128/25
>
> will get the same thing done "when client is online route the whole 
> /25
> down there", but it's harder to get into people's heads :-)  (adding
> code to auto-split such a prefix is technically possible but would be
> quite a complication, so I'd rather solve this "with documentation").
>
> So, what shall we do?
>
If I’m understanding everything correctly it should be relatively 
simple to extend networking_freebsd.c to also set a weight for each 
route it installs.
We’d have to convert the metric into a weight, which I think we could 
do as `weight = RT_MAX_WEIGHT - metric` (RT_MAX_WEIGHT is 16777215 /* 3 
bytes */).

Can you try this?

	diff --git a/src/openvpn/networking_freebsd.c 
b/src/openvpn/networking_freebsd.c
	index 0633dce7..e79af2bf 100644
	--- a/src/openvpn/networking_freebsd.c
	+++ b/src/openvpn/networking_freebsd.c
	@@ -10,6 +10,8 @@

	 #if defined(TARGET_FREEBSD)

	+#include <net/route.h>
	+
	 static int
	 net_route_v4(const char *op, const in_addr_t *dst, int prefixlen,
	              const in_addr_t *gw, const char *iface, uint32_t table,
	@@ -23,12 +25,13 @@ net_route_v4(const char *op, const in_addr_t *dst, 
int prefixlen,
	     _dst = ntohl(*dst);
	     _gw = ntohl(*gw);

	-    argv_printf(&argv, "%s %s -net %s/%d %s -fib %d",
	+    argv_printf(&argv, "%s %s -net %s/%d %s -fib %d -weight %d",
	                 ROUTE_PATH, op,
	                 inet_ntop(AF_INET, &_dst, buf1, sizeof(buf1)),
	                 prefixlen,
	                 inet_ntop(AF_INET, &_gw, buf2, sizeof(buf2)),
	-                table);
	+                table,
	+                RT_MAX_WEIGHT - metric);

	     argv_msg(M_INFO, &argv);
	     status = openvpn_execve_check(&argv, NULL, 0,
	@@ -48,12 +51,13 @@ net_route_v6(const char *op, const struct in6_addr 
*dst,
	     struct argv argv = argv_new();
	     bool status;

	-    argv_printf(&argv, "%s -6 %s -net %s/%d %s -fib %d",
	+    argv_printf(&argv, "%s -6 %s -net %s/%d %s -fib %d -weight %d",
	                 ROUTE_PATH, op,
	                 inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)),
	                 prefixlen,
	                 inet_ntop(AF_INET6, gw, buf2, sizeof(buf2)),
	-                table);
	+                table,
	+                RT_MAX_WEIGHT - metric);

	     argv_msg(M_INFO, &argv);
	     status = openvpn_execve_check(&argv, NULL, 0,

Kristof
--=_MailMate_C427DE8D-62AB-4CCF-BAE5-EAC24188FEEF_=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/xhtml; charset=3Dutf-8">
</head>
<body><div style=3D"font-family: sans-serif;"><div class=3D"markdown" style=
=3D"white-space: normal;">
<p dir=3D"auto">On 20 Aug 2022, at 16:33, Gert Doering wrote:</p>
</div><div class=3D"plaintext" style=3D"white-space: normal;"><blockquote s=
tyle=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px solid #136BCE;=
 color: #136BCE;"><blockquote style=3D"margin: 0 0 5px; padding-left: 5px; =
border-left: 2px solid #136BCE; border-left-color: #4B89CF; color: #4B89CF;=
"><p dir=3D"auto"> - iroute installation works for the easy cases (--route =
in server.conf,
<br>
   --iroute with a more-specific of that in ccd/).  It does not work
<br>
   for the nasty cases (--route and --iroute with same netbits).</p>
<p dir=3D"auto">   I will send a followup e-mail with more details on this =
soon.</p>
</blockquote><p dir=3D"auto">*This* is the bit I want to cover separately, =
because this e-mail is
<br>
going to be long :-)</p>
<p dir=3D"auto">So, here's my test cases, to see if I could get DCO to misb=
ehave.</p>
<p dir=3D"auto">Server config has:</p>
<p dir=3D"auto"># grep ^route server.conf
<br>
route 10.114.200.0 255.255.255.0
<br>
route-ipv6 fd00:abcd:114:200::/64
<br>
route 10.114.201.0 255.255.255.0
<br>
route-ipv6 fd00:abcd:114:201::/64</p>
<p dir=3D"auto">("pull two /24 and two /64 towards the tun interface")</p>
<p dir=3D"auto">There is one particular client which has many addresses con=
figured on
<br>
its loopback</p>
<p dir=3D"auto">lo0: flags=3D8049&lt;UP,LOOPBACK,RUNNING,MULTICAST&gt; metr=
ic 0 mtu 16384
<br>
        inet 10.114.200.74 netmask 0xffffffff
<br>
        inet 10.114.201.74 netmask 0xffffffff
<br>
        inet 10.114.202.74 netmask 0xffffffff
<br>
        inet6 fd00:abcd:114:200::74 prefixlen 128
<br>
        inet6 fd00:abcd:114:201::74 prefixlen 128
<br>
        inet6 fd00:abcd:114:202::74 prefixlen 128</p>
<p dir=3D"auto">... and when that client connects, the expectation is that =
*other* clients
<br>
can ping these 6 addresses (note it's 200, 201, 202 for v4 and v6).</p>
<p dir=3D"auto">Here's the ccd file for this client:</p>
<p dir=3D"auto"># cat /root/t_server/tun-udp-p2mp/ccd/freebsd-74-amd64
<br>
# Host iroute
<br>
iroute 10.114.200.74 255.255.255.255
<br>
iroute-ipv6 fd00:abcd:114:200::74/128
<br>
# Subnet-iroute
<br>
iroute 10.114.201.0 255.255.255.0
<br>
iroute-ipv6 fd00:abcd:114:201::/64
<br>
# iroute-without-route
<br>
# 10.114.202, fd00:abcd:114:202::/64
<br>
iroute 10.114.202.74 255.255.255.255
<br>
iroute-ipv6 fd00:abcd:114:202::74/128</p>
<p dir=3D"auto">So the "200" routes are "install a host route for IPv4 or I=
Pv6 that is
<br>
part of an aggregate".  This works fine.</p>
<p dir=3D"auto">The "202" routes are "install a host route for IPv4 or IPv6=
 where there
<br>
is no covering --route" - this is basically something OpenVPN could not
<br>
do before DCO (update host routes on-demand on client connect), but is
<br>
something I've long waited for :-) - this also works fine.</p>
<p dir=3D"auto">Now, the 201 routes are "there whole network specified in -=
-route is
<br>
routed to a single client".  This is not such an unusual setup in
<br>
cases like "there is a central office OpenVPN server, and one of the
<br>
branch offices wants it 192.168.77.0/24 reachable from the other
<br>
clients".  This *fails*.</p>
<p dir=3D"auto">For IPv4, we end up with "netstat -rn" looking like this:</=
p>
<p dir=3D"auto">10.114.201.0/24    10.114.2.2         UGS        tun1
<br>
10.114.201.0/24    10.114.2.8         UGS        tun1</p>
<p dir=3D"auto">and "route get" telling us the the first one is preferred</=
p>
<p dir=3D"auto">$ route get 10.114.201.74
<br>
   route to: 10.114.201.74
<br>
destination: 10.114.201.0
<br>
       mask: 255.255.255.0
<br>
    gateway: 10.114.2.2
<br>
        fib: 0
<br>
  interface: tun1</p>
<p dir=3D"auto">so packets loop... (10.114.2.2 is not an address that belon=
gs to an
<br>
actual client, but "the tun interface peer") the client is 10.114.2.8.</p>
<p dir=3D"auto">$ traceroute 10.114.201.74
<br>
traceroute to 10.114.201.74 (10.114.201.74), 64 hops max, 40 byte packets
<br>
 1  10.114.2.2 (10.114.2.2)  1.706 ms  1.240 ms  0.921 ms
<br>
 2  localhost (127.0.0.1)  0.865 ms  0.809 ms  0.807 ms
<br>
 3  10.114.2.2 (10.114.2.2)  1.603 ms  1.605 ms  1.595 ms
<br>
 4  localhost (127.0.0.1)  1.533 ms  1.383 ms  1.768 ms</p>
<p dir=3D"auto">For IPv6, things look different - route installation fails<=
/p>
<p dir=3D"auto">2022-08-20 15:47:24 freebsd-74-amd64/2001:608:0:814::f000:3=
 /sbin/route -6 add -net fd00:abcd:114:201::/64 fd00:abcd:114:2::1006 -fib 0
<br>
add net fd00:abcd:114:201::/64: gateway fd00:abcd:114:2::1006 fib 0: route =
already in table</p>
<p dir=3D"auto">so, the iroute never makes it to kernel, "netstat -rn" rema=
ins at</p>
<p dir=3D"auto">fd00:abcd:114:201::/64            link#14                  =
     US         tun1</p>
<p dir=3D"auto">and packets loop as well</p>
<p dir=3D"auto">$ traceroute6 fd00:abcd:114:201::74
<br>
traceroute6 to fd00:abcd:114:201::74 (fd00:abcd:114:201::74) from fd00:abcd=
:114:2::1, 64 hops max, 28 byte packets
<br>
 1  fd00:abcd:114:2::1000  1.749 ms  1.246 ms  0.930 ms
<br>
 2  fd00:abcd:114:2::1  0.836 ms  1.225 ms  1.067 ms
<br>
 3  fd00:abcd:114:2::1000  1.555 ms  1.631 ms  1.575 ms
<br>
 4  fd00:abcd:114:2::1  1.472 ms  1.531 ms  1.677 ms</p>
<p dir=3D"auto">So, what we do on *Linux* to handle this, is to work with r=
oute metrics
<br>
(10.220.* =3D "same instances, different host, so different address range")=
</p>
<p dir=3D"auto">linux$ ip route |grep tun1
<br>
10.220.200.0/24 via 10.220.2.2 dev tun1 metric 200
<br>
10.220.200.74 via 10.220.2.8 dev tun1 metric 100
<br>
10.220.201.0/24 via 10.220.2.8 dev tun1 metric 100
<br>
10.220.201.0/24 via 10.220.2.2 dev tun1 metric 200
<br>
10.220.202.74 via 10.220.2.8 dev tun1 metric 100
<br>
linux$ ip -6 route |grep tun1
<br>
fd00:abcd:220:200::74 via fd00:abcd:220:2::1006 dev tun1 metric 100 pref me=
dium
<br>
fd00:abcd:220:200::/64 dev tun1 metric 200 pref medium
<br>
fd00:abcd:220:201::/64 via fd00:abcd:220:2::1006 dev tun1 metric 100 pref m=
edium
<br>
fd00:abcd:220:201::/64 dev tun1 metric 200 pref medium
<br>
fd00:abcd:220:202::74 via fd00:abcd:220:2::1006 dev tun1 metric 100 pref me=
dium</p>
<p dir=3D"auto">so there's always 5 routes in the active table - 2 "--route=
" routes
<br>
(according to server.conf) with *metric 200*, and then 3 "--iroute" routes
<br>
(from ccd/) with metric DCO_IROUTE_METRIC =3D 100.</p>
<p dir=3D"auto">Linux handles this as would a "Cisco router" do - if there =
are two
<br>
identical routes with different metric, the lower-metric route is
<br>
used, and the other one is ignored.  So this works very nicely.</p>
<p dir=3D"auto">Now, back to FreeBSD.</p>
<p dir=3D"auto">  - our code does not try to set metrics on FreeBSD
<br>
  - my reading of route(8) does not show me anything in that direction
<br>
    (metric, preference, administrative distance, ...)
<br>
  - I do not understand FreeBSD internals well enough to know whether
<br>
    it can be done at all, or not.</p>
<br></blockquote></div>
<div class=3D"markdown" style=3D"white-space: normal;">
<p dir=3D"auto">It=E2=80=99s rather poorly (i.e. not) documented, but it is=
 possible to set a route metric. It=E2=80=99s called a =E2=80=98weight=E2=
=80=99, and not actually mentioned in the man page. Or shown in netstat out=
put.</p>
<p dir=3D"auto">But:</p>
<pre style=3D"margin-left: 15px; margin-right: 15px; padding: 5px; border: =
thin solid gray; overflow-x: auto; max-width: 90vw; background-color: #E4E4=
E4;"><code>$ sudo route add 172.16.2.0/24 10.0.2.1
add net 172.16.2.0: gateway 10.0.2.1
$ sudo route add 172.16.2.0/24 -weight 2 10.0.2.254
add net 172.16.2.0: gateway 10.0.2.254
</code></pre>
<p dir=3D"auto">So we can add multiple routes for the same network, as long=
 as they have a different gateway.</p>
<p dir=3D"auto">The usual <code>netstat -rn</code> doesn=E2=80=99t show the=
 weight. You have to use the json/xml output to get it:</p>
<pre style=3D"margin-left: 15px; margin-right: 15px; padding: 5px; border: =
thin solid gray; overflow-x: auto; max-width: 90vw; background-color: #E4E4=
E4;"><code>$ netstat -rn --libxo json | jq
=E2=80=A6
          {
            &quot;destination&quot;: &quot;172.16.2.0/24&quot;,
            &quot;gateway&quot;: &quot;10.0.2.1&quot;,
            &quot;flags&quot;: &quot;UGS&quot;,
            &quot;flags_pretty&quot;: [
              &quot;up&quot;,
              &quot;gateway&quot;,
              &quot;static&quot;
            ],
            &quot;weight&quot;: 1,
            &quot;interface-name&quot;: &quot;bnxt0&quot;
          },
          {
            &quot;destination&quot;: &quot;172.16.2.0/24&quot;,
            &quot;gateway&quot;: &quot;10.0.2.254&quot;,
            &quot;flags&quot;: &quot;UGS&quot;,
            &quot;flags_pretty&quot;: [
              &quot;up&quot;,
              &quot;gateway&quot;,
              &quot;static&quot;
            ],
            &quot;weight&quot;: 2,
            &quot;interface-name&quot;: &quot;bnxt0&quot;
          },
</code></pre>
<p dir=3D"auto">A higher weight gives a higher priority, so that=E2=80=99s =
the opposite of what Linux does with metric, I believe.</p>
</div><div class=3D"plaintext" style=3D"white-space: normal;"><blockquote s=
tyle=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px solid #136BCE;=
 color: #136BCE;"><p dir=3D"auto">If it can not be done, we need to documen=
t this as "one of the issues
<br>
with FreeBSD DCO", and it can of course be easily workarounded in most
<br>
cases</p>
<p dir=3D"auto">  --route 10.114.201.0/24
<br>
    --iroute 10.114.201.0/25
<br>
    --iroute 10.114.201.128/25</p>
<p dir=3D"auto">will get the same thing done "when client is online route t=
he whole /25
<br>
down there", but it's harder to get into people's heads :-)  (adding
<br>
code to auto-split such a prefix is technically possible but would be
<br>
quite a complication, so I'd rather solve this "with documentation").</p>
<p dir=3D"auto">So, what shall we do?</p>
<br></blockquote></div>
<div class=3D"markdown" style=3D"white-space: normal;">
<p dir=3D"auto">If I=E2=80=99m understanding everything correctly it should=
 be relatively simple to extend networking_freebsd.c to also set a weight f=
or each route it installs.<br>
We=E2=80=99d have to convert the metric into a weight, which I think we cou=
ld do as <code>weight =3D RT_MAX_WEIGHT - metric</code> (RT_MAX_WEIGHT is 1=
6777215 /* 3 bytes */).</p>
<p dir=3D"auto">Can you try this?</p>
<pre style=3D"margin-left: 15px; margin-right: 15px; padding: 5px; border: =
thin solid gray; overflow-x: auto; max-width: 90vw; background-color: #E4E4=
E4;"><code>diff --git a/src/openvpn/networking_freebsd.c b/src/openvpn/netw=
orking_freebsd.c
index 0633dce7..e79af2bf 100644
--- a/src/openvpn/networking_freebsd.c
+++ b/src/openvpn/networking_freebsd.c
@@ -10,6 +10,8 @@

 #if defined(TARGET_FREEBSD)

+#include &lt;net/route.h&gt;
+
 static int
 net_route_v4(const char *op, const in_addr_t *dst, int prefixlen,
              const in_addr_t *gw, const char *iface, uint32_t table,
@@ -23,12 +25,13 @@ net_route_v4(const char *op, const in_addr_t *dst, int =
prefixlen,
     _dst =3D ntohl(*dst);
     _gw =3D ntohl(*gw);

-    argv_printf(&amp;argv, &quot;%s %s -net %s/%d %s -fib %d&quot;,
+    argv_printf(&amp;argv, &quot;%s %s -net %s/%d %s -fib %d -weight %d&qu=
ot;,
                 ROUTE_PATH, op,
                 inet_ntop(AF_INET, &amp;_dst, buf1, sizeof(buf1)),
                 prefixlen,
                 inet_ntop(AF_INET, &amp;_gw, buf2, sizeof(buf2)),
-                table);
+                table,
+                RT_MAX_WEIGHT - metric);

     argv_msg(M_INFO, &amp;argv);
     status =3D openvpn_execve_check(&amp;argv, NULL, 0,
@@ -48,12 +51,13 @@ net_route_v6(const char *op, const struct in6_addr *dst,
     struct argv argv =3D argv_new();
     bool status;

-    argv_printf(&amp;argv, &quot;%s -6 %s -net %s/%d %s -fib %d&quot;,
+    argv_printf(&amp;argv, &quot;%s -6 %s -net %s/%d %s -fib %d -weight %d=
&quot;,
                 ROUTE_PATH, op,
                 inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)),
                 prefixlen,
                 inet_ntop(AF_INET6, gw, buf2, sizeof(buf2)),
-                table);
+                table,
+                RT_MAX_WEIGHT - metric);

     argv_msg(M_INFO, &amp;argv);
     status =3D openvpn_execve_check(&amp;argv, NULL, 0,
</code></pre>
<p dir=3D"auto">Kristof</p>

</div></div></body>

</html>

--=_MailMate_C427DE8D-62AB-4CCF-BAE5-EAC24188FEEF_=--

