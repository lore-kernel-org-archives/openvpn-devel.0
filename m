Date: Thu, 11 Aug 2022 23:11:12 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YvVwcBtzGagtUgOA@...1296...>
References: <20220808143424.65924-1-kprovost@...2661...>
 <20220808143424.65924-3-kprovost@...2661...>
 <YvPdlCSxQ6wvfIna@...1296...>
 <2DCBB302-1FB4-4EC0-8B4A-8D6EA075B0FD@...2661...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="KKl/eirsrmcLjMHB"
Content-Disposition: inline
In-Reply-To: <2DCBB302-1FB4-4EC0-8B4A-8D6EA075B0FD@...2661...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] ovpn-dco: introduce FreeBSD
 data-channel offload support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kristof Provost <kprovost@...2661...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--KKl/eirsrmcLjMHB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 11, 2022 at 05:25:05PM +0200, Kristof Provost via Openvpn-devel=
 wrote:
> On 10 Aug 2022, at 18:32, Gert Doering wrote:
> > as promised, here's test results and code review.
> >
> > Test results:
> >
> >  - running openvpn over TCP gives me a kernel panic - this is not so
> >    nice... (see attached .png from the vmware console) - userland seems
> >    to assume "kernel can do TCP", kernel panics on "if !udp, panic()"
> >    (so intentional panic, not corruption panic).
> >
> >    This is on freebsd git FreeBSD 14.0-CURRENT #1 main-n257130-c0665d5c=
824
>
> I???ve pushed a fix for this panic in fd6b3bede5a5c210f327e5c9bd3e415ee90=
5048b.
> I simply didn???t think that user space might give us a non-UDP
> socket, so checking for that and rejecting the peer in that case
> fixes the panic. Thanks for finding that.

Always happy to crash other people's software :-)

That said, this seems to imply that FreeBSD DCO is UDP-only today - do
you have plans for TCP as well, or is this something "someone else needs
to contribute"?

For the time being we should add an #ifdef TARGET_FREEBSD check to
dco.c:dco_check_option_conflict_platform() and disable DCO for
--proto tcp.

I thought the function would only get introduced in patch 20/25 of
the big DCO series, but that patch is a bit out of sync - the function
is already there, with Linux specific checks.


> >  - running openvpn over UDP has issues with fragmentation - almost all
> >    t_client tests that *do* use DCO fail the "big ping" test
> >
> >     FAIL: IPv4 ping test (3000 bytes) failed, but should succeed.
> >     FAIL: IPv6 ping test (3000 bytes) failed, but should succeed.
> >
> >    this is "with no special mtu related options to OpenVPN", so the
> >    tun interface is MTU 1500, and the pings are created by
> >
> >         fping -b 3000 -C 20 -p 250 -q -C 5 -p 400 10.194.5.1 10.194.0.1
> >         fping6 -b 3000 -C 20 -p 250 -q -C 5 -p 400 fd00:abcd:194:5::1 f=
d00:abcd:194:0::1
> >
> >    (testing the host "on the p2p link" and "something behind a --route
> >     pushed by the server")
>
> I???m failing to reproduce this in my own test setup. With a
> simple ???ping -c 2000??? on a 1500 MTU tunnel I see two layers of
> fragmentation (the ICMP packet gets fragmented before it goes through
> the tunnel, and then the outer UDP packet gets fragmented as well),
> as I???d expect. Traffic flows in both directions. (i.e. the ping
> succeeds).

OK.  This is generally good, so I need to find out who is eating my
packets.  In my case, I have 3 fragments, which might or might not
cause a difference - and there's stuff in between (FreeBSD 14 client
via FreeBSD 12 pf(4) firewall to FreeBSD 11 [or so] server).

> Is there any documentation on how t_client.sh works? It???s not at all=20
> clear to me what goes in t_client.in (e.g. in OPENVPN_BASE_P2P).

Basically, t_client is a very basic vehicle to fire up certain
OpenVPN configurations, verify that the expect IPv4 and IPv6 addresses
show up on "a new interface", and that pings to certain destinations
work, with varying packet sizes.  It's a bit of a sledge hammer, but
it's good at finding stuff.

