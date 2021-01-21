MIME-Version: 1.0
References: <20200930131317.1299-1-arne@...1227...>
 <20200930131317.1299-9-arne@...1227...>
In-Reply-To: <20200930131317.1299-9-arne@...1227...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 21 Jan 2021 16:05:51 +0200
Message-ID: <CAGyAFMV2MqzeeVQJXBbG9trW2vN6a13_mfjN-dn6v2qGSqFuiA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 07/11] Refactor extract_var_peer_info
 into standalone function and add ssl_util.c
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Both new files have

> +}
> \ No newline at end of file

Can probably be fixed by the committer.

Stared at the come, compiled with MSVC.
No "brand new" code added, just existing one factored out
into a separate function and generalized.

Acked-by: Lev Stipakov <lstipakov@...277...>

Acked with distinction for updating MSVC project files.

