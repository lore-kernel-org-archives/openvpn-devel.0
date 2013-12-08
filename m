MIME-Version: 1.0
In-Reply-To: <20131208080103.GF161@...1296...>
References: <CAFHpkQEdec39CQFOr7M3=+1yDi4myTtoHBdankg9NRnF-ZhzoQ@...278...>
	<20131207204434.GE161@...1296...>
	<CAFHpkQGfAgCNBeiucw=h-6xds6QuBSNNEzyJ-Tf1LRMNd3FkZA@...278...>
	<20131208080103.GF161@...1296...>
Date: Sun, 8 Dec 2013 14:49:56 +0600
Message-ID: <CAFHpkQGh1C39SE2ShuyGLo7bJjYHFfTaCRSqJcAi-HMWLnDWjQ@...278...>
From: =?KOI8-R?B?6czY0SD7ydDJw8nO?= <chipitsine@...277...>
Subject: Re: [Openvpn-devel] uninitialized handle fix (serious bug on Win
	8.1), another attempt
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

ok, you suggest to initialize orig_stderr.
initialize with what ?

what value of orig_stderr should mean

a) "no stderr redirection requested, return GetStdHandle (STD_ERROR_HANDLE)"
b) "stderr redirection was requested, return orig_stderr"

as Matthias Andree said, neither NULL, nor INVALID_HANDLE are good for
"a)", those might me special cases and mean something different in
terms of handles

but if you see better solution, just provide it, I do not mind.

2013/12/8 Gert Doering <gert@...1296...>:
> Hi,
>
> On Sun, Dec 08, 2013 at 11:27:50AM +0600, ???? ??????? wrote:
>> Ok, your suggestion?
>
> "initialize orig_stderr"?
>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //www.muc.de/~gert/
> Gert Doering - Munich, Germany                             gert@...1296...
> fax: +49-89-35655025                        gert@...1297...

