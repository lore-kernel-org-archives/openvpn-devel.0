From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] RPM build of 2.0-rc16 fails on MandrakeSoft
In-Reply-To: <42253BF4.1050000@...355...>
Message-ID: <Pine.LNX.4.58.0503021238020.23437@...41...>
References: <4220EC61.1000005@...355...> <Pine.LNX.4.58.0502270152590.23437@...41...>
 <42220B98.2010001@...355...> <42223300.1050402@...355...>
 <Pine.LNX.4.58.0502271404010.23437@...41...> <42253BF4.1050000@...355...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Mar  2 11:55:26 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: TomWalsh <tomw-junk01@...355...>
Cc: openvpn-devel@lists.sourceforge.net


On Tue, 1 Mar 2005, TomWalsh wrote:

> James Yonan wrote:
> >>I will let the package maintainer of liblzo1 of the problem of it not 
> >>saying it provides "liblzo" while the liblzo1-devel does say that.
> >>
> >>The correct statement which works around the Mandrake 10.1 problem would be:
> >>
> >>============================ fix ===============================
> >>%if "%{_vendor}" == "MandrakeSoft"
> >>%{!?without_lzo:BuildRequires: liblzo1-devel >= 1.07}
> >>%{!?without_lzo:Requires:      liblzo1       >= 1.07}
> >>%else
> >>%{!?without_lzo:BuildRequires: lzo-devel >= 1.07}
> >>%{!?without_lzo:Requires:      lzo       >= 1.07}
> >>%endif
> >>============================ snip ==============================
> >>
> >>Either way, there would still be an issue with Mandrake as I see that 
> >>the lzo package of SuSE 9.1 provides "lzo" not "liblzo".
> > 
> > 
> > The problem I have with this patch is that it assumes that Mandrake will
> > continue to follow the broken behavior.  The ideal solution would be one
> > which doesn't break when Mandrake gets around to using the same standard
> > LZO RPM spec which everyone else is using.
> > 
> 
> Yeah, probably the best solution. However, I see that they have been 
> calling it liblzo1 since their 8.1 distro, and, technically, it is a 
> library?

True, but SuSE and RH/Fedora both use "lzo" and "lzo-devel" as the
provider names.  That seems reasonable, as prepending a "lib" to the
provider names for all libraries would render most RPM .spec files
incompatible.

Any guidance from LSB?

James


