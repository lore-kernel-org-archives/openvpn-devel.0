From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 16 May 2013 10:28:07 +0200
Message-ID: <2546708.UqrHuWJe3D@...1526...>
In-Reply-To: <kmm4g5$fg9$1@...1062...>
References: <kmm4g5$fg9$1@...1062...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Fix Windows script execution when
	called from script hooks
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
To: openvpn-devel@lists.sourceforge.net

On Saturday 11 May 2013 14:00:24 Josh Cepek wrote:
> /* this allows console programs to run, and is ignored otherwise */

ACK, because it's the truth. =)

> unsigned int proc_flags = CREATE_NO_WINDOW;

However, this should be a DWORD instead of unsigned int.

Regards
Heiko
-- 
Heiko Hund | Sr. Software Engineer | Tel +49-721-25516-237 | Fax -200
SOPHOS NSG | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germany


