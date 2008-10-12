From: "Dave" <dev@...575...>
Date: Sun, 12 Oct 2008 09:24:48 -0500
Message-ID: <7C342B9ABF73436EAE299A297BF7437D@...576...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0006_01C92C4C.5FB90F30"
In-Reply-To: <9e0cf0bf0810112307p73010087r512098cb3d7092b8@...278...>
Subject: Re: [Openvpn-devel] [MSCAPI] Need testers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: 'Alon Bar-Lev' <alon.barlev@...277...>
Cc: 'Peter 'Luna' Runestig' <peter@...292...>, 'openvpn devel' <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

------=_NextPart_000_0006_01C92C4C.5FB90F30
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I would consider [1] as verified, at least partially.  I did not try any
negative tests outside of the absence of the cert/key does not enable login,
also I did not try in the 'service' scenario, which I imagine just means
'put the cert in the machine's store'.

attached herewith is my log, and also my config file for reference.  the
error is on line 18.  I can re-run and bump up the verb, as 3 is probably
too low for you?

I would also like to test revocation, both by explicitly untrusting a cert,
and by having a crl.  When I import a CRL using the default 'choose a sane
place' option, it goes under

Intermediate Certification Authorities
  Certificate Revocation List

which strikes me as odd since this is not an intermediate CA, and because
the CA cert went under the 'Trusted Root CA' as expected, and not the
'Intermediate CA'.  Such, I suppose, are the mysteries of capi.

It would be great if the 'CRL distribution point' and 'Authority Info
Access' 'OCSP' certificate extensions were used, but that's another
projectlette in itself, no?....

-Dave

> -----Original Message-----
> From: Alon Bar-Lev [mailto:alon.barlev@...277...]=20
> Sent: Sunday, October 12, 2008 1:07 AM
> To: Dave
> Cc: openvpn devel; Peter 'Luna' Runestig
> Subject: Re: [Openvpn-devel] [MSCAPI] Need testers
>=20
>=20
> Thank you dave!
>=20
> Let's divide this into two threads.
>=20
> 1. I've cleanup the OpenSSL integration, this should not=20
> change existing behavior... All you need to verify that=20
> OpenVPN continue to work while using private key from CAPI store.
>=20
> 2. Add the CAPI certificate validation.
>=20
> From what I understand, (1) works at your side?
>=20
> For the VERIFY ERROR, can you please paste some more log=20
> lines? Should be something like "Failed to verify certificate..."
>=20
> Thanks!
> Alon.
>=20
> On 10/12/08, Dave <dev@...575...> wrote:
> > ...
> >
> > > ...
> >  > > As part of modification of the mscapi (cryptoapi.c)=20
> file, I  > >=20
> > try to cleanup the openssl usage. I don't have Windows  > >=20
> > environment to test.  > >
> >  > > I will be glad if users of this feature help me testing this.
> >
> > ...
> >
> > > ...
> >  > Sure, I could do it now but what are the test cases we=20
> are  > going=20
> > to run? This is for the cryptoapicert feature? -Dave  >
> >
> >
> > OK, I'm not getting it.  Educate me.  I am using an existing and=20
> > functional  server, and removed all the ca cert and key=20
> options in my=20
> > config and  replaced them with:
> >
> >   cryptoapica
> >   cryptoapicert "SUBJ:plexus"
> >
> >  Nevermind the second one -- I verified it works fine in isolation=20
> > (i.e.  meaning having ca or <ca> makes it work finding the cert and=20
> > key via capi).  That was mostly a 'using capi to do=20
> something at all'=20
> > sanity check.
> >
> >  I imported my CA cert.  I used the 'pick a sensible place'=20
> option.  I=20=20
> > verified that it is located (according to the MMC snapin) at:
> >
> >  Certificates - Current User
> >   Trusted Root Certification Authorities
> >     Certificates
> >
> >  which does seem a sensible place.
> >
> >  Upon connect, I am getting the error:
> >
> >  Sat Oct 11 22:25:16 2008 VERIFY ERROR: depth=3D1, error=3Dself signed=
=20=20
> > certificate in certificate chain:=20=20
> >=20
> /C=3DUS/ST=3DTX/L=3DCedar_Park/O=3Dziggurat29/CN=3Dziggurat29_CA/emailAdd=
ress=3Dde
> > v@...1136...
> >  urat29.com
> >
> >  Not sure what to say about that -- root CA certs are always=20
> > self-signed, no?
> >
> >  For fun I also imported the server cert.  It wound up at:
> >
> >  Certificates - Current User
> >   Other People
> >     Certificates
> >
> >  Didn't do any good there -- no surprise -- but I moved it=20
> over to the=20=20
> > trusted root CA and it did no good there either.
> >
> >  I'll be happy to give configs, logs, certs if it's useful.
> >
> >
> >  -Dave
> >
> >
>=20

