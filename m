Date: Mon, 30 Oct 2023 18:08:53 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZT/jJfxqii8YkT7W@...2685...>
References: <20230130172936.3444840-1-arne@...1227...>
 <20230130172936.3444840-2-arne@...1227...>
 <Y9j0nUnSCoCd1YkU@...2685...>
MIME-Version: 1.0
In-Reply-To: <Y9j0nUnSCoCd1YkU@...2685...>
Subject: Re: [Openvpn-devel] [PATCH 2/5] Fix unaligned access in
 macOS/Solaris hwaddr
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, Jan 31, 2023 at 11:59:41AM +0100, Frank Lichtenheld wrote:
> On Mon, Jan 30, 2023 at 06:29:33PM +0100, Arne Schwabe wrote:
> > The undefined behaviour USAN clang checker found this.
> > 
> > This fix is a bit messy but so are the original structures.
> > 
> 
> Acked-By: Frank Lichtenheld <frank@...2641...>
> 
> Well, it doesn't make it worse vOv

Note: I revoke this ACK. Would need to verify first whether we
need further changes similar to what Arne did in OpenVPN3:
https://github.com/OpenVPN/openvpn3/commit/b755783a13257237f85d633fe2ae60e4118415a0

Regards,
-- 
  Frank Lichtenheld

