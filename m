From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] RPM build of 2.0-rc16 fails on MandrakeSoft
In-Reply-To: <20050311092251.GB14692@...33...>
Message-ID: <Pine.LNX.4.58.0503110939510.2608@...41...>
References: <4220EC61.1000005@...355...> <Pine.LNX.4.58.0502270152590.23437@...41...>
 <42220B98.2010001@...355...> <42223300.1050402@...355...>
 <Pine.LNX.4.58.0502271404010.23437@...41...> <42253BF4.1050000@...355...>
 <Pine.LNX.4.58.0503021238020.23437@...41...> <42307C7C.3010804@...355...>
 <20050311092251.GB14692@...33...>
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
Date: Fri Mar 11 08:49:01 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Matthias Andree <matthias.andree@...68...>
Cc: TomWalsh <tomw-junk01@...355...>, openvpn-devel@lists.sourceforge.net


On Fri, 11 Mar 2005, Matthias Andree wrote:

> On Thu, 10 Mar 2005, TomWalsh wrote:
> 
> > >True, but SuSE and RH/Fedora both use "lzo" and "lzo-devel" as the
> > >provider names.  That seems reasonable, as prepending a "lib" to the
> > >provider names for all libraries would render most RPM .spec files
> > >incompatible.
> > >
> > >Any guidance from LSB?
> > >
> > No, LSB seems to deal with more basic issues of the O/S.  What you could 
> > consider the "primatives" of a GNU/Linux systems contents.  Nothing as 
> > far reaching as naming conventions for packages other than the minimum 
> > requisite packages to start & run a basic Linux system, RPM 
> > construction, etc.
> 
> RPM appears to, at least on Red Hat and Novell/SUSE derived machines,
> support the libraries' ELF SONAME, too, which is what my former
> suggestion has been about, and AFAICS, the soname is the same on all
> machines, namely liblzo.so.1 (use readelf -d to figure).

Shorter term, because 2.0 final is so close, I don't want to change 
anything in the .spec except for stuff which is bracketed by %if 
"%{_vendor}" == "MandrakeSoft".

James