------=_NextPart_000_0006_01C92C4C.5FB90F30
Content-Type: application/octet-stream;
	name="WRT54GL cryptoapica.ovpn"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="WRT54GL cryptoapica.ovpn"

dev tap
port 443
proto tcp
socket-flags TCP_NODELAY

remote 192.168.173.2

;log "e:\\Program Files\\OpenVPN\\log\\WRT54GL.log"
verb 3

client

comp-lzo

resolv-retry infinite
persist-key
persist-tun

mute-replay-warnings

#the following will override and interfere with openvpngui, which uses
#this method to terminate connections.
#service exit_my_app


#crypto stuff==============================================


<tls-auth>
#
# 2048 bit OpenVPN static key
#
-----BEGIN OpenVPN Static key V1-----
### PRIVATE DATA REMOVED ###
-----END OpenVPN Static key V1-----
</tls-auth>
key-direction 1


cryptoapica
cryptoapicert "SUBJ:plexus"


#<ca>
#-----BEGIN CERTIFICATE-----
#MIIDUzCCArygAwIBAgIBADANBgkqhkiG9w0BAQQFADB/MQswCQYDVQQGEwJVUzEL
#MAkGA1UECBMCVFgxEzARBgNVBAcTCkNlZGFyIFBhcmsxEzARBgNVBAoTCnppZ2d1
#cmF0MjkxFjAUBgNVBAMTDXppZ2d1cmF0MjkgQ0ExITAfBgkqhkiG9w0BCQEWEmRl
#dkB6aWdndXJhdDI5LmNvbTAeFw0wNjAzMTIxOTIxNTFaFw0xNjAzMDkxOTIxNTFa
#MH8xCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJUWDETMBEGA1UEBxMKQ2VkYXIgUGFy
#azETMBEGA1UEChMKemlnZ3VyYXQyOTEWMBQGA1UEAxMNemlnZ3VyYXQyOSBDQTEh
#MB8GCSqGSIb3DQEJARYSZGV2QHppZ2d1cmF0MjkuY29tMIGfMA0GCSqGSIb3DQEB
#AQUAA4GNADCBiQKBgQDPDzUAq3kAK1u2izipzIft+PdPcqFW7N5ZwAQcb3kAtIfW
#MCCSJATCW0/kLcLL9FuPdcv7FXQUS9yxm4UmRQGgdVKPKxlYbUDB11yyX76dNcoW
#TRUxXgMJ4HI914UKojTELVnKJP4fhJfqpVMhT/Lquf9b4MJvaZgDkEUXRkMkrwID
#AQABo4HeMIHbMB0GA1UdDgQWBBQDLg4QMU1/x4SZ5w00UxazclYAlzCBqwYDVR0j
#BIGjMIGggBQDLg4QMU1/x4SZ5w00UxazclYAl6GBhKSBgTB/MQswCQYDVQQGEwJV
#UzELMAkGA1UECBMCVFgxEzARBgNVBAcTCkNlZGFyIFBhcmsxEzARBgNVBAoTCnpp
#Z2d1cmF0MjkxFjAUBgNVBAMTDXppZ2d1cmF0MjkgQ0ExITAfBgkqhkiG9w0BCQEW
#EmRldkB6aWdndXJhdDI5LmNvbYIBADAMBgNVHRMEBTADAQH/MA0GCSqGSIb3DQEB
#BAUAA4GBAG5PesaaPvdPzxzPyczrLlvsQ6XT3nxcyFo91QcKvEmd8rkQWpwYR4pd
#3bsaZTS+k8XpeVaBsDzkrhxHhxX80qAxepabu4ZK1FVdlSdIuEqoXZmSFo/wwzDb
#2OEjg1ElMoJ58jWv8c7FE9325sdj1npbqaelGBszcaVlB318qxQo
#-----END CERTIFICATE-----
#</ca>

