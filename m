From: Heiko Hund <heiko@...2662...>
Date: Mon, 11 Jul 2022 17:12:16 +0200
Message-ID: <17905092.m6bAzNTSmz@...2664...>
In-Reply-To: <20220711122348.8756-1-a@...2181...>
References: <20220711122348.8756-1-a@...2181...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] options: don't export local function
 pre_connect_save()
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

On Montag, 11. Juli 2022 14:23:48 CEST Antonio Quartulli wrote:
> The pre_connect_save() function is not used outside of options.c,
> therefore it should not be exported.
> 
> Make it static and move definition before its invocation.
> Move also pre_connect_restore() along with it in order to keep the two
> close to each other.
> 
> Cc: Arne Schwabe <arne@...1227...>
> Signed-off-by: Antonio Quartulli <a@...2181...>

Noticed this as well before, but was too lazy to patch ;-)

Acked-by: Heiko Hund <heiko@...2662...>



