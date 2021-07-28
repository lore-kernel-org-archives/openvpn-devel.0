Date: Wed, 28 Jul 2021 20:00:52 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <qT_Ps0kzbTp5bt8XWqYeRmR9aflqFqqzgv4kZA0EvmbxcKYx6_ufh-pvZIbiF2YPWv2ii4ECS0-DhOElyl4a5LfQYBSekz3CsO6FGf2CBfg=@protonmail.com>
In-Reply-To: <20210728154922.568796-1-arne@...1227...>
References: <20210520150932.2565217-2-arne@...1227...>
 <20210728154922.568796-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_hQGTfT8OXqqMX2Mz3Xws0wMYLYd9Lh6HI9X95uj1mw"
Subject: Re: [Openvpn-devel] [PATCH v3] Add detailed man page section to
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
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--b1_hQGTfT8OXqqMX2Mz3Xws0wMYLYd9Lh6HI9X95uj1mw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

six minor improvements, could probably be made on commit.

One comment: This tutorial will not work on Windows because it relies
on a bashism to generate the self-signed certs.  There is no mention
of that anywhere, may be it could be pointed out somewhere ?

Other than that, excellent work!

And for the record: Easy-TLS can create these cert/keys and share
fingerprints to relevant inline files with relative ease.
https://github.com/TinCanTech/easy-tls


Sent with ProtonMail Secure (but still git unfriendly) Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

On Wednesday, July 28th, 2021 at 16:49, Arne Schwabe <arne@...1227...> wrot=
e:

> This is meant to give new users a quickstart for a useable OpenVPN

quickstart -> quick start

> setup. Our own documentation is lacking in this regard and many
> tutorials that can be found online are often questionable in some
> aspects.
>
> Linking the individaul RST file on github also give a tutorial

individual (au->ua)

> in a nicely formatted way.
>
> Patch V2: Fix grammar/spelling mistakes (thanks ticantech), move

tincantech

>           to openvpn-examples(5).
>
> Patch v3: use server.key and server.crt instead of server.pem/serverkey.p=
e=3D
> m
>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  Changes.rst                              |   4 +
>  doc/Makefile.am                          |   1 +
>  doc/man-sections/example-fingerprint.rst | 196 +++++++++++++++++++++++
>  doc/openvpn-examples.5.rst               |   1 +
>  4 files changed, 202 insertions(+)
>  create mode 100644 doc/man-sections/example-fingerprint.rst
>
> diff --git a/Changes.rst b/Changes.rst
> index 9185b55f7..5ac24307f 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -25,6 +25,10 @@ Certificate pinning/verify peer fingerprint
>      fingerprint of the peer. The option takes use a number of allowed
>      SHA256 certificate fingerprints.
>
> +    See the man page section "Small OpenVPN setup with peer-fingerprint"
> +    for a tutorial on how to use this feature. This is also available on=
l=3D
> ine
> +    under https://github.com/openvpn/openvpn/blob/master/doc/man-section=
s=3D
> /example-fingerprint.rst
> +
>  TLS mode with self-signed certificates
>      When ``--peer-fingerprint`` is used, the ``--ca`` and ``--capath`` o=
p=3D
> tion
>      become optional. This allows for small OpenVPN setups without settin=
g=3D
>  up
> diff --git a/doc/Makefile.am b/doc/Makefile.am
> index 1e4fcdea3..1a67f7b52 100644
> --- a/doc/Makefile.am
> +++ b/doc/Makefile.am
> @@ -31,6 +31,7 @@ dist_noinst_DATA =3D3D \
>  	man-sections/client-options.rst \
>  	man-sections/connection-profiles.rst \
>  	man-sections/encryption-options.rst \
> +	man-sections/example-fingerprint.rst \
>  	man-sections/examples.rst \
>  	man-sections/generic-options.rst \
>  	man-sections/inline-files.rst \
> diff --git a/doc/man-sections/example-fingerprint.rst b/doc/man-sections/=
e=3D
> xample-fingerprint.rst
> new file mode 100644
> index 000000000..ba948dd07
> --- /dev/null
> +++ b/doc/man-sections/example-fingerprint.rst
> @@ -0,0 +1,196 @@
> +Small OpenVPN setup with peer-fingerprint
> +=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=
=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D
> =3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D=
3D=3D3D
> +This section consists of instructions how to build a small OpenVPN setup=
 =3D