------=_NextPart_000_0006_01C92C4C.5FB90F30
Content-Type: application/octet-stream;
	name="WRT54GL cryptoapica.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="WRT54GL cryptoapica.log"

Sat Oct 11 23:24:40 2008 OpenVPN 2.1_rc12a i686-pc-mingw32 [SSL] [LZO2] =
[PKCS11] built on Oct  7 2008
Sat Oct 11 23:24:40 2008 WARNING: No server certificate verification =
method has been enabled.  See http://openvpn.net/howto.html#mitm for =
more info.
Sat Oct 11 23:24:40 2008 Control Channel Authentication: tls-auth using =
INLINE static key file
Sat Oct 11 23:24:40 2008 Outgoing Control Channel Authentication: Using =
160 bit message hash 'SHA1' for HMAC authentication
Sat Oct 11 23:24:40 2008 Incoming Control Channel Authentication: Using =
160 bit message hash 'SHA1' for HMAC authentication
Sat Oct 11 23:24:40 2008 LZO compression initialized
Sat Oct 11 23:24:40 2008 Control Channel MTU parms [ L:1576 D:168 EF:68 =
EB:0 ET:0 EL:0 ]
Sat Oct 11 23:24:40 2008 Data Channel MTU parms [ L:1576 D:1450 EF:44 =
EB:135 ET:32 EL:0 AF:3/1 ]
Sat Oct 11 23:24:40 2008 Local Options hash (VER=3DV4): 'e39a3273'
Sat Oct 11 23:24:40 2008 Expected Remote Options hash (VER=3DV4): =
'3c14feac'
Sat Oct 11 23:24:40 2008 Attempting to establish TCP connection with =
192.168.173.2:443
Sat Oct 11 23:24:40 2008 TCP connection established with =
192.168.173.2:443
Sat Oct 11 23:24:40 2008 Socket Buffers: R=3D[8192->8192] =
S=3D[8192->8192]
Sat Oct 11 23:24:40 2008 Socket flags: TCP_NODELAY=3D1 succeeded
Sat Oct 11 23:24:40 2008 TCPv4_CLIENT link local: [undef]
Sat Oct 11 23:24:40 2008 TCPv4_CLIENT link remote: 192.168.173.2:443
Sat Oct 11 23:24:40 2008 TLS: Initial packet from 192.168.173.2:443, =
sid=3Da7389c72 ae66006d
Sat Oct 11 23:24:41 2008 VERIFY ERROR: depth=3D1, error=3Dself signed =
certificate in certificate chain: =
/C=3DUS/ST=3DTX/L=3DCedar_Park/O=3Dziggurat29/CN=3Dziggurat29_CA/emailAdd=
ress=3Ddev@...575...
Sat Oct 11 23:24:41 2008 TLS_ERROR: BIO read tls_read_plaintext error: =
error:14090086:SSL routines:SSL3_GET_SERVER_CERTIFICATE:certificate =
verify failed
Sat Oct 11 23:24:41 2008 TLS Error: TLS object -> incoming plaintext =
read error
Sat Oct 11 23:24:41 2008 TLS Error: TLS handshake failed
Sat Oct 11 23:24:41 2008 Fatal TLS error (check_tls_errors_co), =
restarting
Sat Oct 11 23:24:41 2008 TCP/UDP: Closing socket
Sat Oct 11 23:24:41 2008 SIGUSR1[soft,tls-error] received, process =
restarting
Sat Oct 11 23:24:41 2008 Restart pause, 5 second(s)
Sat Oct 11 23:24:46 2008 WARNING: No server certificate verification =
method has been enabled.  See http://openvpn.net/howto.html#mitm for =
more info.
Sat Oct 11 23:24:46 2008 Re-using SSL/TLS context
Sat Oct 11 23:24:46 2008 LZO compression initialized
Sat Oct 11 23:24:46 2008 Control Channel MTU parms [ L:1576 D:168 EF:68 =
EB:0 ET:0 EL:0 ]
Sat Oct 11 23:24:46 2008 Data Channel MTU parms [ L:1576 D:1450 EF:44 =
EB:135 ET:32 EL:0 AF:3/1 ]
Sat Oct 11 23:24:46 2008 Local Options hash (VER=3DV4): 'e39a3273'
Sat Oct 11 23:24:46 2008 Expected Remote Options hash (VER=3DV4): =
'3c14feac'
Sat Oct 11 23:24:46 2008 Attempting to establish TCP connection with =
192.168.173.2:443
Sat Oct 11 23:24:46 2008 TCP connection established with =
192.168.173.2:443
Sat Oct 11 23:24:46 2008 Socket Buffers: R=3D[8192->8192] =
S=3D[8192->8192]
Sat Oct 11 23:24:46 2008 Socket flags: TCP_NODELAY=3D1 succeeded
Sat Oct 11 23:24:46 2008 TCPv4_CLIENT link local: [undef]
Sat Oct 11 23:24:46 2008 TCPv4_CLIENT link remote: 192.168.173.2:443
Sat Oct 11 23:24:46 2008 TLS: Initial packet from 192.168.173.2:443, =
sid=3D776c7bf6 82d25433
Sat Oct 11 23:24:46 2008 VERIFY ERROR: depth=3D1, error=3Dself signed =
certificate in certificate chain: =
/C=3DUS/ST=3DTX/L=3DCedar_Park/O=3Dziggurat29/CN=3Dziggurat29_CA/emailAdd=
ress=3Ddev@...575...
Sat Oct 11 23:24:46 2008 TLS_ERROR: BIO read tls_read_plaintext error: =
error:14090086:SSL routines:SSL3_GET_SERVER_CERTIFICATE:certificate =
verify failed
Sat Oct 11 23:24:46 2008 TLS Error: TLS object -> incoming plaintext =
read error
Sat Oct 11 23:24:46 2008 TLS Error: TLS handshake failed
Sat Oct 11 23:24:46 2008 Fatal TLS error (check_tls_errors_co), =
restarting
Sat Oct 11 23:24:46 2008 TCP/UDP: Closing socket
Sat Oct 11 23:24:46 2008 SIGUSR1[soft,tls-error] received, process =
restarting
Sat Oct 11 23:24:46 2008 Restart pause, 5 second(s)
Sat Oct 11 23:24:51 2008 WARNING: No server certificate verification =
method has been enabled.  See http://openvpn.net/howto.html#mitm for =
more info.
Sat Oct 11 23:24:51 2008 Re-using SSL/TLS context
Sat Oct 11 23:24:51 2008 LZO compression initialized
Sat Oct 11 23:24:51 2008 Control Channel MTU parms [ L:1576 D:168 EF:68 =
EB:0 ET:0 EL:0 ]
Sat Oct 11 23:24:51 2008 Data Channel MTU parms [ L:1576 D:1450 EF:44 =
EB:135 ET:32 EL:0 AF:3/1 ]
Sat Oct 11 23:24:51 2008 Local Options hash (VER=3DV4): 'e39a3273'
Sat Oct 11 23:24:51 2008 Expected Remote Options hash (VER=3DV4): =
'3c14feac'
Sat Oct 11 23:24:51 2008 Attempting to establish TCP connection with =
192.168.173.2:443
Sat Oct 11 23:24:51 2008 TCP connection established with =
192.168.173.2:443
Sat Oct 11 23:24:51 2008 Socket Buffers: R=3D[8192->8192] =
S=3D[8192->8192]
Sat Oct 11 23:24:51 2008 Socket flags: TCP_NODELAY=3D1 succeeded
Sat Oct 11 23:24:51 2008 TCPv4_CLIENT link local: [undef]
Sat Oct 11 23:24:51 2008 TCPv4_CLIENT link remote: 192.168.173.2:443
Sat Oct 11 23:24:51 2008 TLS: Initial packet from 192.168.173.2:443, =
sid=3Da8c788a3 6b62b4e6
Sat Oct 11 23:24:52 2008 VERIFY ERROR: depth=3D1, error=3Dself signed =
certificate in certificate chain: =
/C=3DUS/ST=3DTX/L=3DCedar_Park/O=3Dziggurat29/CN=3Dziggurat29_CA/emailAdd=
ress=3Ddev@...575...
Sat Oct 11 23:24:52 2008 TLS_ERROR: BIO read tls_read_plaintext error: =
error:14090086:SSL routines:SSL3_GET_SERVER_CERTIFICATE:certificate =
verify failed
Sat Oct 11 23:24:52 2008 TLS Error: TLS object -> incoming plaintext =
read error
Sat Oct 11 23:24:52 2008 TLS Error: TLS handshake failed
Sat Oct 11 23:24:52 2008 Fatal TLS error (check_tls_errors_co), =
restarting
Sat Oct 11 23:24:52 2008 TCP/UDP: Closing socket
Sat Oct 11 23:24:52 2008 SIGUSR1[soft,tls-error] received, process =
restarting
Sat Oct 11 23:24:52 2008 Restart pause, 5 second(s)
Sat Oct 11 23:24:57 2008 WARNING: No server certificate verification =
method has been enabled.  See http://openvpn.net/howto.html#mitm for =
more info.
Sat Oct 11 23:24:57 2008 Re-using SSL/TLS context
Sat Oct 11 23:24:57 2008 LZO compression initialized
Sat Oct 11 23:24:57 2008 Control Channel MTU parms [ L:1576 D:168 EF:68 =
EB:0 ET:0 EL:0 ]
Sat Oct 11 23:24:57 2008 Data Channel MTU parms [ L:1576 D:1450 EF:44 =
EB:135 ET:32 EL:0 AF:3/1 ]
Sat Oct 11 23:24:57 2008 Local Options hash (VER=3DV4): 'e39a3273'
Sat Oct 11 23:24:57 2008 Expected Remote Options hash (VER=3DV4): =
'3c14feac'
Sat Oct 11 23:24:57 2008 Attempting to establish TCP connection with =
192.168.173.2:443
Sat Oct 11 23:24:57 2008 TCP connection established with =
192.168.173.2:443
Sat Oct 11 23:24:57 2008 Socket Buffers: R=3D[8192->8192] =
S=3D[8192->8192]
Sat Oct 11 23:24:57 2008 Socket flags: TCP_NODELAY=3D1 succeeded
Sat Oct 11 23:24:57 2008 TCPv4_CLIENT link local: [undef]
Sat Oct 11 23:24:57 2008 TCPv4_CLIENT link remote: 192.168.173.2:443
Sat Oct 11 23:24:57 2008 TLS: Initial packet from 192.168.173.2:443, =
sid=3D53c9e2fe 7d79d9ca
Sat Oct 11 23:24:57 2008 VERIFY ERROR: depth=3D1, error=3Dself signed =
certificate in certificate chain: =
/C=3DUS/ST=3DTX/L=3DCedar_Park/O=3Dziggurat29/CN=3Dziggurat29_CA/emailAdd=
ress=3Ddev@...575...
Sat Oct 11 23:24:57 2008 TLS_ERROR: BIO read tls_read_plaintext error: =
error:14090086:SSL routines:SSL3_GET_SERVER_CERTIFICATE:certificate =
verify failed
Sat Oct 11 23:24:57 2008 TLS Error: TLS object -> incoming plaintext =
read error
Sat Oct 11 23:24:57 2008 TLS Error: TLS handshake failed
Sat Oct 11 23:24:57 2008 Fatal TLS error (check_tls_errors_co), =
restarting
Sat Oct 11 23:24:57 2008 TCP/UDP: Closing socket
Sat Oct 11 23:24:57 2008 SIGUSR1[soft,tls-error] received, process =
restarting
Sat Oct 11 23:24:57 2008 Restart pause, 5 second(s)
Sat Oct 11 23:25:02 2008 WARNING: No server certificate verification =
method has been enabled.  See http://openvpn.net/howto.html#mitm for =
more info.
Sat Oct 11 23:25:02 2008 Re-using SSL/TLS context
Sat Oct 11 23:25:02 2008 LZO compression initialized
Sat Oct 11 23:25:02 2008 Control Channel MTU parms [ L:1576 D:168 EF:68 =
EB:0 ET:0 EL:0 ]
Sat Oct 11 23:25:02 2008 Data Channel MTU parms [ L:1576 D:1450 EF:44 =
EB:135 ET:32 EL:0 AF:3/1 ]
Sat Oct 11 23:25:02 2008 Local Options hash (VER=3DV4): 'e39a3273'
Sat Oct 11 23:25:02 2008 Expected Remote Options hash (VER=3DV4): =
'3c14feac'
Sat Oct 11 23:25:02 2008 Attempting to establish TCP connection with =
192.168.173.2:443
Sat Oct 11 23:25:02 2008 TCP/UDP: Closing socket
Sat Oct 11 23:25:02 2008 SIGTERM[hard,init_instance] received, process =
exiting

------=_NextPart_000_0006_01C92C4C.5FB90F30--


