References: <20210317160038.25828-1-arne@...1227...>
 <20210317160038.25828-3-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <b6e576cb-6d07-92ba-2518-123da16d1bb3@...2181...>
Date: Wed, 17 Mar 2021 17:44:02 +0100
MIME-Version: 1.0
In-Reply-To: <20210317160038.25828-3-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 3/3] Restore also ping related
 options on a reconnect
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi all,

On 17/03/2021 17:00, Arne Schwabe wrote:
> This fixes the issue that if a client reconnects the next connection
> entries inherits the keepalive settings that were pushed or set by
> the previous entry. Since UDP+PULL entries have an implicit 120s
> timeout, this timeout also got applied to a TCP session after an
> UDP entry.
> 
> Patch v2: rebase on master
> 
> Reported-By: Jan Just Keijser <janjust@...1147...>
> Signed-off-by: Arne Schwabe <arne@...1227...>

This patch is actually fixing a bug, as reported by JJK, however it is
such a coerner case that we may not want to backport this to 2.4
(backporting requires rewriting the patch).

This patch was reviewed with the Arne's guidance.

Acked-by: Antonio Quartulli <antonio@...515...>

-- 
Antonio Quartulli

