Message-ID: <4BAFC559.1010403@...1114...>
Date: Sun, 28 Mar 2010 23:08:41 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Reconnect issues when using --user/--group with
	--mlock
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi guys!

I've been playing a bit with OpenVPN and automatic re-establishment if
the connection is broken.  During this, I've hit a few obstacles when
using --user and --group together with --mlock.  All testing has been
done with 2.1.1 and openvpn-testin.git (bugfix2.1 branch) on the client
side.  Server side is 2.1.0 with the eurephia patch.  All systems are
32bit, the server is running Gentoo and the client is running CentOS 5.4.

With the stock CentOS 5.4 version of OpenVPN (v2.1.1) the following
line is found in the log file:

- -----------------------------
"NOTE: Pulled options changed on restart, will need to close and reopen
TUN/TAP device."
- -----------------------------

It can tear down the tun/tap device, but it cannot recreate the device
as root privileges are required.  This happens whenever you involve
- --user in the config file on this version.  Anyway, this particular
behaviour seems to be solved in openvpn-testing.git.  (This information
is meant as a reference to others seeing this message)

However!  In the openvpn-testing.git, enabling --mlock in addition (that
is, the client config is using --user, --group and --mlock) the
following is found in the log file on the client after OpenVPN is
restarted on the server side and the ping timeout triggers SIGUSR1.

- -----------------------------
openvpn[2531]: [vpn1.server.net] Inactivity timeout (--ping-restart),
restarting
openvpn[2531]: SIGUSR1[soft,ping-restart] received, process restarting
openvpn[2531]: WARNING: Make sure you understand the semantics of
- --tls-remote before using it (see the man page).
openvpn[2531]: NOTE: the current --script-security setting may allow
this configuration to call user-defined scripts
openvpn[2531]: Re-using SSL/TLS context
openvpn[2531]: LZO compression initialized
openvpn[2531]: UDPv4 link local (bound): [undef]:4493
openvpn[2531]: UDPv4 link remote: vpn1.server.net:4493
openvpn[2531]: WARNING: this configuration may cache passwords in memory
- -- use the auth-nocache option to prevent this
out of memory [2531]
last message repeated 2 times
openvpn[2531]: ERROR: Linux route delete command failed: external
program exited with error status: 7
openvpn[2531]: ERROR: Linux route delete command failed: external
program exited with error status: 7
openvpn[2531]: /sbin/ifconfig vpn0 0.0.0.0
openvpn[2531]: Linux ip addr del failed: external program exited with
error status: 255
openvpn[2531]: SIGTERM[soft,tls-error] received, process exiting
- -----------------------------

What is interesting here is the "out of memory" message.  I've not been
able to really figure out yet what triggers this error message.  But it
appears consequently when using --mlock.  And it never manages to
re-establish the connection when --mlock is used.

I've tried to follow the code path, but I do get a bit lost in the
possible entry points of the do_mlockall() function.  And to top it
completely, when running it via strace I get a completely different
error message:

- -----------------------------
TLS_ERROR: BIO read tls_read_plaintext error:
error:05067003:Diffie-Hellman routines:GENERATE_KEY:BN lib:
error:14098005:SSL routines:SSL3_SEND_CLIENT_KEY_EXCHANGE:DH lib
TLS Error: TLS object -> incoming plaintext read error
TLS Error: TLS handshake failed
- -----------------------------

Feels a bit like a Heisenbug.  If I remove --mlock from the client
config, the connection is re-established automatically without any
issues - when using openvpn-testing.git (bugfix2.1 branch).  I'll
install the allmerged branch after this mail, but I expect no changes
here though.


Configuration file used on the client
- -----------------------------
user openvpn
group openvpn
chroot /var/tmp/openvpn
persist-key
persist-tun
# mlock
client
remote vpn1.server.net
port 4493
dev-type tap
dev vpn0
proto udp
comp-lzo
cipher AES-256-CBC
auth-user-pass
tls-client
tls-remote vpn1.server.net
ns-cert-type server
tls-exit
tls-auth ta.key 1
- -----------------------------

The server side is constant the whole time.  One route is being pushed
via --client-config-dir.  The server config is pretty straight forward
with no extra magic, except --plugin using eurephia for
user/password/certificate authentication.  And as the problems are on
the client side, I don't include a server config now.


Any ideas where to look next?


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuvxVkACgkQDC186MBRfrrUIwCgny7lgoRAAXhlynp35lN/FMPy
ibQAn0mHvFO3kRfqUnkN8h2Fjn9yX8eJ
=qRRv
-----END PGP SIGNATURE-----

