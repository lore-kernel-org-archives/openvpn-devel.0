Message-ID: <4C9C1BB0.7000304@...1299...>
Date: Fri, 24 Sep 2010 15:32:00 +1200
From: Jason Haar <Jason.Haar@...1299...>
MIME-Version: 1.0
Subject: [Openvpn-devel] proper "logout" support for the server?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

 Hi there

Minor feature request. When a user ends their openvpn client session,
shouldn't it be possible to send one last command to the server - a
"logout" command? That way the server can clean up the session much
faster than waiting for a keepalive timeout cycle...

(the problem I see is that we make extensive use of "--up"/etc scripts
and a user can sometimes do several "up->down->up" in a row - which
leads to "flapping" checks. If the server was told the client was
leaving, this would reduce these issues).

-- 
Cheers

Jason Haar
Information Security Manager, Trimble Navigation Ltd.
Phone: +64 3 9635 377 Fax: +64 3 9635 417
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1


