Date: Thu, 13 May 2021 21:03:04 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <Af9mbZdk1TrCJQc_we59MKqqDKZZ38A6gmfSaJ4LwB9ZBHJU_P39UhOV3Oy1fNY4TBR2LCqORl0uO53f2tycZ6JwZp1Pm7UQ0dbgJY1ZmR4=@protonmail.com>
In-Reply-To: <20210512131511.1309914-10-arne@...1227...>
References: <20210512131511.1309914-1-arne@...1227...>
 <20210512131511.1309914-10-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_joLBKuSgkRSKaJIch519PdPqI2I1zCXXTv0EvVP8"
Subject: Re: [Openvpn-devel] [PATCH 9/9] Add detailed man page section to
 setup a OpenVPN setup with peer-fingerprint
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

--b1_joLBKuSgkRSKaJIch519PdPqI2I1zCXXTv0EvVP8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

I was in the process of reviewing this patch when I found that protonmail
had changed most of the git '+' to '-', see below.

I have reported a bug to protonmail.

Anyway, I can see a few typos and some other odd errors.
Hopefully, protonmail will have a solution, or maybe someone here knows
what I can do/try ?

Finally, I wrote a simple script which generates self-signed certs, keys
and inlines the fingerprint for use with Openvpn.

https://github.com/TinCanTech/easy-pfp

I hope it is of some use in the future.

Thanks
R




=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Wednesday, 12 May 2021 14:15, Arne Schwabe <arne@...1227...> wrote:

> This is meant to give new users a quickstart for a useable OpenVPN
> setup. Our own documentation is lacking in this regard and many often
> tutorials that can be found online are often questionable in some
> aspects.
>
> Linking the invidiaul RST file on github also give a tutorial
> in a nicely formatted way.
>
> Signed-off-by: Arne Schwabe arne@...1227...
>
> Changes.rst | 4 +
> doc/Makefile.am | 1 +
> doc/man-sections/example-fingerprint.rst | 194 +++++++++++++++++++++++
> 3 files changed, 199 insertions(+)
> create mode 100644 doc/man-sections/example-fingerprint.rst
>
> diff --git a/Changes.rst b/Changes.rst
> index 9185b55f7..f1c739f99 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -25,6 +25,10 @@ Certificate pinning/verify peer fingerprint
> fingerprint of the peer. The option takes use a number of allowed
> SHA256 certificate fingerprints.
>
> -   See the man page section "Small OpenVPN setup with peer-fingerprint"
> -   for a tutorial how to use this feature. This is also available online
> -   under https://github.com/openvpn/openvpn/blob/master/doc/man-sections=
/example-fingerprint.rst
> -
>
> TLS mode with self-signed certificates
> When `--peer-fingerprint` is used, the `--ca` and `--capath` option
> become optional. This allows for small OpenVPN setups without setting up
> diff --git a/doc/Makefile.am b/doc/Makefile.am
> index e411f5f9d..e7022c085 100644
> --- a/doc/Makefile.am
> +++ b/doc/Makefile.am
> @@ -25,6 +25,7 @@ dist_noinst_DATA =3D \
> man-sections/connection-profiles.rst \
> man-sections/encryption-options.rst \
> man-sections/examples.rst \
>
> -   man-sections/examples.rst \
>     man-sections/generic-options.rst \
>     man-sections/inline-files.rst \
>     man-sections/link-options.rst \
>     diff --git a/doc/man-sections/example-fingerprint.rst b/doc/man-secti=
ons/example-fingerprint.rst
>     new file mode 100644
>     index 000000000..7d915aedb
>     --- /dev/null
>     +++ b/doc/man-sections/example-fingerprint.rst
>     @@ -0,0 +1,194 @@
>     +Small OpenVPN setup with peer-fingerprint
>     +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     +This section consists of instructions how to build a small OpenVPN s=
etup with the
>     +:code:`peer-fingerprint` option. This setup has the advantage to be =
easy to setup
>     +and should for most small lab and home setups without the need to se=
tup a PKI.
>     +For bigger scale setup setting up a PKI (e.g. via easy-rsa) is still=
 recommended.
