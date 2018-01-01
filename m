References: <CAFHpkQHuJmbYk2G58-VdexeUbrrYT1Qz+HdrZ9HZps3QuZD6ZA@...278...>
 <2764e29d-928d-a643-6fa7-0554ff7b7dfa@...2080...>
 <CAFHpkQEcyz9q=kYx6CM_kT9Jm3YFG9EZRe08NZnLm-G+knDktA@...278...>
 <e6c5f73e-2920-3e30-2539-702632d30e43@...2080...>
 <CAFHpkQHPpkb2GfsV4y7B3GntpoQ0JzZz2X+rWffYqexbiJzgYg@...278...>
 <9561c64d-3c54-b65b-9fce-f99b4ef9c3b3@...2080...>
 <CAFHpkQHZXbMDBPXV=dGWYs0M2B4C9AU-FY4KE2pCZqsxe5iJbw@...278...>
 <7bc9701e-b5dd-f9cb-7edf-76e38e36f6a2@...2080...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <b09d8b3c-b8ff-1d33-06eb-fa152c168a88@...1856...>
Date: Mon, 1 Jan 2018 13:30:01 +0100
MIME-Version: 1.0
In-Reply-To: <7bc9701e-b5dd-f9cb-7edf-76e38e36f6a2@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4A4kUjqKRPgmnEL2PwKpgwc9TcRbJiJWe"
Subject: Re: [Openvpn-devel] better handling of revoked certs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4A4kUjqKRPgmnEL2PwKpgwc9TcRbJiJWe
Content-Type: multipart/mixed; boundary="W4bQCgDB50XthlEQioOLbpHtmPC27acGf";
 protected-headers="v1"
From: Steffan Karger <steffan@...1856...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <b09d8b3c-b8ff-1d33-06eb-fa152c168a88@...1856...>
Subject: Re: [Openvpn-devel] better handling of revoked certs
References: <CAFHpkQHuJmbYk2G58-VdexeUbrrYT1Qz+HdrZ9HZps3QuZD6ZA@...278...>
 <2764e29d-928d-a643-6fa7-0554ff7b7dfa@...2080...>
 <CAFHpkQEcyz9q=kYx6CM_kT9Jm3YFG9EZRe08NZnLm-G+knDktA@...278...>
 <e6c5f73e-2920-3e30-2539-702632d30e43@...2080...>
 <CAFHpkQHPpkb2GfsV4y7B3GntpoQ0JzZz2X+rWffYqexbiJzgYg@...278...>
 <9561c64d-3c54-b65b-9fce-f99b4ef9c3b3@...2080...>
 <CAFHpkQHZXbMDBPXV=dGWYs0M2B4C9AU-FY4KE2pCZqsxe5iJbw@...278...>
 <7bc9701e-b5dd-f9cb-7edf-76e38e36f6a2@...2080...>
In-Reply-To: <7bc9701e-b5dd-f9cb-7edf-76e38e36f6a2@...2080...>

--W4bQCgDB50XthlEQioOLbpHtmPC27acGf
Content-Type: multipart/mixed;
 boundary="------------2A78D5A0707185BB8B9D7D35"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------2A78D5A0707185BB8B9D7D35
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This mail thread has been sitting marked-for-follow-up in my mailbox for
a while.  Finally found some time to test and jot down my thoughts, see
below.

On 06-10-17 13:23, David Sommerseth wrote:
> On 06/10/17 11:52, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> [...snip...]
>>     >
>>     >=C2=A0 =C2=A0 =C2=A0In addition, what happens when you try to use a=
 revoked *client*