> with the
> +:code:`peer-fingerprint` option. This has the advantage of being easy to=
 =3D
> setup
> +and should be suitable for most small lab and home setups without the ne=
e=3D
> d for a PKI.
> +For bigger scale setup setting up a PKI (e.g. via easy-rsa) is still rec=
o=3D
> mmended.
> +
> +Both server and client configuration can of be further modified to custo=
m=3D

"can of be" -> can be

Also, it could simply read: "can be further customised."

> ise the
> +setup.
> +
> +Server setup
> +------------
> +1. Install openvpn
> +
> +   Compile from source-code (see `INSTALL` file) or install via a distri=
b=3D
> ution (apt/yum/ports)
> +   or via installer (Windows).

The following method does not work in Windows.

> +
> +2. Generate a self-signed certificate for the server:
> +   ::
> +
> +    openssl req -x509 -newkey ec:<(openssl ecparam -name secp384r1) -key=
o=3D
> ut server.key -out server.crt -nodes -sha256 -days 3650 -subj '/CN=3D3Dse=
rve=3D
> r'
> +
> +3. Generate SHA256 fingerprint of the server certificate
> +
> +   Use the OpenSSL command line utility to view the fingerprint of just
> +   created certificate:
> +   ::
> +
> +    openssl x509 -fingerprint -sha256 -in server.crt -noout
> +
> +   This output something similar to:
> +   ::
> +
> +     SHA256 Fingerprint=3D3D00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee=
:ff=3D
> :00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff
> +
> +
> +3. Write a server configuration (`server.conf`):
> +::
> +
> +    # The server certificate we created in step 1
> +    cert server.crt
> +    key server.key
> +
> +    dh none
> +    dev tun
> +
> +    # Listen on IPv6+IPv4 simultaneously
> +    proto udp6
> +
> +    # The ip address the server will distribute
> +    server 10.8.0.0 255.255.255.0
> +    server-ipv6 fd00:6f76:706e::/64
> +
> +    # A tun-mtu of 1400 avoids problems of too big packets after VPN enc=
a=3D
> psulation
> +    tun-mtu 1400
> +
> +    # The fingerprints of your clients. After adding/removing one here r=
e=3D
> start the
> +    # server
> +    <peer-fingerprint>
> +    </peer-fingerprint>
> +
> +    # Notify clients when you restart the server to reconnect quickly
> +    explicit-exit-notify 1
> +
> +    # Ping every 60s, restart if no data received for 5 minutes
> +    keepalive 60 300
> +
> +4. Add at least one client as described in the client section.
> +
> +5. Start the server.
> +    - On systemd based distributions move `server.crt`, `server.key` and
> +      `server.conf` to :code:`/etc/openvpn/server` and start it via syst=
e=3D
> mctl
> +
> +      ::
> +
> +          sudo mv server.conf server.key server.crt /etc/openvpn/server
> +
> +          sudo systemctl start openvpn-server@...185...
> +
> +Adding a client
> +---------------
> +1. Install OpenVPN
> +
> +2. Generate a self-signed certificate for the client. In this example th=
e=3D
>  client
> +   name is alice. Each client should have a unique name. Replace alice w=
i=3D
> th a
> +   different name for each client.
> +   ::
> +
> +      openssl req -x509 -newkey ec:<(openssl ecparam -name secp384r1) -n=
o=3D
> des -sha256 -days 3650 -subj '/CN=3D3Dalice'
> +
> +   This generate a certificate and a key for the client. The output of t=
h=3D
> e command will look
> +   something like this:
> +   ::
> +
> +      -----BEGIN PRIVATE KEY-----
> +      [base64 content]
> +      -----END PRIVATE KEY-----
> +      -----
> +      -----BEGIN CERTIFICATE-----
> +      [base 64 content]
> +      -----END CERTIFICATE-----
> +
> +
> +3. Create a new client configuration file. In this example we will name =
t=3D
> he file
> +   `alice.ovpn`:
> +
> +   ::
> +
> +      # The name of your server to connect to
> +      remote yourserver.example.net
> +      client
> +      # use a random source port instead the fixed 1194
> +      nobind
> +
> +      # Uncomment the following line if you want to route
> +      # all traffic via the VPN
> +      # redirect-gateway def1 ipv6
> +
> +      # To set a a DNS server

