From: Charles Duffy <cduffy@...294...>
Message-ID: <pan.2005.02.10.00.42.38.435554@...294...>
References: <ee2671e605020907063b5d4138@...278...> <1e6368e805020914263117032e@...278...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Re: Openvpn 2.0 TAP installation on WindowsXP
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
Date: Wed Feb  9 16:45:26 2005
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

On Wed, 09 Feb 2005 17:26:14 -0500, Leonard Isham wrote:

> You need to allow duplicate certificates.

...or to create unique client certificates. There's a lot to be said for
knowing who the connected clients are (in the logs, status files, etc) and
being able to individually revoke them; IMHO, such is a more appropriate
practice to encourage than duplicate-cn use except in unusual cases.

In any event, this is a discussion more fit for openvpn-users than
openvpn-devel.


