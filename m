Date: Sat, 20 Aug 2022 16:33:32 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YwDwvG++hK0nJI2F@...1296...>
References: <20220812134154.16729-3-kprovost@...2661...>
 <202208201401.27KE12Cm014083@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ZxcsvbptOkhftBxt"
Content-Disposition: inline
In-Reply-To: <202208201401.27KE12Cm014083@...2054...>
Subject: Re: [Openvpn-devel] route/iroute handling on FreeBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kristof Provost <kp@...1249...>
Cc: openvpn-devel@lists.sourceforge.net

--ZxcsvbptOkhftBxt
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

so, as promised, more details on the route/iroute issues I saw...  with
a new Subject: line, to keep the threads halfway orderly.

On Sat, Aug 20, 2022 at 04:01:02PM +0200, Gert Doering wrote:
>  - route *deletion* does not work for IPv4 host routes, because of
>    "other code stupidity" - this is not a problem of your code, but
>    of an omission in dco.c (and I do wonder why this works for Linux)

A patch for *this* has been sent, so this is of no concern anymore
(just needs someone bold enough to ACK it).

>  - in one case I saw something that looks like a race condition between
>    DCO, "ifconfig route propagation", and "route add"

This is something I need to test further, to see if this was a one-off
issue, or can be reproduced with good timing.

>  - iroute installation works for the easy cases (--route in server.conf,
>    --iroute with a more-specific of that in ccd/).  It does not work
>    for the nasty cases (--route and --iroute with same netbits).
>=20
>    I will send a followup e-mail with more details on this soon.

*This* is the bit I want to cover separately, because this e-mail is
going to be long :-)

So, here's my test cases, to see if I could get DCO to misbehave.

Server config has:

# grep ^route server.conf
route 10.114.200.0 255.255.255.0
route-ipv6 fd00:abcd:114:200::/64
route 10.114.201.0 255.255.255.0
route-ipv6 fd00:abcd:114:201::/64

("pull two /24 and two /64 towards the tun interface")

There is one particular client which has many addresses configured on
its loopback

lo0: flags=3D8049<UP,LOOPBACK,RUNNING,MULTICAST> metric 0 mtu 16384
        inet 10.114.200.74 netmask 0xffffffff=20
        inet 10.114.201.74 netmask 0xffffffff=20
        inet 10.114.202.74 netmask 0xffffffff=20
        inet6 fd00:abcd:114:200::74 prefixlen 128=20
        inet6 fd00:abcd:114:201::74 prefixlen 128=20
        inet6 fd00:abcd:114:202::74 prefixlen 128=20

