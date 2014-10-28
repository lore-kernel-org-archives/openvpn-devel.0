Message-ID: <544F57C1.4060901@...1227...>
Date: Tue, 28 Oct 2014 09:45:53 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <544EC052.3080809@...1435...>
In-Reply-To: <544EC052.3080809@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Add --tls-version-max option
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
To: Steffan Karger <steffan.karger@...1435...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 27.10.14 22:59, schrieb Steffan Karger:
> Hi,
>
> Since I had to miss the most recent IRC meeting, I'll just put this on
> the mailinglist.
>
> OpenVPN has used TLSv1.0 exclusively for a long time. A few months ago,
> TLS version negotiation was added for OpenSSL builds (PolarSSL builds
> already had version negotiation), but that triggered quite some problems
> at our users. For example, our cryptoapi implementation doesn't support
> TLSv1.2 and some external PKCS#11 libraries and tokens refuse to create
> TLSv1.2 signatures (which we can't fix ourselves).
>
> To ease the transition, while we and external vendors fix the various
> problems, I propose to add an option '--tls-version-max', similar to the
> current '--tls-version-min'. That will enable users to e.g. use TLSv1.1
> on the clients that won't work with 1.2. At least for one of the
> problematic setups I encountered, this was a nice way out.
>
> Attached are two patches that do just that for the 2.3 and master branches.
>
> Of course this should not stop us from fixing problems with TLSv1.2 (at
> least the problems we actually can fix...).
ACK. TLS 1.0-1.1 is better than TLS 1.0 only because TLS 1.2 does not work.

I think if this gets commited cryptoapicert should set max-tls-version
to 1.1 and warn accordingly.

Arne

-- 
Arne Schwabe, M.Sc. - http://www.uni-paderborn.de/cs/cn/
Computer Science, University of Paderborn, Germany,  +49 5251 60-1756



