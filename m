References: <20170626211540.32502-1-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <3f62163c-4e76-4cfc-9c00-b877dd26ee20@...1227...>
Date: Mon, 26 Jun 2017 23:39:26 +0200
MIME-Version: 1.0
In-Reply-To: <20170626211540.32502-1-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Undo cipher push in client options
 state if cipher is rejected
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

Am 26.06.17 um 23:15 schrieb Steffan Karger:
> Because of the way we re-use the options parser for both config files and
> pushed options, we always update the local options state when we accept an
> option.  This resulted in a pushed cipher being rejected the first time it
> was pushed, but being accepted the second time.
> 
> This patch is a minimal way to resolve this issue in the master and
> release/2.4 branches.  I'll send a more invasive patch for master, to
> reset the entire options state on reconnects, later.
> 

ACK. Not as Steffan says, minimal way to achieve this. Should be applied
to both master and 2.4.


Arne


