Message-ID: <4FA3E99B.10309@...515...>
Date: Fri, 04 May 2012 17:37:15 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <CAAhp1KAp8DDJvgE9CTDST8HEGO4HTiMDmv88sTMpNxtWptyX+g@...278...>
	<CAOazyz35GLCBFFBfZe8KfXZerozZt3ULYD03mFtbhkS6ruxWDg@...278...>
	<CAAhp1KAyH3MkeAn7YS_E1474mUbjzTMeqztFNmc-RKD6JZgTyw@...278...>
	<CAAhp1KCJBqZfjKTRC28wk6g5Bkj=-8cP_oe--cY+cJ82-paNsw@...278...>
	<20120503071459.GM1359@...1296...>
	<CAAhp1KCovS4w-+tvPeaHA8xW8v4+KKmCD+Nt2XVjmkKdSuJG4g@...278...>
	<4FA27940.3080104@...1114...>
In-Reply-To: <4FA27940.3080104@...1114...>
Subject: Re: [Openvpn-devel] Does OpenVPN Support Unicode Username and
	Password
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>
> There should also be no issues using the Community Edition on the
> client side against an Access Server installation, if that is an
> alternative.
I use latest development code against AS-based servers (incl. Private
Tunnel servers) if not daily, at least weekly, and it works great. You
can you use the configuration files from OpenVPN Connect client with
your stock OpenVPN installation.

It should also be possible to replace the 2.1.x-based OpenVPN in OpenVPN
Access Server with latest community development version, as most of the
AS-specific stuff from James' SVN tree is included in our community
development versions. However, the AS frontend itself is not yet updated
to cope with new features such as IPv6.

If you need features that are in OpenVPN development version but are
missing from AS/OpenVPN Connect client, you should definitely let the
company know that through their official support channels.

Samuli

