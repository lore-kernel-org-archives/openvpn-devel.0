Date: Fri, 26 Aug 2022 14:16:34 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Ywi5ojRSrskeEQ2x@...2685...>
References: <20220826085427.25302-1-frank@...2641...>
 <20220826085427.25302-7-frank@...2641...>
 <YwiOFGImmAdwYEtF@...2685...>
 <a86c5fa5-b20b-6287-b6c1-9abe1f34a89d@...2181...>
MIME-Version: 1.0
In-Reply-To: <a86c5fa5-b20b-6287-b6c1-9abe1f34a89d@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 6/6] reformat for sp_arith=add
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, Aug 26, 2022 at 01:57:05PM +0200, Antonio Quartulli wrote:
> On 26/08/2022 11:10, Frank Lichtenheld wrote:
> > So this seems to misinterpret '*' and '&' after ')'.
> > This doesn't break compilation but is really ugly and confusing.
> > 
> > So NAKing my own patch ;)
> 
> This seems to be a bug in uncrustify :-(
> 
> Basically it thinks that & and * are arithmetic operators in some contexts
> and so it adds spaces around them. darn.
> 
> What version are you using?

Uncrustify-0.72.0_f from Ubuntu 22.04

-- 
  Frank Lichtenheld

