From: Charles Duffy <cduffy@...294...>
Message-ID: <pan.2004.10.21.15.26.37.612170@...294...>
References: <loom.20041020T155229-690@...171...> <pan.2004.10.20.14.37.12.570340@...294...> <loom.20041021T090420-337@...171...>
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
Date: Thu Oct 21 08:29:26 2004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Instead of adding /usr/lib/liblzo.a, you should *replace* the -llzo with
it. Also, according to the error (the other two messages were warnings),
you need access to the dynamic linker (-ldl or /usr/lib/libdl.a on my
system) so the OpenSSL libraries can access getservbyname() at runtime.


