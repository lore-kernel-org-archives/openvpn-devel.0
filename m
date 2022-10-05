Resent-Message-ID: <Yz3LfBCM9wgdia2l@...1296...>
Resent-To: openvpn-devel@lists.sourceforge.net
Date: Wed, 5 Oct 2022 12:31:29 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Yz1dAT8UBctLRKyN@...2685...>
References: <20221004082532.84741-1-gert@...1296...>
 <20221004131403.95597-1-gert@...1296...>
MIME-Version: 1.0
In-Reply-To: <20221004131403.95597-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] denoise tests/t_lpback.sh
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

On Tue, Oct 04, 2022 at 03:14:03PM +0200, Gert Doering wrote:
> Introduce V=<nn> levels to t_lpback.sh self test
> 
>  V=0  - do not print any output at all
>  V=1  - print intro line, summary at end, and "FAIL"+Log for failing tests
>  V=99 - print everything + summary
> 
> code-wise, introduce test_start() / test_end() functions which do
> the $? check as well, so the actual testing code is streamlined.
> 
> v2:
>   replace indent tabs with spaces
>   change [ $V == 1 ] expression to [ $V = 1 ] (POSIXly correct)
> 

Acked-By: Frank Lichtenheld <frank@...2641...>

-- 
  Frank Lichtenheld


