From: "James Yonan" <jim@...41...>
Message-ID: <twig.1070466995.66427@...41...>
In-Reply-To: <11e101c3b887$897137a0$0600000a@...139...>
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
Date: Wed Dec  3 07:57:08 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Gisle Vanem <gvanem@...139...>, OpenVPN <openvpn-users@lists.sourceforge.net>
Cc: openvpn-devel@lists.sourceforge.net

Gisle Vanem <gvanem@...139...> said:

> Is using USE_PTHREAD any points for Windows version
> of openvpn? If not, it should perhaps cause an "#error".

Good idea.

> It doesn't compile because of missing 'reads' in 'struct event_wait'.
> 
> OpenVPN 1.5.0 + gcc MingW.

Pthreads doesn't work on Windows.  Windows has its own threading model and is
incompatible with pthreads.

> BTW. My DDK doesn't have ntstrsafe.h. Isn't there a way
> to build the tap w/o that? (normal str*() functions).

Not really advised, as it may create buffer overflow vulnerabilities in the
driver.  The DDKs for Win2k and up should have ntstrsafe.h

James



