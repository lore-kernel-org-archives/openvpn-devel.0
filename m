Message-ID: <082d01c3b9bb$c9452280$0600000a@...139...>
From: "Gisle Vanem" <gvanem@...139...>
References: <twig.1070466995.66427@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Re: [Openvpn-users] Pthreads on Windows
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Dec  3 08:38:02 2003
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

"James Yonan" <jim@...41...> said:

> Pthreads doesn't work on Windows.  Windows has its own threading model and is
> incompatible with pthreads.

Not so. There is pthread-win32 at
http://sources.redhat.com/pthreads-win32/

I've successfully used it in libpcap etc. But OpenVPN uses native
Windows calls, so using pthreads-win32 would add unneeded overhead
(allthough very little).

--gv