>>     >=C2=A0 =C2=A0 =C2=A0certificate when connecting to an HTTPS server =
demanding client
>>     >=C2=A0 =C2=A0 =C2=A0certificates to be present?
>>     >
>>     >
>>     > 403
>>     >
>>     > (with customizable error message)
>>     Really?=C2=A0 That shouldn't be possible, as you don't have an estab=
lished
>>     TLS connection to provide the HTTP 403 response.=C2=A0 Because the s=
erver
>>     should reject the connection as the *client* certificate is invalid.
>>
>> I did test on IIS with "certificate required", when you connect without
>> cert, you can see 403.
>> ok, I'll test with revoked cert as well
>=20
> Okay, I've done some testing with my own Nginx server.  HTTPS is
> actually different from the plain SSL/TLS protocol.
>=20
> In HTTPS, the client certificate transfer is handled differently, where
> it exists an unauthenticated TLS connection when invalid certificates
> are sent to the server.  This allows the server to respond with HTTP 40*
> messages over HTTPS.
>=20
> When trying the same using openssl s_client and s_server, the server
> side instantly dumps a "certificate verify failed" message and it
> disconnects.
>=20
> This latter behaviour is the approach implemented in OpenVPN.  And I
> doubt this can easily be changed, to have an unauthenticated response
> channel, without breaking backwards compatibility with older clients.
> We need to facilitate a few other approaches which ensures the clients
> won't get confused.
>=20
> Since both these HTTPS and the s_client/s_server tests happens over TCP
> (as SSL/TLS is strictly designed for TCP only; which is why OpenVPN
> encapsulates the SSL/TLS packets to allow it to use UDP), the client
> will also disconnect when the TCP socket gets closed.  This is not
> possible with UDP sockets, and is why why have --explicit-exit-notify
> for UDP connections, to simulate the TCP FIN behaviour.

What you see here is the result of "TLS Alert" messages, that a peer
sends when there are errors such as cert expired, revoked, invalid, etc.
 So why doesn't OpenVPN send these alerts?  Because we (1) immediately
kill a connection on errors and (2) also manage the 'ciphertext' side of
the TLS connection.

Point (2) might need some more explanation:  TLS libraries are often
used as a layer between the application and the TCP socket.  Because
OpenVPN must also be able to run over UDP, we don't let the library
manage the external socket, but ask the library to return the cipher
text to us and we take care of sending out the cipher text.  Now,
because we immediately tear down a connection when an error occurs, we
never send the TLS alerts (that are deliverd to us as 'TLS ciphertext')
to the peer.

That behaviour is non-standard, but it has protected us against for
example a Bleichenbacher padding oracle attack that did affect TLS
implementations that do send alerts [0].

With that in mind, I think this boils down to a choice to what we
believe makes OpenVPN a better product:  better resilience to potential
TLS attacks, or a better user experience.  I'm usually an advocate of
the former, but in this case the latter is a rather big improvement.  So
I can definitely see the scale tipping that way.

For discussion only, I hacked together a patch that makes OpenVPN send
out the alerts before killing the connection (attached).  It's rather
ugly (and can probably be implemented much more elegant), but it gets
the job done.  An OpenSSL client connecting with a revoked certificate
would then result in a message connection log like this:

$ ./openvpn-openssl --config loopback-client --key
sample-keys/client-revoked.key --cert sample-keys/client-revoked.crt
Mon Jan  1 13:19:27 2018 OpenVPN 2.5_git
[git:openssl-1.1-tls-version/f880ad611a16c0cf+] x86_64-pc-linux-gnu [SSL
(OpenSSL)] [LZO] [LZ4] [EPOLL] [PKCS11] [MH/PKTINFO] [AEAD] built on Jan
 1 2018
