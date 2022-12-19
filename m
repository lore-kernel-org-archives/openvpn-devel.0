Date: Mon, 19 Dec 2022 17:03:27 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y6CLT9s7yEJqp/tS@...2685...>
References: <Y6CDQFCTGH0hQ/NO@...2685...>
 <20221219155638.497-1-lstipakov@...277...>
MIME-Version: 1.0
In-Reply-To: <20221219155638.497-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3] git-version.py: proper support for
 tags
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

On Mon, Dec 19, 2022 at 05:56:38PM +0200, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
> 
> Git magic to get branch name
> 
>   git rev-parse --symbolic-full-name HEAD
> 
> doesn't work when we're on tag, which is the case when
> we build releases.
> 
> First, try to get tag name with
> 
>    git describe --exact-match
> 
> and if this fails, get branch name as before.
> 
> Use subprocess.Popen() to suppress stdout/stderr output.
> 
> This fixes https://github.com/OpenVPN/openvpn/issues/199.
> 
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  v3:
>   - use "none" as branch name when we're not on a branch nor tag
> 
>  v2:
>   - try to get tag name before branch
>   - use "git describe --exact-match" instead of "git describe --tags"
>   - use subprocess.Popen() instead of os.popen() to suppress output 
> 

Acked-By: Frank Lichtenheld <frank@...2641...>

-- 
  Frank Lichtenheld