... and when that client connects, the expectation is that *other* clients
can ping these 6 addresses (note it's 200, 201, 202 for v4 and v6).

Here's the ccd file for this client:

# cat /root/t_server/tun-udp-p2mp/ccd/freebsd-74-amd64
# Host iroute
iroute 10.114.200.74 255.255.255.255
iroute-ipv6 fd00:abcd:114:200::74/128
# Subnet-iroute
iroute 10.114.201.0 255.255.255.0
iroute-ipv6 fd00:abcd:114:201::/64
# iroute-without-route
# 10.114.202, fd00:abcd:114:202::/64
iroute 10.114.202.74 255.255.255.255
iroute-ipv6 fd00:abcd:114:202::74/128


So the "200" routes are "install a host route for IPv4 or IPv6 that is
part of an aggregate".  This works fine.

The "202" routes are "install a host route for IPv4 or IPv6 where there
is no covering --route" - this is basically something OpenVPN could not
do before DCO (update host routes on-demand on client connect), but is
something I've long waited for :-) - this also works fine.

Now, the 201 routes are "there whole network specified in --route is
routed to a single client".  This is not such an unusual setup in
cases like "there is a central office OpenVPN server, and one of the
branch offices wants it 192.168.77.0/24 reachable from the other=20
clients".  This *fails*.

For IPv4, we end up with "netstat -rn" looking like this:

10.114.201.0/24    10.114.2.2         UGS        tun1
10.114.201.0/24    10.114.2.8         UGS        tun1

and "route get" telling us the the first one is preferred

$ route get 10.114.201.74
   route to: 10.114.201.74
destination: 10.114.201.0
       mask: 255.255.255.0
    gateway: 10.114.2.2
        fib: 0
  interface: tun1

so packets loop... (10.114.2.2 is not an address that belongs to an
actual client, but "the tun interface peer") the client is 10.114.2.8.

$ traceroute 10.114.201.74
traceroute to 10.114.201.74 (10.114.201.74), 64 hops max, 40 byte packets
 1  10.114.2.2 (10.114.2.2)  1.706 ms  1.240 ms  0.921 ms
 2  localhost (127.0.0.1)  0.865 ms  0.809 ms  0.807 ms
 3  10.114.2.2 (10.114.2.2)  1.603 ms  1.605 ms  1.595 ms
 4  localhost (127.0.0.1)  1.533 ms  1.383 ms  1.768 ms


For IPv6, things look different - route installation fails

2022-08-20 15:47:24 freebsd-74-amd64/2001:608:0:814::f000:3 /sbin/route -6 =
add -net fd00:abcd:114:201::/64 fd00:abcd:114:2::1006 -fib 0
add net fd00:abcd:114:201::/64: gateway fd00:abcd:114:2::1006 fib 0: route =
already in table

so, the iroute never makes it to kernel, "netstat -rn" remains at

fd00:abcd:114:201::/64            link#14                       US         =
tun1

and packets loop as well

$ traceroute6 fd00:abcd:114:201::74
traceroute6 to fd00:abcd:114:201::74 (fd00:abcd:114:201::74) from fd00:abcd=
:114:2::1, 64 hops max, 28 byte packets
 1  fd00:abcd:114:2::1000  1.749 ms  1.246 ms  0.930 ms
 2  fd00:abcd:114:2::1  0.836 ms  1.225 ms  1.067 ms
 3  fd00:abcd:114:2::1000  1.555 ms  1.631 ms  1.575 ms
 4  fd00:abcd:114:2::1  1.472 ms  1.531 ms  1.677 ms



So, what we do on *Linux* to handle this, is to work with route metrics
(10.220.* =3D "same instances, different host, so different address range")

linux$ ip route |grep tun1
10.220.200.0/24 via 10.220.2.2 dev tun1 metric 200=20
10.220.200.74 via 10.220.2.8 dev tun1 metric 100=20
10.220.201.0/24 via 10.220.2.8 dev tun1 metric 100=20
10.220.201.0/24 via 10.220.2.2 dev tun1 metric 200=20
10.220.202.74 via 10.220.2.8 dev tun1 metric 100=20
linux$ ip -6 route |grep tun1
fd00:abcd:220:200::74 via fd00:abcd:220:2::1006 dev tun1 metric 100 pref me=
dium
fd00:abcd:220:200::/64 dev tun1 metric 200 pref medium
fd00:abcd:220:201::/64 via fd00:abcd:220:2::1006 dev tun1 metric 100 pref m=
edium
fd00:abcd:220:201::/64 dev tun1 metric 200 pref medium
fd00:abcd:220:202::74 via fd00:abcd:220:2::1006 dev tun1 metric 100 pref me=
dium

so there's always 5 routes in the active table - 2 "--route" routes
(according to server.conf) with *metric 200*, and then 3 "--iroute" routes
(from ccd/) with metric DCO_IROUTE_METRIC =3D 100.

Linux handles this as would a "Cisco router" do - if there are two
identical routes with different metric, the lower-metric route is
used, and the other one is ignored.  So this works very nicely.


Now, back to FreeBSD.

  - our code does not try to set metrics on FreeBSD
  - my reading of route(8) does not show me anything in that direction=20
    (metric, preference, administrative distance, ...)
  - I do not understand FreeBSD internals well enough to know whether=20
    it can be done at all, or not.

If it can not be done, we need to document this as "one of the issues
with FreeBSD DCO", and it can of course be easily workarounded in most
cases

  --route 10.114.201.0/24
    --iroute 10.114.201.0/25
    --iroute 10.114.201.128/25

will get the same thing done "when client is online route the whole /25
down there", but it's harder to get into people's heads :-)  (adding
code to auto-split such a prefix is technically possible but would be=20
quite a complication, so I'd rather solve this "with documentation").

So, what shall we do?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ZxcsvbptOkhftBxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjAPC8AAoJEB2Cnv7KVigSnM4L/j+z3Z3XrhONtXv1ZN3+Sjiv
a7Ni3xeKvYSDoW+0NsNC7WkLid48QcsVPtrx/PzBD3HQln2krFLril8QHyaitPf5
DTxYwOSZ+YgSa0lnJLXJ8AO9KJuZ5eXo9wSopeBTp9MxWvUczqlejDs+jruKrkeJ
qoZ5UxtQN0MfaF14rCw76sQUlT3WSKzIBEUg12I5ZPOOEvsnxFcOWaUwGQ0zgmcj
m4DbWthmxfALdV7k6WbU2CJ2znesGhS6xslhxDL3xi6nPewLRKg6ptlI41A0K2jb
zwaKTTD7yInI9rLpiY3cz2Y4gTwJ8YRtY8esOlGbFE2VTfXvh2IT9oICDD5Qhc50
AVhRpy0mEAl9o0oikiWlYShuALDpT8KKzyJioymJkHkhOQAfn5xXF7shlhN1qDdt
u3eQKV9egfWk+E8yxnXFFjENtDYpbhbNzZl7NrcxsJkFk84r8R2ycxZ1ystsM9xJ
N/l8rii5N620H+l7HP0r8VunnBdQE5oQJ5v5r7TVqA==
=xcPQ
-----END PGP SIGNATURE-----

--ZxcsvbptOkhftBxt--