>
> -
>
> +Both server and client configuration can of course be further modified t=
o individualise the
> +setup.
> +
> +Server setup
> +------------
> +1. Install openvpn
> +
>
> -   Compile from source-code (see `INSTALL` file) or install via a distri=
bution (apt/yum/ports)
> -   or via installer (Windows).
> -
>
> +2. Generate a self-signed certificate for the server:
>
> -   ::
> -
> -   openssl req -x509 -newkey ec:<(openssl ecparam -name secp384r1) -keyo=
ut serverkey.pem -out server.pem -nodes -sha256 -days 3650 -subj '/CN=3Dser=
ver'
> -
>
> +3. Generate SHA256 fingerprint of the server certificate
> +
>
> -   Use the OpenSSL command line utility to view the fingerprint of just
> -   created certificate:
> -   ::
> -
> -   openssl x509 -fingerprint -sha256 -in styx-win.pem -noout server.pem
> -
> -   This output something similar to:
> -   ::
> -
> -       SHA256 Fingerprint=3D00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee=
:ff:00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff
>
>
> -
> -
>
> +3. Write a server configuration (`server.conf`):
> +::
> +
>
> -   The server certificate we created in step 1
>
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -   cert server.pem
>
> -   key serverkey.pem
>
> -
> -   dh none
>
> -   dev tun
>
> -
> -   Listen on IPv6+IPv4 simultaneously
>
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -   proto udp6
>
> -
> -   The ip address the server will distribute
>
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -   server 192.168.234.0 255.255.255.0
>
> -   server-ipv6 fd00:6f76:706e::/64
>
> -
> -   A tun-mtu of 1400 avoids problems of too big packets after VPN encaps=
ulation
>
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
> -   tun-mtu 1400
>
> -
> -   The fingerprints of your clients. After adding/remvoing one here rest=
art the
>
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
> -   server
>
>     =3D=3D=3D=3D=3D=3D=3D
>
> -   <peer-fingerprint>
>
> -   </peer-fingerprint>
>
> -
> -   Notify clients when you restart the server to reconnect quickly
>
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -   explicit-exit-notify 1
>
> -
> -   Ping every 60s, restart if no data received for 5 minutes
>
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -   keepalive 60 300
>
> -
>
> +4. Add at least one client as described in the client section.
> +
> +5. Start the server.
>
> -   -   On systemd based distributions move `server.pem`, `serverkey.pem`=
 and
> -        `server.conf` to :code:`/etc/openvpn/server` and start it via sy=
stemctl
>
>
> -
> -        ::
>
>
> -
> -            sudo mv server.conf server.pem /etc/openvpn
>
>
> -
> -            sudo systemctl start openvpn-server@...185...
>
>
> -
>
> +Adding a client
> +---------------
> +1. Install OpenVPN
> +
> +2. Generate a self-signed certificate for the client. In this example th=
e client
>
> -   name is alice. Each client should have a unique name. Replace alice w=
ith a
> -   different name for each client.
> -   ::
> -
> -        openssl req -x509 -newkey ec:<(openssl ecparam -name secp384r1) =
-nodes -sha256 -days 3650 -subj '/CN=3Dalice'
>
>
> -
> -   This generate a certificate and a key for the client. The output of t=
he command will look
> -   something like this:
> -   ::
> -
> -        -----BEGIN PRIVATE KEY-----
>
>
> -        [base64 content]
>
>
> -        -----END PRIVATE KEY-----
>
>
> -        -----
>
>
> -        -----BEGIN CERTIFICATE-----
>
>
> -        [base 64 content]
>
>
> -        -----END CERTIFICATE-----
>
>
> -
>
> +3. Create a new client configuration file. In this example we will name =
the file
>
> -   `alice.ovpn`:
>
> -
> -   ::
>
> -
> -        # The name of your server to connect to
>
>
> -        remote yourserver.example.net
>
>
> -        client
>
>
> -        # use a random source port instead the fixed 1194
>
>
> -        nobind
>
>
> -
> -        # Uncomment the following line if you want to route
>
>
> -        # all traffic via the VPN
>
>
> -        # redirect-gateway def1 ipv6
>
>
> -
> -        # To set a a DNS server
>
>
> -        # dhcp-option DNS 192.168.234.1
>
>
> -
> -        <key>
>
>
> -        -----BEGIN PRIVATE KEY-----
>
>
> -        [Insert here the key created in step 2]
>
>
> -        -----END PRIVATE KEY-----
>
>
> -        </key>
>
>
> -        <cert>
>
>
> -        -----BEGIN CERTIFICATE-----
>
>
> -        [Insert here the certificate created in step 2]
>
>
> -        -----END CERTIFICATE-----
>
>
> -        </cert>
>
>
> -
> -        # This the fingerprint of the server that we trust. We generated=
 this fingerprint
