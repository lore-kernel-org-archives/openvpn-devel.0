From: Charles Duffy <cduffy@...294...>
Message-ID: <pan.2004.10.20.14.37.12.570340@...294...>
References: <loom.20041020T155229-690@...171...>
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
Date: Wed Oct 20 07:46:31 2004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

On Wed, 20 Oct 2004 14:02:13 +0000, Dirk Tronienne wrote:
> How has the Makefile (...what else?) to be modified for LZO? Is "LDADD =
> -static -lssl -lcrypto -lzo" correct?

If you're using static libfoo, etc. then you don't use "-lfoo"; instead
you add "/path/to/libfoo.a" to the link command.


