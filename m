Message-ID: <007001c2380e$5cd8e0d0$1000000a@...4...>
From: "James Yonan" <jim@...3...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Ramifications on OpenVPN of OpenSSL security announcement
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
Date: Tue Jul 30 14:15:04 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

As many of you have probably noticed, the OpenSSL project released a
security update today which fixes potential remote buffer overflows.

What you may not have known is that the ASN1 parser bug was independently
discovered in the process of stress testing OpenVPN, earning yours truly the
dubious distinction of being acknowledged in the security advisory.

So here's the scoop for OpenVPN users:

(1) If you are using preshared static key mode, you are not vulnerable.

(2) If you are using TLS mode with --tls-auth, you are not vulnerable.

(3) If you are using TLS mode without --tls-auth, you may be vulnerable if
you are also using --float.

If you think you are vulnerable, the quickest fix is to start
using --tls-auth, which was explicitly designed to protect against buffer
overflows in OpenSSL by creating a two-tier authentication hierarchy that
forces ALL incoming packets to authenticate via HMAC before they are passed
on to the TLS code in OpenSSL.  Think of it as a kind of MAC firewall.

In general you should also consider downgrading privileges with --user
and/or --group, to limit the damage that would be caused by a remote buffer
overflow attack.  If for whatever reason you must run as root, then consider
using the --chroot option to lock the OpenVPN daemon into a restricted
filesystem, so that a remote attack would not be able to modify sensitive
files.

Of course most systems have a lot of other apps and daemons that depend on
OpenSSL so upgrading ASAP is probably the best course.

James



