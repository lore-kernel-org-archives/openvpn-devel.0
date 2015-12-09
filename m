From: Gisle Vanem <gvanem@...2101...>
Message-ID: <5668A592.8080802@...2101...>
Date: Wed, 9 Dec 2015 23:05:06 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel] MSVC "parser stack overflow"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: OpenVPN-dev <openvpn-devel@lists.sourceforge.net>

While compiling src/openvpn/options.c with MSVC 2015, I got this
error:
  src/openvpn/options.c(5944): fatal error C1026: parser stack overflow, program too complex

I've also seen such error in GeoIP-lib due to all the 'if..else if' statements.
Can this be written using some kind of a table-lookup code instead?

-- 
--gv

