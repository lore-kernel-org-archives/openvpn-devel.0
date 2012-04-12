From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 12 Apr 2012 09:54:12 +0200
Message-ID: <2830016.EneD4hFqTN@...1526...>
In-Reply-To: <76d0f2b389cbc.4f86bc51@...1707...>
References: <7790c56a8b75e.4f862f6b@...1707...>
	<76d08f528b8d9.4f862fa7@...1707...>
	<76d0f2b389cbc.4f86bc51@...1707...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Translation Question] Traditional Chinese
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

Hi YiWen

On Thursday 12 April 2012 02:28:17 Yi-Wen Cheng wrote:
> I want to translate openvpn into Traditional Chinese.
> Could anybody assist me what should I do to start the work?

Great, thank you! I suppose you want to translate the Openvpn GUI for Windows. 
If so, just fetch the English resource file from the repository at [1], 
translate the strings in it and make sure you save it UTF-8 encoded. Then send 
it to this list or open an issue about it at [2]. Please also change the 
language constants to "LANG_CHINESE | SUBLANG_CHINESE_TRADITIONAL" (this will 
make a bit more sense after you looked at [1]).

Heiko
-- 
Heiko Hund | Software Engineer | Tel +49-721-25516-237 | Fax -200
SOPHOS NSG | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germany


