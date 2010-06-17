Message-ID: <20100617101247.16432.qmail@...1287...>
Date: Thu, 17 Jun 2010 12:12:47 +0200
From: Peter Stuge <peter@...1287...>
References: <499929A843E2C541A8AD31A881A2B6A206236F74@...1006...>
	<1276690741.2615.259.camel@...1259...>
	<499929A843E2C541A8AD31A881A2B6A206236F74@...1006...>
	<4C18C0D3.2010805@...515...>
MIME-Version: 1.0
In-Reply-To: <1276690741.2615.259.camel@...1259...> <4C18C0D3.2010805@...515...>
Subject: Re: [Openvpn-devel] [Openvpn-users] FW: Patch submission -
	git	crash course ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Samuli Seppänen wrote:
> git clone <repository_url>
> # do your changes
> # then git <something> to create and mail a patch to -devel

chantra wrote:
> # do changes
> $ git diff > my_patch 

Please make sure to always create commits in your repo before sending
a patch. Once you have made a commit it is easy to generate a patch
using the git format-patch command.


//Peter

