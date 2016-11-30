Date: Wed, 30 Nov 2016 22:44:56 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20161130144456.GB19791@...2182...>
References: <20161129063843.14526-1-a@...2181...>
	<1480515990.524617536@...2197...>
MIME-Version: 1.0
In-Reply-To: <1480515990.524617536@...2197...>
Subject: Re: [Openvpn-devel] [PATCH] reload CRL only if file was modified
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: SviMik <svimik@...450...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, Nov 30, 2016 at 05:26:30PM +0300, SviMik wrote:
> 1) I would also check if the file size was changed, not only mtime.
> 

this would work against 2 CRLs with the same mtime but different size: is this
is a real case we have to worry about?

Anyway, adding this check is easy. I'd do it if it makes the whole check more
robust.

> 2) I wasn't digging the code deeply, but the
> > ssl_ctx->crl_last_mtime.tv_sec >= crl_stat.st_mtime
> makes me think it would fail if the file goes reverted to a previous version. Perhaps the check shall be != instead of >=.
> 

good point! I think we should definitely switch to !=.

Thanks!

-- 
Antonio Quartulli