>
>
> -        # in step 2 of the server setup
>
>
> -        peer-fingerprint 00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff=
:00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff
>
>
> -
> -        # The tun-mtu of the client should match the server MTU
>
>
> -        tun-mtu 1400
>
>
> -        dev tun
>
>
> -
> -
>
> +4. Generate the fingerprint of the client certificate. For that we will
>
> -   let OpenSSL read the client configuration file as the x509 command wi=
ll
> -   ignore anything that is not between the begin and end markers of the =
certificate:
> -
> -   ::
> -
> -        openssl x509 -fingerprint -sha256 -noout -in ./focal-server-lock=
ed.ovpn
>
>
> -
> -   This will again output something like
> -   ::
> -
> -          SHA256 Fingerprint=3Dff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33:22=
:11:00:ff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33:22:11:00
>
>
> -
>
> +5. Edit the `server.conf` configuration file and add this new client
>
> -   fingerprint as additional line between :code:`<peer-fingerprint>`
>
> -   and :code:`</peer-fingerprint>`
>
> -
> -   After adding two clients the part of configuration would look like th=
is:
>
> -
> -   ::
>
> -
> -        <peer-fingerprint>
>
>
> -        ff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33:22:11:00:ff:ee:dd:cc:bb:a=
a:99:88:77:66:55:44:33:22:11:00
>
>
> -        99:88:77:66:55:44:33:22:11:00:ff:ee:dd:cc:bb:aa:99:88:77:66:55:4=
4:33:22:11:00:88:77:66:55:44:33
>
>
> -        </peer-fingperint>
>
>
> -
>
> +6. (optional) if the client is an older client that does not support the
>
> -   :code:`peer-fingerprint` (OpenVPN 2.5 and older, OpenVPN Connect 3.3
>
> -   and older), the config can be modified to still work with those.
>
> -
> -   Remove the line starting with :code:`peer-fingerprint` line. Then
>
> -   add a new :code:`<ca>` section at the end of the configuration file
>
> -   with the contents of the :code:`server.pem` created in step 2 of the
>
> -   server setup. The end of `alice.ovpn` file should like:
>
> -
> -   ::
>
> -
> -        [...]  # Beginning of the file skipped
>
>
> -        </cert>
>
>
> -
> -        # The tun-mtu of the client should match the server MTU
>
>
> -        tun-mtu 1400
>
>
> -        dev tun
>
>
> -
> -        <ca>
>
>
> -        [contents of the server.pem]
>
>
> -        </ca>
>
>
> -
> -   Note that we put the :code:`<ca>` section after the :code:`<cert>` se=
ction
>
> -   to make the fingerprint generation from step 4 still work since it wi=
ll
>
> -   only use the first certificate its find.
>
> -
>
> +7. Import the file into the OpenVPN client or just use the
>
> -   :code:`openvpn alice.ovpn` to start the VPN.
>     --
>     2.31.1
>
>
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJgnZQBACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ28dwgAuy7fuhyoasafHKdlfo1PENgbpA8jS+oX0+FAW0CmbZV/4cvn
7hA46fBg2ys7y1xjTLgWGDJXQx6lqSH3RJSuaCMQ4Lfu5uFQK/8FjB9nz1zu
Pe4M0mTRbenC1RdHTipH2u6wi4S3L7vV35mcCmhLmXiXNcAstJ/Ta5PfLP5u
55voFJNxicyVgCPHzTgMdY3hZWC5/s3/j5TNiuJOsS1Tge+31+7X6YfyFrJR
r2TtTD9TKZ5xuSpDZQl9iQAtzcGiaUYpYgDo/iVlkLEW8F4Uosqe698BmcI4
JuS++8adaxKJvDkbiwnqJDsK06SCHER9TIZLP51VKhRq0noiEg/laA=3D=3D
=3DG2yu
-----END PGP SIGNATURE-----