a a !

> +      # dhcp-option DNS 192.168.234.1
> +
> +      <key>
> +      -----BEGIN PRIVATE KEY-----
> +      [Insert here the key created in step 2]
> +      -----END PRIVATE KEY-----
> +      </key>
> +      <cert>
> +      -----BEGIN CERTIFICATE-----
> +      [Insert here the certificate created in step 2]
> +      -----END CERTIFICATE-----
> +      </cert>
> +
> +      # This is the fingerprint of the server that we trust. We generate=
d=3D
>  this fingerprint
> +      # in step 2 of the server setup
> +      peer-fingerprint 00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff:0=
0=3D
> :11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff
> +
> +      # The tun-mtu of the client should match the server MTU
> +      tun-mtu 1400
> +      dev tun
> +
> +
> +4. Generate the fingerprint of the client certificate. For that we will
> +   let OpenSSL read the client configuration file as the x509 command wi=
l=3D
> l
> +   ignore anything that is not between the begin and end markers of the =
c=3D
> ertificate:
> +
> +   ::
> +
> +      openssl x509 -fingerprint -sha256 -noout -in alice.ovpn
> +
> +   This will again output something like
> +   ::
> +
> +        SHA256 Fingerprint=3D3Dff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33:22=
:11=3D
> :00:ff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33:22:11:00
> +
> +5. Edit the `server.conf` configuration file and add this new client
> +   fingerprint as additional line  between :code:`<peer-fingerprint>`
> +   and :code:`</peer-fingerprint>`
> +
> +   After adding *two* clients the part of configuration would look like =
t=3D
> his:
> +
> +   ::
> +
> +      <peer-fingerprint>
> +      ff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33:22:11:00:ff:ee:dd:cc:bb:aa:=
9=3D
> 9:88:77:66:55:44:33:22:11:00
> +      99:88:77:66:55:44:33:22:11:00:ff:ee:dd:cc:bb:aa:99:88:77:66:55:44:=
3=3D
> 3:22:11:00:88:77:66:55:44:33
> +      </peer-fingperint>
> +
> +6. (optional) if the client is an older client that does not support the
> +   :code:`peer-fingerprint` (e.g. OpenVPN 2.5 and older, OpenVPN Connect=
 =3D
> 3.3
> +   and older), the client config `alice.ovpn` can be modified to still w=
o=3D
> rk with
> +   these clients.
> +
> +   Remove the line starting with :code:`peer-fingerprint`. Then
> +   add a new :code:`<ca>` section at the end of the configuration file
> +   with the contents of the :code:`server.crt` created in step 2 of the
> +   server setup. The end of `alice.ovpn` file should like:
> +
> +   ::
> +
> +      [...]  # Beginning of the file skipped
> +      </cert>
> +
> +      # The tun-mtu of the client should match the server MTU
> +      tun-mtu 1400
> +      dev tun
> +
> +      <ca>
> +      [contents of the server.crt]
> +      </ca>
> +
> +   Note that we put the :code:`<ca>` section after the :code:`<cert>` se=
c=3D
> tion
> +   to make the fingerprint generation from step 4 still work since it wi=
l=3D
> l
> +   only use the first certificate it find.

'it find' -> found

