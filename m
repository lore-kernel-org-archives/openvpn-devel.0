From: Heiko Hund <heiko@...2662...>
Date: Wed, 05 Jul 2023 15:38:28 +0200
Message-ID: <5688226.DvuYhMxLoT@...2664...>
In-Reply-To: <20221127085933.3487177-1-arne@...1227...>
References: <20221127085933.3487177-1-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] [RFC] fix warning with gcc 12.2.0
 (compiler bug?)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Sonntag, 27. November 2022 09:59:33 CEST Arne Schwabe wrote:
> Signed-off-by: Arne Schwabe <arne@...1227...>

Acked-by: Heiko Hund <heiko@...2662...>

This one is ugly, but required to build with cmake and mingw with -Werror

Cheers, Heiko




