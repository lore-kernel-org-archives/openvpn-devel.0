From: Sampo Nurmentaus <audiopoppi-13@...22...>
Reply-To: <sampo.nurmentaus@...22...>
Message-ID: <Pine.LNX.4.33.0206121720140.28574-100000@...23...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Porting to an embedded linux
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Wed Jun 12 07:33:04 2002
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net



Hello folks,


I have been recently busy porting openssl, openssh
and openvpn to our embended linux environment
build on etrax 100lx processor from axis communications.

Openvpn's code was, thanks to you guys, quite easy to
port but then I ran into problems when open vpn tries
to ioctl tun device:

....
65: Static Decrypt: Cipher 'BF-CBC' initialized with 128 bit key
66: Static Decrypt: Using 160 bit message digest 'SHA1' for HMAC
authentication
67: Data Channel MTU parms: mtu=1456 extra_frame=44 extra_buffer=44
extra_tun=0
68: Cannot ioctl TUNSETIFF tun0: File descriptor in bad state (errno=77)
69: Exiting


I have changed device to locate
in /tmp/tun, but that shuld not couse this kind of problems.
/dev is on flash image so it is easier to use /tmp for testing.
I created the device as should with:
mknod /tmp/tun c 10 200

If I try to cat tun device read returns with the very same
error text.

 I compiled support to kernel (not as a module)
so it should always be there.


Any ideas?

Thanx in advange,

Sampo Nurmentaus





