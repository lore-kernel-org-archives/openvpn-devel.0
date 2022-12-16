Date: Fri, 16 Dec 2022 14:04:12 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y5xszM2URafWhYVP@...2685...>
References: <CAKuzo_gXCuTLmVixX_4r3pNfzTs2+hsX89w7EqsxxGrRq0F-Gg@...278...>
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gXCuTLmVixX_4r3pNfzTs2+hsX89w7EqsxxGrRq0F-Gg@...278...>
Subject: Re: [Openvpn-devel] Linking to GUI changes in release announcements
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Wed, Dec 07, 2022 at 05:01:30PM -0500, Selva Nair wrote:
> Hi,
> 
> Now that we have a shiny, newly updated, CHANGES.rst file for the GUI, it
> may be useful to link to it in future release announcements:
> 
> https://github.com/OpenVPN/openvpn-gui/blob/master/CHANGES.rst
> 

Done.

> Although almost all new features in the GUI were made available
> incrementally, one feature new in 2.6 (not installed in 2.5.x releases) is
> the PLAP support. Here is a possible description of this feature:
> 
> - Pre-logon access provider: supports starting of connections from the
> login screen before the user logs in. Useful when connection to a domain
> controller via a VPN tunnel is required for login.

We have it already mentioned in the list of new features, although in
much shorter form (which is consistent with the amount of description
we have for other features).

Maybe it would be useful to make the descriptions of the features more
verbose in general. I will take a stab at that for Beta3.

Regards,
-- 
  Frank Lichtenheld

