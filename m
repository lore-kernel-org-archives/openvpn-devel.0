Message-ID: <459DB186.1000505@...334...>
Date: Fri, 05 Jan 2007 04:01:42 +0200
From: Faidon Liambotis <paravoid@...334...>
MIME-Version: 1.0
References: <20070103073706.GA11588@...997...>	
	<9e0cf0bf0701031135ye497473tf9b18cc2037fbca5@...278...>	
	<459CD3BD.4010506@...334...>
	<9e0cf0bf0701041007x675e4d5cobbe2e8e5fae143c9@...278...>
In-Reply-To: <9e0cf0bf0701041007x675e4d5cobbe2e8e5fae143c9@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Use CryptoAPI to verify certificates
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Alon Bar-Lev wrote:
> If you integrate into Microsoft trust providers, you should also
> support CTL and such. So that the Domain/Computer policy will be
> applied to OpenVPN.
After a bit of googling, I can know *guess* what you mean.
I'm no Microsoft expert or developer -and I don't want to be, to be
honest- so correct me if I'm wrong.
I think that my code already does that; the default certificate chain
engine mentions CTLs[1] and how I could limit them so I can guess that
they *are* used.
If you (or anybody else) have access to a such domain, I would love some
feedback to my patch.

Regards,
Faidon


1: http://msdn2.microsoft.com/en-us/library/aa377184.aspx

