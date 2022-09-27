Date: Tue, 27 Sep 2022 11:24:09 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <YzLBOUAgo7WfWddz@...2685...>
References: <20220926081158.40640-1-gert@...1296...>
MIME-Version: 1.0
In-Reply-To: <20220926081158.40640-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] t_client: add per-instance arguments to
 fping
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

On Mon, Sep 26, 2022 at 10:11:58AM +0200, Gert Doering wrote:
> In addition to global FPING_EXTRA_ARGS now also evaluate
> FPING_ARGGS_<suffix>.
> 
> This can be used, for example, for a test instance for "will ToS-tagged
> packets be sent properly?" by setting FPING_ARGS_2="-O 0x10".
> 

Trivial change. Tested and looks good.

Acked-By: Frank Lichtenheld <frank@...2641...>

Regards,
-- 
  Frank Lichtenheld

