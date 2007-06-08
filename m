Message-ID: <9e0cf0bf0706081116l666d9461h787368264f6a5f14@...278...>
Date: Fri, 8 Jun 2007 21:16:48 +0300
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <3bca39c60706081106k4ecbef59j16fdd988fb1abead@...278...>
MIME-Version: 1.0
References: <3bca39c60706080647y13802064m35827220ba1b2ab6@...278...>
	<9e0cf0bf0706080654o477baec5m6593996efadd7c37@...278...>
	<3bca39c60706080711w3c072bcbs17ebd0a8e504b24f@...278...>
	<9e0cf0bf0706081021i327fd9a4xcb34ea06921e8c0e@...278...>
	<3bca39c60706081049t639e0dd3heffd906a5f41e9b6@...278...>
	<9e0cf0bf0706081057i6dcc519fob371b7ffec3dda61@...278...>
	<3bca39c60706081106k4ecbef59j16fdd988fb1abead@...278...>
Subject: Re: [Openvpn-devel] feature request: ability to pass pkcs#11 PIN
	via command line/config
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Richard Hartmann <richih.nospam@...1030...>, openvpn-devel@lists.sourceforge.net

On 6/8/07, Richard Hartmann <richih.nospam@...1030...> wrote:
> On 6/8/07, Alon Bar-Lev <alon.barlev@...277...> wrote:
> > You keep forgeting that attempting to authenticate to smartcard using
> > invalid PIN will eventually lock it.
>
> If there is only one PIN, that is not any threat. It either
> authenticates correctly or times out. In neither case is there a wrong
> PIN sent to the token.

If you use this PIN to authenticate by mistake to another token you
will lock this token.
If you remove and insert the token you should require
reauthentication, this is how smartcards should be used.

> I think it would be beneficial to every subscriber if we were to stop
> the debate about the philosophical differences we are having. This is,
> after all, a developer list.

Before you go and develop you need to soleve the philosophical issues.

> If you can point me to docs for setting up RAS correctly, I would
> gladly try that approach and report back to the list if and how this
> works via the new pkcs#11 interface.

http://msdn2.microsoft.com/en-us/library/ms832355.aspx

An OpenVPN GUI can be develop as a provider... This is the best
approach for Windows... This has nothing to do with PKCS#11, but will
solve your issues as well.

Best Regards,
Alon Bar-Lev.