My configs have something like this:

CA_CERT=3D"$KEYBASE/ca.crt"
CLIENT_KEY=3D"$KEYBASE/cron2-gentoo-i386.key"
CLIENT_CERT=3D"$KEYBASE/cron2-gentoo-i386.crt"

REMOTE=3Dconn-test-server.openvpn.org

# this is the basic "TLS client" stuff with ca/cert/key
# remove the comp-lzo for DCO tests
OPENVPN_BASE_P2MP=3D"--client --ca $CA_CERT \
        --cert $CLIENT_CERT --key $CLIENT_KEY \
        --remote-cert-tls server --comp-lzo --verb 3 $OPENVPN_EXTRA_CF"

#
# Test 2: UDP / p2mp tun
#   specify IPv4+IPv6 addresses expected from server and ping targets
#
RUN_TITLE_2=3D"udp / p2pm / top net30"
OPENVPN_CONF_2=3D"$OPENVPN_BASE_P2MP --dev tun --proto udp4 --remote $REMOT=
E --port 51194"
EXPECT_IFCONFIG4_2=3D"10.194.2.54"
EXPECT_IFCONFIG6_2=3D"fd00:abcd:194:2::100c"
PING4_HOSTS_2=3D"10.194.2.1 10.194.0.1"
PING6_HOSTS_2=3D"fd00:abcd:194:2::1 fd00:abcd:194:0::1"

... so this would connect to a specific UDP instance on the test server,
expect to be assigned these addresses (=3D this needs adjustment after
the first run, when you know what addresses will be assigned, and it
assumes --ip-pool-persist on the server), and then pings things.

I usually ping "the server IP on that tun" and "a loopback IP on the
server, which is only reachable by means of 'push route...'", so I
can see if push/pull and route installation works.


If you're interested, I can unicast you the full file I use for
my DCO client tests, with different ciphers, some instances with
compression (=3D does it properly fall back?), some with http/socks
proxy, etc., plus a set of client+ca certificates to run against
our test server.


[..]
> >    ... this *does* look correct, but there is never a reply from the ot=
her
> >    end, so something is not right.  Either inside or outside.
>
> Is your server in this scenario a FreeBSD DCO machine, or Linux DCO or so=
mething else?
> In my setup the server is non-DCO FreeBSD.

FreeBSD 14 DCO -> FreeBSD 13.0 pf(4) firewall -> Internet -> FreeBSD 11.4

If I --disable-dco, the fragmented ping works, so "generally" the
path handles fragments.  Something is different with DCO, so I'll do
more tcpdumping tomorrow and see if I can find out.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--KKl/eirsrmcLjMHB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi9XBwAAoJEB2Cnv7KVigSHZMMAKzXItcD6SvmWIGV0Fv7GAF9
2RZEtkpk+f/CeeEk0NihhV7NajPSlEk66KfYkFXlUANaYK+v/+Q4Zb/p6uPY7u+Z
dmnVn+ctVst9A6eUQD05k3KEDxLwZjSdU42faNqvRIcMbg8JZAm1cKbmXUjtsnU6
zSVJAlMUk3iHbxBrSy22dHh3B1SlVEpCRx1jSSpleRv15tEWBy16Z6P8zVSippf0
mWSoddAx64sLudB1LoHB1Z5Czxsm4cchgVNb49OQ/gbNcNi9GC42r49bY3kDzyOB
yPKCR7vy2g5AQlTV7nbJfSXFo1p54WPkMZ4JNxjPj0MxDLTGgsMMnZ4S46puSocy
Gx4iKUryHxVsOjAQiM2OpxH/smoqzXjjzL4+KNJ2Dcn4MzT8KTkpjoDt2F3FTsa0
bVGTchuecvmkxqp2PZQB9UejUZi+JTQhyzM+AlPnWKI1CUXThM6uzj0RrO49RPRF
EX7LVaD+R1A+z1BXJeUVqxfmHTc+Y58pC4jsQNHh5g==
=bjfp
-----END PGP SIGNATURE-----

--KKl/eirsrmcLjMHB--