Mon Jan  1 13:19:27 2018 library versions: OpenSSL 1.0.1v-dev  xx XXX
xxxx, LZO 2.08
Mon Jan  1 13:19:27 2018 TLS: Initial packet from
[AF_INET]127.0.0.1:1194, sid=3Dc4269920 b6f4bcf1
Mon Jan  1 13:19:27 2018 VERIFY OK: depth=3D1, C=3DKG, ST=3DNA, L=3DBISHKEK,
O=3DOpenVPN-TEST, emailAddress=3Dme@...430...
Mon Jan  1 13:19:27 2018 VERIFY KU OK
Mon Jan  1 13:19:27 2018 Validating certificate extended key usage
Mon Jan  1 13:19:27 2018 ++ Certificate has EKU (str) TLS Web Server
Authentication, expects TLS Web Server Authentication
Mon Jan  1 13:19:27 2018 VERIFY EKU OK
Mon Jan  1 13:19:27 2018 VERIFY OK: depth=3D0, C=3DKG, ST=3DNA,
O=3DOpenVPN-TEST, CN=3DTest-Server, emailAddress=3Dme@...430...
Mon Jan  1 13:19:27 2018 OpenSSL: error:14094415:SSL
routines:SSL3_READ_BYTES:sslv3 alert certificate expired
Mon Jan  1 13:19:27 2018 OpenSSL: error:140940E5:SSL
routines:SSL3_READ_BYTES:ssl handshake failure
Mon Jan  1 13:19:27 2018 TLS_ERROR: BIO read tls_read_plaintext error
Mon Jan  1 13:19:27 2018 TLS Error: TLS object -> incoming plaintext
read error
Mon Jan  1 13:19:27 2018 TLS: Handshake failed
Mon Jan  1 13:19:27 2018 TLS Error: TLS handshake failed
Mon Jan  1 13:19:27 2018 Closing TUN/TAP interface
Mon Jan  1 13:19:27 2018 SIGUSR1[soft,tls-error] received, process
restarting
Mon Jan  1 13:19:27 2018 Restart pause, 5 second(s)
Mon Jan  1 13:19:32 2018 UDP link local (bound): [AF_INET]127.0.0.1:16050
Mon Jan  1 13:19:32 2018 UDP link remote: [AF_INET]127.0.0.1:1194
Mon Jan  1 13:19:32 2018 TLS: Initial packet from
[AF_INET]127.0.0.1:1194, sid=3D49dd46a3 911f97cc
Mon Jan  1 13:19:33 2018 VERIFY OK: depth=3D1, C=3DKG, ST=3DNA, L=3DBISHKEK,
O=3DOpenVPN-TEST, emailAddress=3Dme@...430...
Mon Jan  1 13:19:33 2018 VERIFY KU OK
Mon Jan  1 13:19:33 2018 Validating certificate extended key usage
Mon Jan  1 13:19:33 2018 ++ Certificate has EKU (str) TLS Web Server
Authentication, expects TLS Web Server Authentication
Mon Jan  1 13:19:33 2018 VERIFY EKU OK
Mon Jan  1 13:19:33 2018 VERIFY OK: depth=3D0, C=3DKG, ST=3DNA,
O=3DOpenVPN-TEST, CN=3DTest-Server, emailAddress=3Dme@...430...
Mon Jan  1 13:19:33 2018 OpenSSL: error:14094415:SSL
routines:SSL3_READ_BYTES:sslv3 alert certificate expired
Mon Jan  1 13:19:33 2018 OpenSSL: error:140940E5:SSL
routines:SSL3_READ_BYTES:ssl handshake failure
Mon Jan  1 13:19:33 2018 TLS_ERROR: BIO read tls_read_plaintext error
Mon Jan  1 13:19:33 2018 TLS Error: TLS object -> incoming plaintext
read error
Mon Jan  1 13:19:33 2018 TLS: Handshake failed
Mon Jan  1 13:19:33 2018 TLS Error: TLS handshake failed
Mon Jan  1 13:19:33 2018 Closing TUN/TAP interface
Mon Jan  1 13:19:33 2018 SIGUSR1[soft,tls-error] received, process
restarting
Mon Jan  1 13:19:33 2018 Restart pause, 5 second(s)

.. etc.

(The useful error message is a bit hidden in the all the other error,
but we can make that stand out better if we want.)

Note the '5 seconds' reconnect loop, which is the same as what current
released openvpn would do in response to an alert.  So if we change our
servers to send alerts, they will experience quite a bit more load from
clients attempting to reconnect.  We can make newer clients use some
exponential back-off, but older clients will be around for quite a while.

And that's where this braindump ends.  I'm not sure what I believe would
be best, but at least I've shared my considerations with you :)

-Steffan

[0]
https://www.usenix.org/system/files/conference/usenixsecurity14/sec14-paper=
-meyer.pdf

--------------2A78D5A0707185BB8B9D7D35
Content-Type: text/x-patch;
 name="0001-XXX-hacky-way-to-send-TLS-alerts.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0001-XXX-hacky-way-to-send-TLS-alerts.patch"

=46rom f880ad611a16c0cfc2cffa2d12c71cd9199729dc Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan@...1856...>
Date: Mon, 1 Jan 2018 12:52:26 +0100
Subject: [PATCH] XXX hacky way to send TLS alerts

