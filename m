Date: Mon, 17 Jul 2023 16:28:46 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZLVQHvCC/+AwSvNb@...2685...>
References: <gerrit.1679478483000.I465febdf7ee5fe573e88255844f718efb60f8e8a@...2715...>
 <f856bfd7f55dc089e0875db077914c6eac398696-HTML@...2715...>
MIME-Version: 1.0
In-Reply-To: <f856bfd7f55dc089e0875db077914c6eac398696-HTML@...2715...>
Subject: Re: [Openvpn-devel] [S] Change in openvpn[release/2.6]: Print DCO
 client stats on SIGUSR2
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
To: arne-openvpn@...1227..., heiko@...515..., openvpn-devel@lists.sourceforge.net, lstipakov@...277..., a@...2181...

On Mon, Jul 17, 2023 at 02:17:17PM +0000, flichtenheld (Code Review) wrote:
> flichtenheld has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/202?usp=email )
> 
> Change subject: Print DCO client stats on SIGUSR2
> ......................................................................
> 
> Print DCO client stats on SIGUSR2
> 
> Change-Id: I465febdf7ee5fe573e88255844f718efb60f8e8a
> Signed-off-by: Lev Stipakov <lev@...515...>
> Acked-by: Gert Doering <gert@...1296...>
> Message-Id: <20230322113249.2039-1-lstipakov@...277...>
> URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26471.html
> Signed-off-by: Gert Doering <gert@...1296...>
> (cherry picked from commit d5238627e4fab93a6c09816c60eb90e237b626c3)
> ---
> M src/openvpn/sig.c
> M src/openvpn/sig.h
> 2 files changed, 10 insertions(+), 5 deletions(-)

release/2.6 on Gerrit server was far behind and also had some wrong commits.
I force-pushed it to the correct state now. I assume that these mails were
hallucinations caused by that.

Regards,
-- 
  Frank Lichtenheld

