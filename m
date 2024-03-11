Date: Mon, 11 Mar 2024 12:44:20 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Ze7ulBhO5hBj+Z1o@...2685...>
References: <20240308102818.9249-1-gert@...1296...>
 <202403081151.428BpXTq026459@...2054...>
MIME-Version: 1.0
In-Reply-To: <202403081151.428BpXTq026459@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: t_client.sh: Allow to skip
 tests
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, Mar 08, 2024 at 12:51:33PM +0100, Gert Doering wrote:
[...]
> Your patch has been applied to the master branch.

Could we please cherry-pick this to release/2.6 as well?

Would make it much easier to use this capability in our buildbot
infrastructure and the patch only affects tests anyway.

> commit 0c7cf0694ee6f878168330e9a084c255c51a9e8b
> Author: Frank Lichtenheld
> Date:   Fri Mar 8 11:28:18 2024 +0100
> 
>      t_client.sh: Allow to skip tests
> 
>      Signed-off-by: Frank Lichtenheld <frank@...2641...>
>      Acked-by: Gert Doering <gert@...1296...>
>      Message-Id: <20240308102818.9249-1-gert@...1296...>
>      URL: https://www.mail-archive.com/search?l=mid&q=20240308102818.9249-1-gert@...1296...
>      Signed-off-by: Gert Doering <gert@...1296...>
> 
> 
> --
> kind regards,
> 
> Gert Doering
> 

-- 
  Frank Lichtenheld

