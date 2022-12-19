Date: Mon, 19 Dec 2022 16:33:41 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y6CEVeM0chP61V96@...2685...>
References: <20221218195810.1216368-1-selva.nair@...277...>
 <20221219150435.1222451-1-selva.nair@...277...>
MIME-Version: 1.0
In-Reply-To: <20221219150435.1222451-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] Reduce default restart pause to 1
 second
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
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Dec 19, 2022 at 10:04:35AM -0500, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
> 
> Current value of restart pause is 5 seconds which feels
> unduly long. Reduce it to 1 second.
> 
> User can still customize the delay using the first parameter for
> "--connect-retry".
> 
> Also improve the description of "--connect-retry" in the
> man page.
> 
> v2 changes:
> - fix incomplete man page edit as pointed out by Arne Schwabe
> - fix man page (rst) changes as suggested by Frank Lichtenheld
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
> I've changed the rst edits following how other similar options
> are described -- though I do not like referring to 'arg' as 'n'
> first and then "explaining" it in valid-syntaxes...
> Will be happy to revise if there is a better way.

Yeah, I really looked for alternatives when I first learned about
this limitation. Because it is very annoying. But I didn't find any.

Acked-By: Frank Lichtenheld <frank@...2641...>

Regards,
-- 
  Frank Lichtenheld

