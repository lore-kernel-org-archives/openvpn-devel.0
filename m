From: Heiko Hund <heiko@...2662...>
Date: Thu, 18 Aug 2022 16:39:07 +0200
Message-ID: <1970912.abQj5cvHqE@...2664...>
In-Reply-To: <20220520213250.3126372-3-arne@...1227...>
References: <20220520213250.3126372-1-arne@...1227...>
 <20220520213250.3126372-3-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2 2/4] Cleanup receive_auth_failed and
 simplify method
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

On Freitag, 20. Mai 2022 23:32:48 CEST Arne Schwabe wrote:
> This simplifies the buffer handling in the method and adds a quick
> return instead of wrapping the whole method in a if (pull) block
> 
> Patch V2: remove uncessary ifdef/endif and unnecassary block

Acked-by: Heiko Hund <heiko@...2662...>



