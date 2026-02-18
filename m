Date: Wed, 18 Feb 2026 13:01:12 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <aZWqCMUl7PDvtX26@...2685...>
References: <aZMIlXEbofy5oZhD@...2995...>
MIME-Version: 1.0
In-Reply-To: <aZMIlXEbofy5oZhD@...2995...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/2] ntlm: fix discards 'const'
 qualifier from pointer target type
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Rudi Heitbaum <rudi@...2993...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Feb 16, 2026 at 12:07:49PM +0000, Rudi Heitbaum via Openvpn-devel wrote:
> Since glibc-2.43:
> 
> For ISO C23, the functions bsearch, memchr, strchr, strpbrk, strrchr,
> strstr, wcschr, wcspbrk, wcsrchr, wcsstr and wmemchr that return pointers
> into their input arrays now have definitions as macros that return a
> pointer to a const-qualified type when the input argument is a pointer
> to a const-qualified type.
> 
> fixes:
>     src/openvpn/ntlm.c: In function 'ntlm_phase_3':
>     src/openvpn/ntlm.c:241:15: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>       241 |     separator = strchr(p->up.username, '\\');
>           |               ^
> 
> Signed-off-by: Rudi Heitbaum <rudi@...2993...>
> ---
>  src/openvpn/ntlm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Frank Lichtenheld <frank@...2641...>

https://gerrit.openvpn.net/c/openvpn/+/1546

Regards,
-- 
  Frank Lichtenheld

