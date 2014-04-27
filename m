Message-ID: <535CD403.6040603@...1227...>
Date: Sun, 27 Apr 2014 11:55:15 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <20140426210044.GF16637@...1296...>
In-Reply-To: <20140426210044.GF16637@...1296...>
Subject: Re: [Openvpn-devel] socket.c issues when building snapshots on
	windows...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

On 26.04.2014 23:00, Gert Doering wrote:
> Hiya,
>
> with some arm-twisting, I managed to convince build-snapshot to actually
> do that (it would prefer to do a git clone, autoconf, tarball, copy tarball,
> ignore the tarball, fetch 2.3.3 source, extract 2.3.3 and build that, thus
> never showing compilation errors...), and here we go...
>
> socket.c: In function 'socket_bind':
> socket.c:1124:40: error: 'IPV6_V6ONLY' undeclared (first use in this function)
> socket.c:1124:40: note: each undeclared identifier is reported only once for each function it appears in
> socket.c:1124:7: warning: passing argument 4 of 'setsockopt' from incompatible pointer type [enabled by default]
> /usr/lib/gcc/i686-w64-mingw32/4.6/../../../../i686-w64-mingw32/include/winsock2.h:1016:34: note: expected 'const char *' but argument is of type 'int *'
> socket.c: In function 'openvpn_connect':
> socket.c:1218:32: error: 'const struct sockaddr' has no member named 'addr'
> socket.c:1218:62: error: 'const struct sockaddr' has no member named 'addr'
> socket.c: In function 'socket_recv_queue':
> socket.c:3135:45: error: 'struct link_socket_addr' has no member named 'local'
>
> ... I'm posting this here so whoever has time can take a stab at it
> (I won't be able to work on this for the next couple of days, will focus
> on 2.3.4 release items).
>
>
The option seems to be supported since Windows Vista. I think we should 
add something like this to the windows ifdefs (copied from 
http://marc.info/?l=apr-dev&m=121392734329754&w=2):

+/* Ugly solution - only the Windows 2008 SDK or later have this symbol 
defined.
+ * The symbol doesn't guarantee that the socket option is supported on
+ * the runtime version of Windows, so we define it here (for build 
systems)
+ * and always check at runtime if it is supported.
+ */
+#ifndef IPV6_V6ONLY
+#define IPV6_V6ONLY 27
+#endif

