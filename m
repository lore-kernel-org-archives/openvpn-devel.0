Date: Thu, 18 Aug 2022 21:52:54 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yv6YlmJZ6jlCex3q@...1296...>
References: <20220818092638.189632-1-a@...2181...>
 <20220818100953.191328-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="mLMhX7hbS0pVjeV9"
Content-Disposition: inline
In-Reply-To: <20220818100953.191328-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v103 2/7] dco-win: check for
 incompatible options
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--mLMhX7hbS0pVjeV9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 18, 2022 at 12:09:53PM +0200, Antonio Quartulli wrote:
> At the moment dco-win doesn't support --persist-tun and --server,
> so check for these options at startup time.
>=20
> Signed-off-by: Antonio Quartulli <a@...2181...>
> Signed-off-by: Lev Stipakov <lev@...515...>

I was about to merge this (and thank you for bearing with a grumpy
old man's preferences ;-) - but I really think that the difference
in these platforms need to stand out right there...).

Butbut...

This breaks Linux/Non-DCO builds with --dev tun30, and I can't see
an obvious reason *why*

$ src/openvpn/openvpn --version
OpenVPN 2.6_git [git:vw/master/f10c870c140bd3c6] x86_64-pc-linux-gnu [SSL (=
mbed TLS)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] built on Aug 18 2022

(no DCO here, this is "master + 2/7 v103", on Linux)

$ openvpn ... --dev tun30 --proto udp ...
...
2022-08-18 21:43:52 OPTIONS IMPORT: peer-id set
2022-08-18 21:43:52 OPTIONS IMPORT: data channel crypto options modified
2022-08-18 21:43:52 net_route_v4_best_gw query: dst 0.0.0.0
2022-08-18 21:43:52 net_route_v4_best_gw result: via 195.30.8.94 dev ens160
2022-08-18 21:43:52 GDG6: remote_host_ipv6=3Dn/a
2022-08-18 21:43:52 net_route_v6_best_gw query: dst ::
2022-08-18 21:43:52 net_route_v6_best_gw result: via 2001:608:1:995a::ffff =
dev ens160
2022-08-18 21:43:52 DCO device tun30 opened
2022-08-18 21:43:52 net_iface_mtu_set: rtnl: cannot get ifindex for tun30: =
No such device (errno=3D19)
2022-08-18 21:43:52 Linux can't set mtu (1500) on tun30
2022-08-18 21:43:52 Exiting due to fatal error

why is it talking about DCO here?  Why would it even *know* about DCO
in a non-DCO build?

Not sure why any of the hunks in this patch have an effect, but if I=20
go back to the current master, --dev tun30 works, both with and without
--enable-dco.

*scratch head*

Ow.

+#if defined(TARGET_LINUX) && defined(TARGET_FREEBSD)
     /* check if any option should force disabling DCO */
-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)

this is not "just moving" these lines, but requiring "LEENUX AND FREEBSD"
now...

You owe me a beer :-)

(Changing the && to || makes the --dev tun30 test pass again - I'm=20
still not sure *what* happened here... but maybe we should reconsider
the decision to have disable_dco default to "false" even on non-DCO
builds...)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--mLMhX7hbS0pVjeV9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi/piWAAoJEB2Cnv7KVigSLDUL/2NrrtUelL0f4EwIEwDgF+x4
9SFCu6tO6U4TzknWIwd5nQZr9WhF+AZs0rxKODqSEwf0RRJlvBg0f5+rQzlrv0pF
eSMU4liJ4fq4ySJBLVVpwQuHVYVRf4T7L42d55/Nk93sI+gPB+u2UqSK4og14/0O
f/Vor77UMeSqG3UuFG8ehS8FirBSRD8kUqrd846aXnpOljk2a7aGmIelHQ+p+ryz
oJZv4I6VCi38kW6pbtIBI1czJYLAX5v8z7E+OHVgXRD77eyngZh3m3oLryTggyX6
RyfTdV5WFJ2Dkuwkl7C5mEDVO4zxTZIVWdCpUeU4FbTfZbJE+yX87bdG7uy7UYW4
7sfxgJsWvGe8jxQZ+1Sn1D9TOxWX8glxqK3s7OsDlSVk92D+PM3sPo7Hp3GBdjas
O3+fK9rrFCP8CANfBf/5OWbeCipMyEscwh6BbZag0M7nmkXLeSmQbY4HDrFcgvs7
//AKOr2tstGXv0BtYv2YqFrOn34395G4/JkBtK0nLQ==
=AfTr
-----END PGP SIGNATURE-----

--mLMhX7hbS0pVjeV9--

