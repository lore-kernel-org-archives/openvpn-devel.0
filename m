Date: Wed, 18 Feb 2026 13:00:23 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <aZWp1_opO2EduScn@...2685...>
References: <aZMIXom9GFt17IpB@...2995...>
MIME-Version: 1.0
In-Reply-To: <aZMIXom9GFt17IpB@...2995...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/2] dns: fix discards 'const'
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

On Mon, Feb 16, 2026 at 12:06:54PM +0000, Rudi Heitbaum via Openvpn-devel wrote:
> Since glibc-2.43:
> 
> For ISO C23, the functions bsearch, memchr, strchr, strpbrk, strrchr,
> strstr, wcschr, wcspbrk, wcsrchr, wcsstr and wmemchr that return pointers
> into their input arrays now have definitions as macros that return a
> pointer to a const-qualified type when the input argument is a pointer
> to a const-qualified type.
> 
> fixes:
>     src/openvpn/dns.c: In function 'dns_server_addr_parse':
>     src/openvpn/dns.c:67:25: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>        67 |     char *first_colon = strchr(addr, ':');
>           |                         ^~~~~~
>     src/openvpn/dns.c:68:24: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>        68 |     char *last_colon = strrchr(addr, ':');
>           |                        ^~~~~~~
> 
> Signed-off-by: Rudi Heitbaum <rudi@...2993...>
> ---
>  src/openvpn/dns.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)


Since upgrading the arch container yesterday we also see these in our
CI builds now.

Acked-by: Frank Lichtenheld <frank@...2641...>

Also put this into Gerrit as https://gerrit.openvpn.net/c/openvpn/+/1542
to get test builds.

Regards,
-- 
  Frank Lichtenheld

