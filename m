Date: Thu, 13 May 2021 21:48:52 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <AAoNQJ8hje_YpG-e2TN2X_-zH6YoLvPujzpWicW_D13NeAysfWRNi89BMQDr-vld9FGAI7cbafIiFgYVYlnql_dE3kCWKQevVHV7tP1dTQ0=@protonmail.com>
In-Reply-To: <20210512131511.1309914-10-arne@...1227...>
References: <20210512131511.1309914-1-arne@...1227...>
 <20210512131511.1309914-10-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_VpbRFwHkXjx3LdMU5cggliM7PPzYvMTFndJ3Amd5ClQ"
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

--b1_VpbRFwHkXjx3LdMU5cggliM7PPzYvMTFndJ3Amd5ClQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

I used sed to create my own reply ..

comments inline.


=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Wednesday, 12 May 2021 14:15, Arne Schwabe <arne@...1227...> wrote:


> This is meant to give new users a quickstart for a useable OpenVPN
> setup. Our own documentation is lacking in this regard and many often
> tutorials that can be found online are often questionable in some
> aspects.
>
> Linking the invidiaul RST file on github also give a tutorial

invidiaul -> individual


> in a nicely formatted way.
>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  Changes.rst                              |   4 +
>  doc/Makefile.am                          |   1 +
>  doc/man-sections/example-fingerprint.rst | 194 +++++++++++++++++++++++
>  3 files changed, 199 insertions(+)
>  create mode 100644 doc/man-sections/example-fingerprint.rst
>
> diff --git a/Changes.rst b/Changes.rst
> index 9185b55f7..f1c739f99 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -25,6 +25,10 @@ Certificate pinning/verify peer fingerprint
>      fingerprint of the peer. The option takes use a number of allowed
>      SHA256 certificate fingerprints.
>
> +    See the man page section "Small OpenVPN setup with peer-fingerprint"
> +    for a tutorial how to use this feature. This is also available online

tutorial how -> tutorial on how (just reads better)


> +    under https://github.com/openvpn/openvpn/blob/master/doc/man-section=
s/example-fingerprint.rst
> +
>  TLS mode with self-signed certificates
>      When ``--peer-fingerprint`` is used, the ``--ca`` and ``--capath`` o=
ption
>      become optional. This allows for small OpenVPN setups without settin=
g up
> diff --git a/doc/Makefile.am b/doc/Makefile.am
> index e411f5f9d..e7022c085 100644
> --- a/doc/Makefile.am
> +++ b/doc/Makefile.am
> @@ -25,6 +25,7 @@ dist_noinst_DATA =3D \
>  	man-sections/connection-profiles.rst \
>  	man-sections/encryption-options.rst \
>  	man-sections/examples.rst \
> +	man-sections/examples.rst \
>  	man-sections/generic-options.rst \
>  	man-sections/inline-files.rst \
>  	man-sections/link-options.rst \
> diff --git a/doc/man-sections/example-fingerprint.rst b/doc/man-sections/=
example-fingerprint.rst
> new file mode 100644
> index 000000000..7d915aedb
> --- /dev/null
> +++ b/doc/man-sections/example-fingerprint.rst
> @@ -0,0 +1,194 @@
> +Small OpenVPN setup with peer-fingerprint
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +This section consists of instructions how to build a small OpenVPN setup=
 with the
> +:code:`peer-fingerprint` option.

Reword suggestion:

 This setup has the advantage to be easy to setup
> +and should for most small lab and home setups without the need to setup =
a PKI.

Using Peer-fingerprint mode has the advantage of being easy to setup withou=
t the need for a PKI.
It is suitable for most small lab and home setups.


> +For bigger scale setup setting up a PKI (e.g. via easy-rsa) is still rec=
ommended.
> +
> +Both server and client configuration can of course be further modified t=
o individualise the
> +setup.

individualise ? - This word is odd .. how about customise ?


