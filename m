Date: Tue, 16 May 2023 14:33:59 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZGN4NxpwkXiVPGOY@...2685...>
References: <20230516024232.2680491-1-selva.nair@...277...>
 <202305161121.34GBLYKq047134@...2054...>
MIME-Version: 1.0
In-Reply-To: <202305161121.34GBLYKq047134@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Correctly handle Unicode
 names for exit event
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
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel@lists.sourceforge.net

On Tue, May 16, 2023 at 01:21:34PM +0200, Gert Doering wrote:
> Explanation makes sense, though it's only relevant for "outside openvpn GUI"
> use cases.  But I look forward to a submission of "openvpn windows CLI" :-)
> 
> Test compiled on MinGW.  Does our GH windows test setup use the event
> mechanism?  Or "classic signals"?

Neither, it uses the GUI CLI :)
See https://github.com/OpenVPN/openvpn-windows-test/blob/master/Start-LocalTest.ps1#L342

Regards,
-- 
  Frank Lichtenheld

