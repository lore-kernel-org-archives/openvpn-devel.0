Message-ID: <027201c1dc46$934923b0$1000000a@...4...>
From: "James Yonan" <jim@...3...>
References: <1017930178.2718.47.camel@...2...>
Subject: Re: [Openvpn-devel] Now it works far better on/against BSD.
MIME-Version: 1.0
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
Date: Thu Apr  4 18:16:03 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: Janne Johansson <jan.johansson@...1...>, openvpn-devel@lists.sourceforge.net

Janne,

On BSD, is there any way to ioctl away the leading AF_INET, or is it
necessary to have the linux side conform to the BSD side with --remote-bsd?

>It compiles cleanly on Linux2.4 and with 2 warnings on OpenBSD3.0.
==============================================
gcc -g -O2  -I/usr/local/include  -c openvpn.c
openvpn.c: In function `openvpn':
openvpn.c:777: warning: passing arg 5 of `tls_multi_process' from
incompatible pointer type
openvpn.c:780: warning: passing arg 3 of `interval_set_timeout' from
incompatible pointer type
=========================
Weird.

What's the type of the tv_sec member of struct timeval on BSD?  On linux
it's time_t.  It's probably something else on BSD, hence the warning.

Jim



