MIME-Version: 1.0
References: <20221215232104.1181936-1-selva.nair@...277...>
In-Reply-To: <20221215232104.1181936-1-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 16 Dec 2022 11:46:16 +0200
Message-ID: <CAGyAFMWjum0qh3XA8Wzdf9uqNYfX4kM00nPZ5YmrUDSP+7iU1A@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Persist DCO client data channel traffic
 stats on restart
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

Hi,

That was fast!

> Tested on Windows which is the only platform that currently
> supports stats from DCO in client mode.

Would be nice to have a comment (in code maybe?) that:

DCO resets stats on reconnect. Since client expects stats
to be preserved across reconnects, we need to save DCO
stats before tearing the tunnel down.

But anyway,

Code looks good, compiled and tested - stats are indeed preserved
across reconnect.

Acked-by: Lev Stipakov <lstipakov@...277...>