> +
> +7. Import the file into the OpenVPN client or just use the
> +   :code:`openvpn alice.ovpn` to start the VPN.
> diff --git a/doc/openvpn-examples.5.rst b/doc/openvpn-examples.5.rst
> index 988b6027b..0e1b6c4f6 100644
> --- a/doc/openvpn-examples.5.rst
> +++ b/doc/openvpn-examples.5.rst
> @@ -14,4 +14,5 @@ INTRODUCTION
>
>  This man page gives a few simple examples to create OpenVPN setups and c=
o=3D
> nfiguration files.
>
> +.. include:: man-sections/example-fingerprint.rst
>  .. include:: man-sections/examples.rst
> --
> 2.32.0
>

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJhAbdiACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ3NdQgAscHRyr3wCUuRtnIdbMBWjAfbvfP5iwPiGHyGh1S00PAUDHeJ
RRSjJAIPlDcVhJircaeRzOVe+rPIf6icwdrzOzkE8wnifE570ivq/z8BtT6d
zgC9s2CXKBVRTY5L/UGWlWkk15yaSzFjHS3ZtXGVlTyfQ2SItHbHh6ceeazo
l44PxOt+qJtDqA6FKzj7SfnAVyVBLq1XSpkebnuL/CXJzVdVXsXGCDl1CSwf
srnLPfAoW8dcKrJyUE4meYovCq8Ym+zHZZY70iLfB6kxfz+1Uyase/BkmrAY
b+j9BUOQ+OPFtGABBJB+FBR9dIN44Q6KTbgmXUC0mq1bYK7QfLZMdw=3D=3D
=3D0swD
-----END PGP SIGNATURE-----

