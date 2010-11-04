From: "Carlos Soto" <carlos.soto@...1413...>
References: <mailman.25039.1288190128.5007.openvpn-devel@lists.sourceforge.net>
In-Reply-To: <mailman.25039.1288190128.5007.openvpn-devel@lists.sourceforge.net>
Date: Thu, 4 Nov 2010 09:32:47 +0100
Message-ID: <000c01cb7bfa$dcad0c80$96072580$@soto@...1413...>
MIME-Version: 1.0
Content-Language: es
Subject: [Openvpn-devel] Problem with client reconnect when using
	username-as-common-name and username is blank
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

I have been having a very strange behavior with openvpn and I have finally
found the source. I do not know if it is a bug or not so I will explain it
and let the experts decide.

I am using OpenVPN 2.1.3 in several openwrt routers connected with ADSL with
dynamic IPs. Every once in a client reconnects (normally because there is a
change in the IP). As I do not use the cn-duplicate, when the client
reconnects, it first calls the client-disconnect script and then the client
connect. See log:

Thu Nov  4 07:55:16 2010 XX.148.40.117:42335 [javier] Peer Connection
Initiated with XX.148.40.117:42335
Thu Nov 04 07:55:16 2010 XX.148.40.117:45483 openvpn_scripts:
(CN=3Djavier/cn=3Djavier) start client-disconnect
Thu Nov  4 07:55:16 2010 javier/XX.148.40.117:42335 TCP/UDP: Closing socket
Thu Nov  4 07:55:16 2010 MULTI: new connection by client 'javier' will cause
previous active sessions by this client to be dropped.  Remember to use the
--duplicate-cn option if you want multiple clients using the same
certificate or username to concurrently connect.
Thu Nov 04 07:55:16 2010 XX.148.40.117:42335 openvpn_scripts:
(CN=3Djavier/cn=3Djavier) start client-connect

openvpn_scripts are the log entries from my custom scripts that setup the
iptables and routes. This is all the expected behavior.

The problem comes when I activate the username-as-common-name option. When
the client reconnects, the client-disconnect script does not get called and
only the client connect script gets called. The username is always blank for
this particular connection and CN. After the reconnection is done, there is
a timeout of the first connection because of the ping-restart option and the
client-disconnect script gets called. Here is the log

Thu Nov  4 08:24:29 2010 XX.148.40.117:39056 TLS: Initial packet from
XX.148.40.117:39056, sid=3D2b306f61 c6c30e51
Thu Nov  4 08:24:33 2010 XX.148.40.117:39056 VERIFY OK: depth=3D1,
/C=3DES/ST=3DMAD/L=3DMadrid/O=3DCS/CN=3DCS_CA/emailAddress=3Dxx@...1383...
Thu Nov  4 08:24:33 2010 XX.148.40.117:39056 VERIFY OK: depth=3D0,
/C=3DES/ST=3DMAD/L=3DMadrid/O=3DCS/CN=3Djavier/emailAddress=3Dxx@...1383...
Thu Nov 04 08:24:34 2010 XX.148.40.117:39056 openvpn_scripts:
(CN=3Djavier/cn=3Djavier) start user-pass-verify
Thu Nov  4 08:24:34 2010 XX.148.40.117:39056 TLS: Username/Password
authentication succeeded for username '' [CN SET]
Thu Nov  4 08:24:34 2010 XX.148.40.117:39056 Data Channel Encrypt: Cipher
'BF-CBC' initialized with 128 bit key
Thu Nov  4 08:24:34 2010 XX.148.40.117:39056 Data Channel Encrypt: Using 160
bit message hash 'SHA1' for HMAC authentication
Thu Nov  4 08:24:34 2010 XX.148.40.117:39056 Data Channel Decrypt: Cipher
'BF-CBC' initialized with 128 bit key
Thu Nov  4 08:24:34 2010 XX.148.40.117:39056 Data Channel Decrypt: Using 160
bit message hash 'SHA1' for HMAC authentication
Thu Nov  4 08:24:35 2010 XX.148.40.117:39056 Control Channel: TLSv1, cipher
TLSv1/SSLv3 DHE-RSA-AES256-SHA, 1024 bit RSA
Thu Nov  4 08:24:35 2010 XX.148.40.117:39056 [] Peer Connection Initiated
with XX.148.40.117:39056
Thu Nov 04 08:24:35 2010 XX.148.40.117:39056 openvpn_scripts: (CN=3Djavier)
start client-connect
route: SIOCADDRT: File exists
Thu Nov  4 08:24:35 2010 XX.148.40.117:39056 OPTIONS IMPORT: reading client
specific options from: /tmp//openvpn_cc_9448a5143bd3e6786d2b8060da752fe5.tmp
Thu Nov  4 08:24:35 2010 XX.148.40.117:39056 MULTI: Learn: 10.1.16.18 ->
XX.148.40.117:39056
Thu Nov  4 08:24:35 2010 XX.148.40.117:39056 MULTI: primary virtual IP for
XX.148.40.117:39056: 10.1.16.18
Thu Nov  4 08:24:35 2010 XX.148.40.117:39056 MULTI: internal route
10.2.0.0/16 -> XX.148.40.117:39056
Thu Nov  4 08:24:35 2010 XX.148.40.117:39056 MULTI: Learn: 10.2.0.0/16 ->
XX.148.40.117:39056
Thu Nov  4 08:24:37 2010 XX.148.40.117:39056 PUSH: Received control message:
'PUSH_REQUEST'
Thu Nov  4 08:24:37 2010 XX.148.40.117:39056 SENT CONTROL [UNDEF]:
'PUSH_REPLY,route 10.1.16.1,topology net30,ping 10,ping-restart 60,route
10.1.0.0 255.255.0.0,ifconfig 10.1.16.18 10.1.16.17' (status=3D1)
Thu Nov  4 08:24:45 2010 MULTI: Learn: 10.2.0.2 -> XX.148.40.117:39056
Thu Nov  4 08:24:57 2010 XX.148.40.117:46554 [UNDEF] Inactivity timeout
(--ping-restart), restarting
Thu Nov  4 08:24:57 2010 XX.148.40.117:46554 SIGUSR1[soft,ping-restart]
received, client-instance restarting
Thu Nov 04 08:24:57 2010 XX.148.40.117:46554 openvpn_scripts: (CN=3Djavier)
start client-disconnect
Thu Nov  4 08:24:57 2010 TCP/UDP: Closing socket
Thu Nov  4 08:24:57 2010 XX.148.40.117:39056 MULTI: Learn: 10.2.0.2 ->
XX.148.40.117:39056

After this happens the VPN is still up and working but because of the out of
sequence call to the scripts the routes have been deleted and no traffic
flows.

Looking at the source code (but not having debugged it), I see that as the
username is blank and that becomes the commonname, the call to
tls_common_name=20
in multi_delete_dup will returns NULL and the iteration to close the
instances do not get executed. Changing the second parameter of the two
tls_common_name call to false may do the trick but I do not know  what other
side effects may have.

I am going to avoid the whole issue by changing my scripts and dropping the
username-as-common-name option as it is a bit flaky especially when used as
I do where some connections have usernames/password authentications and
other don=B4t and end up with blank common names.

Regards
Carlos


