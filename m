Message-ID: <03d501c221f7$26727830$1000000a@...4...>
From: "James Yonan" <jim@...3...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Protocol Change policy
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
Date: Tue Jul  2 11:36:42 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

I'd like to hear your opinions on how the OpenVPN project should handle
patches which break backward compatibility.

There are a couple of (as yet unapplied) patches in the queue that change
the OpenVPN protocol including parameter defaults that affect the protocol:

(1) Add device type (tun | tap | null) to TLS handshake string for
compatibility check between peers.

(2) Reduce default --udp-mtu to 1450 from 1500 when --ifconfig is used
(Matthias Andree noticed a lot of fragmentation with the default setting of
1500).

The question is how should protocol changes be introduced so that they don't
cause a lot of pain due to the loss of backward compatibility, but at the
same time not introduce lots of complexifying cruft into the code?

Here are some answers that come to mind:

(1) Accumulate such patches and merge them all at once in a future release
such as 1.3.0 or 2.0.0, while warning users that this release will not be
backward compatible.

(2) Merge changes immediately but #ifdef them out by default until some
future planned release.  The user would have to build with an explicit
./configure option to enable, or wait for the future planned release when
the protocol changes would be enabled by default.  This is similar to how
python handles language changes with the "from future" tag --
http://www.python.org/peps/pep-0236.html

(3) Merge changes immediately but provide a ./configure option to build for
previous protocol version.

(4) Use explicit protocol version numbers as SSH or NFS does.

(5) Use a command line option such as "--peer-version 1.1.0" to allow a
given OpenVPN version to downgrade its protocol to talk to an old version.

1, 2, and 3 are the easiest to implement as they handle the version number
choice at build time.  4 and 5 do it at run time which is more convenient
for the user, but would add considerable cruft to the code.

Comments?

James



