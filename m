Date: Tue, 16 Feb 2021 20:32:15 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210216193215.GQ976@...1296...>
References: <20210214145023.GU976@...1296...>
 <20210215143146.9770-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="gr1qnwuxagNDSOsy"
Content-Disposition: inline
In-Reply-To: <20210215143146.9770-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3] Allow running a default
 configuration with TLS libraries without BF-CBC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--gr1qnwuxagNDSOsy
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Feb 15, 2021 at 03:31:46PM +0100, Arne Schwabe wrote:
> Modern TLS libraries might drop Blowfish by default or distributions
> might disable Blowfish in OpenSSL/mbed TLS. We still signal OCC
> options with BF-CBC compatible strings. To avoid requiring BF-CBC
> for this, special this one usage of BF-CBC enough to avoid a hard
> requirement on Blowfish in the default configuration.
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
>=20
> Patch v2: add more clarifying comment, do not warn about OCC only insecure
>           ciphers, code improvements
>=20
> Patch V3: Put ciphername resolution via ciper_kt_name in the right branch

This still fails one of my test cases - but only one (v2 failed two).

The test case is "udp / p2mp tun, 2.4 server with --ncp-disable" (on
the server).

The client is called as=20
   ... --dev tun --proto udp --data-ciphers AES-256-GCM:AES-128-GCM:BF-CBC

(no --cipher setting) and logS

2021-02-16 20:04:51 --cipher is not set. Previous OpenVPN version defaulted=
 to BF-CBC as fallback when cipher negotiation failed in this case. If you =
need this fallback please add '--data-ciphers-fallback BF-CBC' to your conf=
iguration and/or add BF-CBC to --data-ciphers.
...
2021-02-16 20:04:53 PUSH: Received control message: 'PUSH_REPLY,route 10.19=
4.0.0255.255.0.0,route-ipv6 fd00:abcd:194::/48,tun-ipv6,route 10.194.103.1,=
topology net30,ping 10,ping-restart 30,ifconfig-ipv6 fd00:abcd:194:103::100=
0/64 fd00:abcd:194:103::1,ifconfig 10.194.103.6 10.194.103.5,peer-id 0'
2021-02-16 20:04:53 Using peer cipher 'BF-CBC'

but something seems to get confused about things:

2021-02-16 20:04:53 Initialization Sequence Completed
2021-02-16 20:05:03 Bad LZO decompression header byte: 166


The server agrees on BF-CBC (same log, different time zone):

Feb 16 14:04:51 phillip tun-udp-p2mp-2.4-noncp[29923]: 2001:608:0:814::f000=
:11 peer info: IV_CIPHERS=3DAES-256-GCM:AES-128-GCM:BF-CBC
Feb 16 14:04:51 phillip tun-udp-p2mp-2.4-noncp[29923]: 2001:608:0:814::f000=
:11 Outgoing Data Channel: Cipher 'BF-CBC' initialized with 128 bit key
Feb 16 14:04:51 phillip tun-udp-p2mp-2.4-noncp[29923]: 2001:608:0:814::f000=
:11 Incoming Data Channel: Cipher 'BF-CBC' initialized with 128 bit key

but packets fail decryption:

Feb 16 14:04:53 phillip tun-udp-p2mp-2.4-noncp[29923]: cron2-gentoo.ov-amd6=
4/2001:608:0:814::f000:11 Authenticate/Decrypt packet error: packet HMAC au=
thentication failed
Feb 16 14:05:06 phillip syslogd: last message repeated 103 times


Noticeable fact in the client log: there is no "Data Channel: Cipher..."
line on the client, so maybe this is triggering a new corner case?


Notice 2: there is a test case talking to a 2.3 server *which succeeds*,
but that one has "--cipher BF-CBC".  So what fails seems to be "cipher
initialization for 'implicit BF-CBC'".

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--gr1qnwuxagNDSOsy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgLB2+AAoJEB2Cnv7KVigSdAYL/3dvydb9bMgfFiSTSTBa5oCP
mLu09Md5WGUZ6TnbSM5dtNfRDeBJg4K+TWqHeWVWaD+MDH/qIvBpMHTktEJJSJe8
QF0eLdOR0b4leaGXSHMCSIzS0Ryz6gITxM0XxV863H/I6qGDZxqfgjg5Ynv7XBVc
q8j+ZNXNGFNH5n4YjmN6znBbBNCnHdn8aQNpu9exkTPUkw137hoNuFzIf0FhNMsm
CUFHO4xAFBwVvPea9Ok9K2y+ltfJrSAe/qrifPIxJP+jVhhJgihQNbaSsU3VRpPd
HurQs84A+hooJMTC5nQamNfA+YxPNYT6W5L9Nb7rqv9bUzih8Im4QsHoOjFgVDgE
lPyTClEakz5AIWCRGUMdjs07ZvURI3pngz6AdzsuMtA7m0LnaRDUqIIKGXQIPEWj
vtJ2uNhUeE4J+01t2mAnlLk8nif+KUmlG9jpwwCp/WfucFFG6nguhDr4mguSc6CI
flaYYbxifGre5xQuqYDF4SeXnSIrirfPLAZcMdgWIQ==
=mTTc
-----END PGP SIGNATURE-----

--gr1qnwuxagNDSOsy--

