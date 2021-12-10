Date: Fri, 10 Dec 2021 11:58:23 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <361815933.818902.1639133903440@...2642...>
In-Reply-To: <20211207130436.22187-1-gert@...1296...>
References: <20211207130436.22187-1-gert@...1296...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Move '--push-peer-info' documentation
 from 'server' to 'client options'
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Acked-By: Frank Lichtenheld <frank@...2641...>

Looks like an obvious improvement to me.

> Gert Doering <gert@...1296...> hat am 07.12.2021 14:04 geschrieben:
> 
>  
> While --push-peer-info can be configured on the server, it's not really
> intended for that, and it ended in the "SERVER OPTIONS" section by
> mishap.  Fix that.
> 
> Reported-by: Stella Ashburne <rewefie@...1278...>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  doc/man-sections/client-options.rst | 69 +++++++++++++++++++++++++++++
>  doc/man-sections/server-options.rst | 69 -----------------------------
>  2 files changed, 69 insertions(+), 69 deletions(-)
--
Frank Lichtenheld

