Message-ID: <a8643a1a-61d9-3931-4548-db91571bb24e@...1227...>
Date: Fri, 6 Jan 2023 16:12:02 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20230101215109.1521549-1-selva.nair@...277...>
 <20230101215109.1521549-4-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20230101215109.1521549-4-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH 3/5] Assign and honour signal priority
 order
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

Am 01.01.23 um 22:51 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> Signals are ordered as SIGUSR2, SIGUSR1, SIGHUP, SIGTERM, SIGINT
> in increasing priority. Lower priority signals are not allowed to
> overwrite higher ones.
> 
> This should fix Trac #311, #639 -- SIGTER/SIGINT lost during dns resolution.
> (except for the Windows-specific bug handled in next commit)
> 
> On sending SIGTERM during dns resolution, it still takes several seconds
> to terminate as the signal will get processed only after getaddrinfo times out
> twice (in phase1 and phase2 inits).
> 
> Github: fixes OpenVPN/openvpn#205
> Note: one has to still wait for address resolution to time out as getaddrinfo()
> is no interruptible. But a single ctrl-C (and some patience) is enough.

Thanks. This looks like a good approach. I know there is some other 
similar bug somewhere else that has been forever on my todo list of my 
Android app and also the problem with signal ordering.

Acked-By: Arne Schwabe <arne@...1227...>

While reviewing the patch, I noticed that 
SIG_SOURCE_SOFT/SIG_SOURCE_HARD seems to be purely informational and 
have no real other meaning.