--b1_hQGTfT8OXqqMX2Mz3Xws0wMYLYd9Lh6HI9X95uj1mw
Content-Type: application/pgp-keys; name="publickey - tincantech@...2282... - 0x09BC3D44.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tDQpWZXJzaW9uOiBPcGVuUEdQLmpz
IHY0LjEwLjEwDQpDb21tZW50OiBodHRwczovL29wZW5wZ3Bqcy5vcmcNCg0KeHNCTkJGdndTY2NC
Q0FET21IRW5RbExtT2pKUnRKTDJsNTNNTHd3RlR5N1huRXBzM2IxUTBVd1dZRkN2DQpMMm9OcDBu
cmRHbEtLREpxNTBZMDlTUitVUllCUW1LbVkzRW16cHlVSUtNL3JnbzFSeXViSHBNUkhiRHANCjdK
cDhMeGtmZkZCVkpqL3Q1Vk1wRDZlTVI2YVVjaVFqZ1JMOE5aZTYrVDd4ZlhYWHdWNWhvUmVaM2pP
Kw0KekhpNlNSN3hUdkdYbGErTVF6NkVFcFdubGJMdmcyb3J0OUtzZXVWallycXZSTXhjZFAwbzlj
WldKNWVwDQpKTm1nZUI2TTcrT1cwOFUxU3NYdEtycExSY0k2eUttVjM4amh6UHIyWmdQOXJtcmxF
clIvMWlxUVFIWFkNCm84LzBEZlB5RjBtSDl5blFJaUxFL2wrRll1NHJzRzhWaUtseGhYY3plUHpB
dExDamlCMGEwbVJWQUJFQg0KQUFITk55SjBhVzVqWVc1MFpXTm9RSEJ5YjNSdmJtMWhhV3d1WTI5
dElpQThkR2x1WTJGdWRHVmphRUJ3DQpjbTkwYjI1dFlXbHNMbU52YlQ3Q3dIOEVFQUVJQUNrRkFs
dndTY2NHQ3drSENBTUNDUkJQbDV6MmE1QzQNCm5RUVZDQW9DQXhZQ0FRSVpBUUliQXdJZUFRQUtD
UkJQbDV6MmE1QzRuUUJEQi85WlVvOUJPWEpSNjFObQ0KMDJvWi84YVJYTzlOblVTRnQ2R0xPV2NE
TnZBczRJSldNRFZFUWZZYW5iKzQyMVFOZC81ZDZIMWlYRitpDQo0TERLME02YWdDK2dzTkZKbmpQ
R0l0dlB0ajdXeWp5blpSeDhENDBQUFhpZ2ZIWXV3Mm9SdTBscitQMXANCjFxZVVlNE5iY3FJdjhJ
SXZMejJ6Q2xZWk9OZ0FzUVZjTkFIaTdaNG9ydFEyaW8yQkFWai84MTlKUFlNdA0KdEhnWTgxd1Mx
Vjd2OEdEVFpnOG9hUGhYR2ZhQzRUWkZHdFpyL2J5YmNxcnNvMzVqYVFtQzU0eE1iWHBGDQpBVXJj
M3VHVk9IK09kRy9CVzJnY1lxcHZVRkJ1a1h4Q1VCWUhQMk5mWGhOZnpHdDluQzF1bE5LWWVQMTkN
ClRHbE9vckJNWUlBRUhvR3h2cGJVWGZiYU5XQ1V6c0JOQkZ2d1NjY0JDQUM5S3lWWlJTNWFNYUc1
UGkwbg0KZng4YU5vczNiWXAyNDZNdGZhb0tCZlRRQXJkK0daVytXbkZ5SkVpU3lMZHowclV1dHlD
QWRmNWxnVkgrDQpXdkx2SW1pR3JTcnpWcE1UMm5DUzA5THFMNTBRano4QTdncDVIL2hRenRaOGlO
eXNHRDlOTzQ2T25JNzUNCjkwZEhmQ3JYalFQU0Z0RkdzVHpnRHhRSWlNdXp6OURSN0Jla0tQbXVP
RkloQmU5ZUVacWJ4YzhSV2VRdA0KaGE3aS9EckpUUk5LMWFPQURRRlZ1VjEvQW01VGhHUFdGTS9Z
SlV5VFloTVcweWVQaDQ1T2JXdVJRWmtzDQpsK2FPbTRMMEtHRERZbG0vRlF4L0VNQ3Vidmx6eS96
eERkQjZucUZpaDJxWnJmeW1uaVNPS2FqRzBqb1QNCnBab3ovRXorNGZBdGc2eTBQc3BOUjZpZEFC
RUJBQUhDd0drRUdBRUlBQk1GQWx2d1NjY0pFRStYblBacg0Ka0xpZEFoc01BQW9KRUUrWG5QWnJr
TGlkUmUwSC9qNUNJRklBdWN1YWlFTWtMa05LRUFPNXM3eDQ3ZU55DQpHUGZac2x5WStIanpHVTBk
MDdNa2tHbVZrUFRWendxVnpOWmJueTdaQXYxemxXMFV5MHlIcDFBUHB5WXQNCjhidVVwcFRCcTdk
NDdvZ3hFUll6dC9MYzJMNWEvVktGTlJiaE4xL1hRbVBpejJFbGU0dHlpcGJUYXBjeQ0KK3pieWZ6
QU1EMTNjSWRaMTNoVHNOUDBvbGdCaEFxVUFVVVlweFJsa0FIZUorRHQzTmJ6SFM0S1FLNTM4DQpO
Si9sN2JYU0tzR3FvWXFKZVo4Vk5CeHdXV1VidUc0ampyaDQzTUlSZ1VaNVdzUFVZVjZIeDA1NmtN
amINCi9iWUJqSTBURU12SDgxNjB1cXpGWGVIdll5VWxxMFNpbkQvWjlpb0llOFFkc0hHQkRVSVJZ
WXViMXBPOA0KcXJDelJaeDBvTkE9DQo9L0RlYQ0KLS0tLS1FTkQgUEdQIFBVQkxJQyBLRVkgQkxP
Q0stLS0tLQ0K

--b1_hQGTfT8OXqqMX2Mz3Xws0wMYLYd9Lh6HI9X95uj1mw
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

wsBzBAABCAAGBQJhAbdiACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec9muQuJ05CAgAhPlN
he+7fEG5iOo/a6wM4drDdIZwpM/HLBCBY9JhtO/VgUVK5y56LFJCJ3agBqhY9YT87A7Udrh7Cr/K
AHxlzhRj0hOceneJHfGd2DPk09MjTtL9SY7oAOLVa/n/lltNemlaPngLKO2q02W46+ljCXyqS2LE
lwtmN7rvhxSH9LXZqNpvwDx9baKw2A67PGhmAcWxh90Dk5XjRN8Rm/U7IG8jFbGee26Z0Uf+8YtF
3rTlkkqs1XDyivQJWvB6ovpea1joG+5y0zrJJQywDoZ940YrszwRZTueRjRd25A55lbeRSMjQCDj
QZh+CPM/JWqiJaV6EtKJvdXGSd8Bm6REhQ==

--b1_hQGTfT8OXqqMX2Mz3Xws0wMYLYd9Lh6HI9X95uj1mw--


