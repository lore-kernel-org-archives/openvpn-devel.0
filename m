From: Dirk Tronienne <daniel@...297...>
Message-ID: <loom.20041021T090420-337@...171...>
References: <loom.20041020T155229-690@...171...> <pan.2004.10.20.14.37.12.570340@...294...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Re: compile statically with LZO and SSL support?
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
Date: Thu Oct 21 00:18:29 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Charles Duffy <cduffy <at> spamcop.net> writes:

> 
> On Wed, 20 Oct 2004 14:02:13 +0000, Dirk Tronienne wrote:
> > How has the Makefile (...what else?) to be modified for LZO? Is "LDADD =
> > -static -lssl -lcrypto -lzo" correct?
> 
> If you're using static libfoo, etc. then you don't use "-lfoo"; instead
> you add "/path/to/libfoo.a" to the link command.
> 
Thanks for help but this doesn´t seem to work for me. There has to be another 
problem. I tried OpenVPN_beta14 on SuSE 9.1 

Here is what I tried:
1. ./configure --enable-lzo
2. Edit the Makefile: ADD "LDADD = -static /usr/lib/liblzo.a"
3. After starting "make" I get the following error messages:
---snip---
 sig.o socket.o socks.o ssl.o status.o thread.o tun.o work.o  -static
/usr/lib/liblzo.a -lssl -lcrypto -llzo

/root/openvpn-2.0_beta14/misc.c:108: warning: Using 'getgrnam' in statically
linked applications requires at runtime the shared libraries from the glibc
version used for linking

/usr/lib/gcc-lib/i586-suse-linux/3.3.3/../../../libcrypto.a(b_sock.o)
(text.unlikely+0x5c3): In function `BIO_get_port':: warning: Using
'getservbyname' in statically linked applications requires at runtime 
the shared libraries from the glibc version used for linking

/usr/lib/gcc-lib/i586-suse-linux/3.3.3/../../../libcrypto.a(dso_dlfcn.o)
(text.unlikely+0x183): In function `dlfcn_bind_func':
: undefined reference to `dlsym'


---snap---

Seems that there is a problem with "libc2?
I got no clue....

Perhaps any of you already has compiled openVPN with statically linked LZO
(and OpenSLL)?


Thank you,

Dirk

   