> +
> +Server setup
> +------------
> +1. Install openvpn
> +
> +   Compile from source-code (see `INSTALL` file) or install via a distri=
bution (apt/yum/ports)
> +   or via installer (Windows).
> +
> +2. Generate a self-signed certificate for the server:
> +   ::
> +
> +    openssl req -x509 -newkey ec:<(openssl ecparam -name secp384r1) -key=
out serverkey.pem -out server.pem -nodes -sha256 -days 3650 -subj '/CN=3Dse=
rver'

Why not using .key and .crt as is the custom when files are created by Easy=
-RSA ?
Also, it is simpler to understand what the file type is ..


> +
> +3. Generate SHA256 fingerprint of the server certificate
> +
> +   Use the OpenSSL command line utility to view the fingerprint of just
> +   created certificate:
> +   ::
> +
> +    openssl x509 -fingerprint -sha256 -in styx-win.pem -noout server.pem

Why stix-win .. would it not be more suitable to use consistent names of fi=
les ?

Also, this command is incorrect, the server.pem causes openssl error:
x509: Unknown parameter server.pem


> +
> +   This output something similar to:
> +   ::
> +
> +     SHA256 Fingerprint=3D00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:f=
f:00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff
> +
> +
> +3. Write a server configuration (`server.conf`):
> +::
> +
> +    # The server certificate we created in step 1
> +    cert server.pem
> +    key serverkey.pem
> +
> +    dh none
> +    dev tun
> +
> +    # Listen on IPv6+IPv4 simultaneously
> +    proto udp6

I just want this to be verified because the manual reads that:
udp6 will force only udp on IPv6, at least that is how I read it.


> +
> +    # The ip address the server will distribute
> +    server 192.168.234.0 255.255.255.0
> +    server-ipv6 fd00:6f76:706e::/64
> +
> +    # A tun-mtu of 1400 avoids problems of too big packets after VPN enc=
apsulation
> +    tun-mtu 1400
> +
> +    # The fingerprints of your clients. After adding/remvoing one here r=
estart the

remvoing -> removing


> +    # server
> +    <peer-fingerprint>
> +    </peer-fingerprint>
> +
> +    # Notify clients when you restart the server to reconnect quickly
> +    explicit-exit-notify 1
> +
> +    # Ping every 60s, restart if no data received for 5 minutes
> +    keepalive 60 300

I presume you are all sure that this is suitable for consumer grade routers.


> +
> +4. Add at least one client as described in the client section.
> +
> +5. Start the server.
> +    - On systemd based distributions move `server.pem`, `serverkey.pem` =
and
> +      `server.conf` to :code:`/etc/openvpn/server` and start it via syst=
emctl
> +
> +      ::
> +
> +          sudo mv server.conf server.pem /etc/openvpn

destination folder should be /etc/openvpn/server and serverkey.pem is missi=
ng.


> +
> +          sudo systemctl start openvpn-server@...185...
> +
> +Adding a client
> +---------------
> +1. Install OpenVPN
> +
> +2. Generate a self-signed certificate for the client. In this example th=
e client
> +   name is alice. Each client should have a unique name. Replace alice w=
ith a
> +   different name for each client.
> +   ::
> +
> +      openssl req -x509 -newkey ec:<(openssl ecparam -name secp384r1) -n=
odes -sha256 -days 3650 -subj '/CN=3Dalice'
> +
> +   This generate a certificate and a key for the client. The output of t=
he command will look
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

I presume here that the idea is to not save any client key/cert files
and then inline them manually from the output ? It might make sense to
add a comment to that effect.


> +
> +3. Create a new client configuration file. In this example we will name =
the file
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
> +      # This the fingerprint of the server that we trust. We generated t=
his fingerprint

This *is* the fingerprint of the ...