Only for discussion - not ready for production!
---
 src/openvpn/ssl.c        | 21 +++++++++++++++++----
 src/openvpn/ssl_common.h |  1 +
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index a849b348..940bf876 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2933,7 +2933,13 @@ tls_process(struct tls_multi *multi,
             if (status =3D=3D -1)
             {
                 msg(D_TLS_ERRORS, "TLS Error: TLS object -> incoming pla=
intext read error");
-                goto error;
+                if (ks->state =3D=3D S_HANDSHAKE_FAIL)
+                {
+                    /* Allow one iteration to send alert, error out next=
 time */
+                    goto error;
+                }
+                ks->state =3D S_HANDSHAKE_FAIL;
+                state_change =3D true;
             }
             if (status =3D=3D 1)
             {
@@ -3020,7 +3026,7 @@ tls_process(struct tls_multi *multi,
         }
=20
         /* Outgoing Ciphertext to reliable buffer */
-        if (ks->state >=3D S_START)
+        if (ks->state >=3D S_START || ks->state =3D=3D S_HANDSHAKE_FAIL)=

         {
             buf =3D reliable_get_buf_output_sequenced(ks->send_reliable)=
;
             if (buf)
@@ -3039,6 +3045,12 @@ tls_process(struct tls_multi *multi,
                     state_change =3D true;
                     dmsg(D_TLS_DEBUG, "Outgoing Ciphertext -> Reliable")=
;
                 }
+                if (status =3D=3D 0 && ks->state =3D=3D S_HANDSHAKE_FAIL=
)
+                {
+                    /* No alerts to send, kill connection */
+                    msg(D_TLS_ERRORS, "TLS: Handshake failed");
+                    goto error;
+                }
             }
         }
     }
@@ -3060,7 +3072,7 @@ tls_process(struct tls_multi *multi,
=20
     /* When should we wake up again? */
     {
-        if (ks->state >=3D S_INITIAL)
+        if (ks->state >=3D S_INITIAL || ks->state =3D=3D S_HANDSHAKE_FAI=
L)
         {
             compute_earliest_wakeup(wakeup,
                                     reliable_send_timeout(ks->send_relia=
ble));
@@ -3152,7 +3164,8 @@ tls_multi_process(struct tls_multi *multi,
              session_id_print(&ks->session_id_remote, &gc),
              print_link_socket_actual(&ks->remote_addr, &gc));
=20
-        if (ks->state >=3D S_INITIAL && link_socket_actual_defined(&ks->=
remote_addr))
+        if ((ks->state >=3D S_INITIAL || ks->state =3D=3D S_HANDSHAKE_FA=
IL)
+            && link_socket_actual_defined(&ks->remote_addr))
         {
             struct link_socket_actual *tla =3D NULL;
=20
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 60ed5f8a..c72c7bc4 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -74,6 +74,7 @@
  *
  * @{
  */
+#define S_HANDSHAKE_FAIL -2
 #define S_ERROR          -1     /**< Error state.  */
 #define S_UNDEF           0     /**< Undefined state, used after a \c
                                  *   key_state is cleaned up. */
--=20
2.14.1


--------------2A78D5A0707185BB8B9D7D35--

--W4bQCgDB50XthlEQioOLbpHtmPC27acGf--

--4A4kUjqKRPgmnEL2PwKpgwc9TcRbJiJWe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEvBAEBCAAZBQJaSinOEhxzdGVmZmFuQGthcmdlci5tZQAKCRCYAso9AH7SiHLD
CAC8bGghoSxY++LaKvMuCRzvEVM5r6HIFZ5qJUuUNn4zMD23voh13tt4CYV2FD98
ILfmMLBItbE6z28Feh4nTC/gTjYpgTcCjRfFbU6ckCicl4JCsyLsQ8YxDQnVJur+
5Za4JGwsPDfWwkMOBv0MqNCe0OKrdTjQKlX9EYLK2rYj5/l0fi8FHiRAjmq4jTSo
5YCaVwpn/vP7huuw2cEPel7HyhTTdVp2/26gOmtmwLVQ77zLrtgACNybbplcbVrB
kM/nhUh7dUlvHq4plOMFnCee/KiLzVrl+vE/79Cz878W9qIh9t3bZYRK3w41F5fT
m/xwLnEku/x/zl+mwLqt3fE6
=ijYe
-----END PGP SIGNATURE-----

--4A4kUjqKRPgmnEL2PwKpgwc9TcRbJiJWe--

