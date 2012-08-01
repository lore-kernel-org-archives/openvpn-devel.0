From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 1 Aug 2012 14:48:09 +0200
Message-ID: <2185000.9QTBQQtQLA@...1526...>
In-Reply-To: <CAOazyz3uAxHh0ttBKu4uEckhEudkfx__L8ge4SxKOekBLaXQng@...278...>
References: <1343821058-11456-3-git-send-email-heiko.hund@...1489...>
	<1343822222-11978-1-git-send-email-heiko.hund@...1489...>
	<CAOazyz3uAxHh0ttBKu4uEckhEudkfx__L8ge4SxKOekBLaXQng@...278...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 2/2 fixed] add plugin_log() API to write
	to openvpn log
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On Wednesday 01 August 2012 15:27:01 Alon Bar-Lev wrote:
> How will it work on Windows?

Good question. Can't it work on Windows? According to objdump openvpn.exe 
exports all the symbols statically on Windows. Is that a limitation of the PE 
format?

If not, the alternative would be to pass the function pointer in one (all?) of 
the v3 plug-in structs.

Heiko
-- 
Heiko Hund | Sr. Software Engineer | Tel +49-721-25516-237 | Fax -200
SOPHOS NSG | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germany


