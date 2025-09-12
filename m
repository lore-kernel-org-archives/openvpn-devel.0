Date: Fri, 12 Sep 2025 15:08:46 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <aMQbXj2QMgTHii+x@...2685...>
References: <gerrit.1754490554000.Ic88cd6e143bc48cab3c9ebb7c7007513803bd199@...2715...>
 <20250911201719.25773-1-gert@...1296...>
MIME-Version: 1.0
In-Reply-To: <20250911201719.25773-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v8] openvpn_PRF: Change API to use
 size_t for lenghts
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

On Thu, Sep 11, 2025 at 10:17:13PM +0200, Gert Doering wrote:
> From: Frank Lichtenheld <frank@...2641...>
> 
> Basically all users already wanted that anyway. And most
> of the library functions also take size_t nowadays.
> 
> Change-Id: Ic88cd6e143bc48cab3c9ebb7c7007513803bd199
> Signed-off-by: Frank Lichtenheld <frank@...2641...>
> Acked-by: MaxF <max@...2606...>

Just noticed the typo "lenghts" in the subject line. Maybe
you could fix this before merge?

Regards,
-- 
  Frank Lichtenheld

