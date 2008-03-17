Message-ID: <9e0cf0bf0803170622l69560ba5y64b11a909cf3a9cf@...278...>
Date: Mon, 17 Mar 2008 15:22:30 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <2e08ab000803170615v5939a6cfy59719674aea7698f@...278...>
MIME-Version: 1.0
References: <47DD4B14.5060009@...1081...>
	<9e0cf0bf0803161105u71b7afc0tc90fed05da57f0dc@...278...>
	<2e08ab000803170102k5b4070baw43fb555e75e79bff@...278...>
	<9e0cf0bf0803170553y4ca5608v41a26130568ce8bb@...278...>
	<2e08ab000803170615v5939a6cfy59719674aea7698f@...278...>
Subject: Re: [Openvpn-devel] patch pkcs11 dynamic key id detection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Christophe Vandeplas <christophe@...1081...>
Cc: Peter Koch <pk@...1082...>, openvpn-devel@lists.sourceforge.net, James Yonan <jim@...41...>

On 3/17/08, Christophe Vandeplas <christophe@...1081...> wrote:
>  I'll have a deeper look at your management patch, maybe I can find a
>  way to add the pkcs11-match principle in your code with almost no
>  extra complexity and redundant code.
>  Do you think it's worth the effort? Or better wait for the results and
>  feedback from the management part?

I think that what is missing for Windows user is a good OpenVPN GUI.
A simple tray icon with context menu that enable the user to
connect/disconnect/authenticate/select certificate/prompt for ok

Many Windows users expects this for a long time... And I know that implementing
such using .NET framework is easy... Some forms, socket and state machine.

This OpenVPN GUI can be extensible so it may call a plugin before user
interaction
so sysadmins can configure some of its behavior.

I think that if you wish to invest some efforts for Windows, I think
this is the place :)

Alon.