--b1_joLBKuSgkRSKaJIch519PdPqI2I1zCXXTv0EvVP8
Content-Type: application/pgp-keys; name="publickey - tincantech@...2282... - 0x09BC3D44.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tDQpWZXJzaW9uOiBPcGVuUEdQLmpz
IHY0LjEwLjgNCkNvbW1lbnQ6IGh0dHBzOi8vb3BlbnBncGpzLm9yZw0KDQp4c0JOQkZ2d1NjY0JD
QURPbUhFblFsTG1PakpSdEpMMmw1M01Md3dGVHk3WG5FcHMzYjFRMFV3V1lGQ3YNCkwyb05wMG5y
ZEdsS0tESnE1MFkwOVNSK1VSWUJRbUttWTNFbXpweVVJS00vcmdvMVJ5dWJIcE1SSGJEcA0KN0pw
OEx4a2ZmRkJWSmovdDVWTXBENmVNUjZhVWNpUWpnUkw4TlplNitUN3hmWFhYd1Y1aG9SZVozak8r
DQp6SGk2U1I3eFR2R1hsYStNUXo2RUVwV25sYkx2ZzJvcnQ5S3NldVZqWXJxdlJNeGNkUDBvOWNa
V0o1ZXANCkpObWdlQjZNNytPVzA4VTFTc1h0S3JwTFJjSTZ5S21WMzhqaHpQcjJaZ1A5cm1ybEVy
Ui8xaXFRUUhYWQ0KbzgvMERmUHlGMG1IOXluUUlpTEUvbCtGWXU0cnNHOFZpS2x4aFhjemVQekF0
TENqaUIwYTBtUlZBQkVCDQpBQUhOTnlKMGFXNWpZVzUwWldOb1FIQnliM1J2Ym0xaGFXd3VZMjl0
SWlBOGRHbHVZMkZ1ZEdWamFFQncNCmNtOTBiMjV0WVdsc0xtTnZiVDdDd0g4RUVBRUlBQ2tGQWx2
d1NjY0dDd2tIQ0FNQ0NSQlBsNXoyYTVDNA0KblFRVkNBb0NBeFlDQVFJWkFRSWJBd0llQVFBS0NS
QlBsNXoyYTVDNG5RQkRCLzlaVW85Qk9YSlI2MU5tDQowMm9aLzhhUlhPOU5uVVNGdDZHTE9XY0RO
dkFzNElKV01EVkVRZllhbmIrNDIxUU5kLzVkNkgxaVhGK2kNCjRMREswTTZhZ0MrZ3NORkpualBH
SXR2UHRqN1d5anluWlJ4OEQ0MFBQWGlnZkhZdXcyb1J1MGxyK1AxcA0KMXFlVWU0TmJjcUl2OElJ
dkx6MnpDbFlaT05nQXNRVmNOQUhpN1o0b3J0UTJpbzJCQVZqLzgxOUpQWU10DQp0SGdZODF3UzFW
N3Y4R0RUWmc4b2FQaFhHZmFDNFRaRkd0WnIvYnliY3Fyc28zNWphUW1DNTR4TWJYcEYNCkFVcmMz
dUdWT0grT2RHL0JXMmdjWXFwdlVGQnVrWHhDVUJZSFAyTmZYaE5mekd0OW5DMXVsTktZZVAxOQ0K
VEdsT29yQk1ZSUFFSG9HeHZwYlVYZmJhTldDVXpzQk5CRnZ3U2NjQkNBQzlLeVZaUlM1YU1hRzVQ
aTBuDQpmeDhhTm9zM2JZcDI0Nk10ZmFvS0JmVFFBcmQrR1pXK1duRnlKRWlTeUxkejByVXV0eUNB
ZGY1bGdWSCsNCld2THZJbWlHclNyelZwTVQybkNTMDlMcUw1MFFqejhBN2dwNUgvaFF6dFo4aU55
c0dEOU5PNDZPbkk3NQ0KOTBkSGZDclhqUVBTRnRGR3NUemdEeFFJaU11eno5RFI3QmVrS1BtdU9G
SWhCZTllRVpxYnhjOFJXZVF0DQpoYTdpL0RySlRSTksxYU9BRFFGVnVWMS9BbTVUaEdQV0ZNL1lK
VXlUWWhNVzB5ZVBoNDVPYld1UlFaa3MNCmwrYU9tNEwwS0dERFlsbS9GUXgvRU1DdWJ2bHp5L3p4
RGRCNm5xRmloMnFacmZ5bW5pU09LYWpHMGpvVA0KcFpvei9Feis0ZkF0ZzZ5MFBzcE5SNmlkQUJF
QkFBSEN3R2tFR0FFSUFCTUZBbHZ3U2NjSkVFK1huUFpyDQprTGlkQWhzTUFBb0pFRStYblBacmtM
aWRSZTBIL2o1Q0lGSUF1Y3VhaUVNa0xrTktFQU81czd4NDdlTnkNCkdQZlpzbHlZK0hqekdVMGQw
N01ra0dtVmtQVFZ6d3FWek5aYm55N1pBdjF6bFcwVXkweUhwMUFQcHlZdA0KOGJ1VXBwVEJxN2Q0
N29neEVSWXp0L0xjMkw1YS9WS0ZOUmJoTjEvWFFtUGl6MkVsZTR0eWlwYlRhcGN5DQoremJ5ZnpB
TUQxM2NJZFoxM2hUc05QMG9sZ0JoQXFVQVVVWXB4UmxrQUhlSitEdDNOYnpIUzRLUUs1MzgNCk5K
L2w3YlhTS3NHcW9ZcUplWjhWTkJ4d1dXVWJ1RzRqanJoNDNNSVJnVVo1V3NQVVlWNkh4MDU2a01q
Yg0KL2JZQmpJMFRFTXZIODE2MHVxekZYZUh2WXlVbHEwU2luRC9aOWlvSWU4UWRzSEdCRFVJUllZ
dWIxcE84DQpxckN6Ulp4MG9OQT0NCj0vRGVhDQotLS0tLUVORCBQR1AgUFVCTElDIEtFWSBCTE9D
Sy0tLS0tDQo=

--b1_joLBKuSgkRSKaJIch519PdPqI2I1zCXXTv0EvVP8
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

sOkDgryUUOkpnIF4nUwfRDa29BlwnF6nm5QMFSCU45i8ml49Dio3yqnf7jxTc2xycnyrZx7xWA==

--b1_joLBKuSgkRSKaJIch519PdPqI2I1zCXXTv0EvVP8--


