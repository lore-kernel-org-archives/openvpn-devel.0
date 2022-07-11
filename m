From: Heiko Hund <heiko@...2662...>
Date: Mon, 11 Jul 2022 17:04:07 +0200
Message-ID: <6170208.GTXyNhITjv@...2664...>
In-Reply-To: <20220711141944.21262-1-a@...2181...>
References: <20220711141944.21262-1-a@...2181...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2 23/23] dco-win: implement ovpn-dco
 support in P2P Windows code path
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

On Montag, 11. Juli 2022 16:19:44 CEST Antonio Quartulli wrote:
> With this change it is possible to use ovpn-dco-win when running OpenVPN
> in client or P2P mode.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> Signed-off-by: Lev Stipakov <lev@...515...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
> 
> Changes from v1:
> * use suffix _dco_win instead of _windco
> * create helper function to retrieve last error from socket object

Acked-by: Heiko Hund <heiko@...2662...>