> +      # in step 2 of the server setup
> +      peer-fingerprint 00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff:0=
0:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff
> +
> +      # The tun-mtu of the client should match the server MTU
> +      tun-mtu 1400
> +      dev tun
> +
> +
> +4. Generate the fingerprint of the client certificate. For that we will
> +   let OpenSSL read the client configuration file as the x509 command wi=
ll
> +   ignore anything that is not between the begin and end markers of the =
certificate:
> +
> +   ::
> +
> +      openssl x509 -fingerprint -sha256 -noout -in ./focal-server-locked=
.ovpn

Another new file name ? And this is a server file not a client file .. conf=
using.


> +
> +   This will again output something like
> +   ::
> +
> +        SHA256 Fingerprint=3Dff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33:22:1=
1:00:ff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33:22:11:00
> +
> +5. Edit the `server.conf` configuration file and add this new client
> +   fingerprint as additional line  between :code:`<peer-fingerprint>`
> +   and :code:`</peer-fingerprint>`
> +
> +   After adding *two* clients the part of configuration would look like =
this:
> +
> +   ::
> +
> +      <peer-fingerprint>
> +      ff:ee:dd:cc:bb:aa:99:88:77:66:55:44:33:22:11:00:ff:ee:dd:cc:bb:aa:=
99:88:77:66:55:44:33:22:11:00
> +      99:88:77:66:55:44:33:22:11:00:ff:ee:dd:cc:bb:aa:99:88:77:66:55:44:=
33:22:11:00:88:77:66:55:44:33
> +      </peer-fingperint>
> +
> +6. (optional) if the client is an older client that does not support the
> +   :code:`peer-fingerprint` (OpenVPN 2.5 and older, OpenVPN Connect 3.3
> +   and older), the config can be modified to still work with those.
> +
> +   Remove the line starting with :code:`peer-fingerprint` line. Then

Second 'line' is superfluous.


> +   add a new :code:`<ca>` section at the end of the configuration file
> +   with the contents of the :code:`server.pem` created in step 2 of the
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
> +      [contents of the server.pem]
> +      </ca>
> +
> +   Note that we put the :code:`<ca>` section after the :code:`<cert>` se=
ction
> +   to make the fingerprint generation from step 4 still work since it wi=
ll
> +   only use the first certificate its find.

its find -> it finds (move the s)


> +
> +7. Import the file into the OpenVPN client or just use the
> +   :code:`openvpn alice.ovpn` to start the VPN.
> --
> 2.31.1
>
>
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJgnZ7BACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ06Qwf+KUQVSE5cElO0CD+IfIWRzSCXEeb6pjUXPi29iHn2ZEhwU60N
SrDKGxB7SFEGG6RZsEN39Hky9yArMQneSbktQ8lr5P2+QuBdki3wySWvqabo
6hakuOAXUCeCgj5I2X3BHv9Bz33toXD5JVyVwrrZ+bO5dBNE/Jtzycaa3HCg
Hx2wY02RVIG6SHUAOJJv3LuRIt6pXvRO1BHXcrSy93tlBE1CHeZ+XGVjdj5W
0R2VXrRToQQdJ3AjI4YkKgIaze9KSXNgfwE9IBB5gmYf4Nk3Gkej1OKSgVKs
vwOZ0jwXIou0JiN8UHmVJEz4s/WfOwH2Zl2Hb6zmZmujOL5W8kI0Kg=3D=3D
=3DRSkh
-----END PGP SIGNATURE-----

--b1_VpbRFwHkXjx3LdMU5cggliM7PPzYvMTFndJ3Amd5ClQ
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

--b1_VpbRFwHkXjx3LdMU5cggliM7PPzYvMTFndJ3Amd5ClQ
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

sOkDgryUUOkY3rf89/CwWpBEOQgPBySGiJuRhv2HSEQC8RTMrF3hrvbQ0l8jcSHnNuBzfDBZAewP
FQ==

--b1_VpbRFwHkXjx3LdMU5cggliM7PPzYvMTFndJ3Amd5ClQ--


