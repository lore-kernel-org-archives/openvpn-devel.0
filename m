From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 16 May 2013 16:27:53 +0200
Message-ID: <3937361.p36L8Bq3Kg@...1526...>
In-Reply-To: <kn2pao$5sv$1@...1062...>
References: <kmm4g5$fg9$1@...1062...> <2546708.UqrHuWJe3D@...1526...>
	<kn2pao$5sv$1@...1062...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2] Fix Windows script execution when
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

On Thursday 16 May 2013 09:09:23 Josh Cepek wrote:
> Console applications under Windows, such as batch scripts, require the
> CREATE_NO_WINDOW process flag when run without an actual console window
> present. This change allows such scripts to execute and impact the hook
> status by way of their return code.

OK from my side for this.

Heiko
-- 
Heiko Hund | Sr. Software Engineer | Tel +49-721-25516-237 | Fax -200
SOPHOS NSG | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germany


