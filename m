MIME-Version: 1.0
In-Reply-To: <201004281638.57498.hhund@...194...>
References: <4BD83FC0.5090607@...515...> <1272463949884053500@...1315...>
	<n2n9e0cf0bf1004280724s6c4280c6xb58950c706123e4c@...278...>
	<201004281638.57498.hhund@...194...>
Date: Wed, 28 Apr 2010 17:45:47 +0300
Message-ID: <r2n9e0cf0bf1004280745v8f0d3cc9t439f516b6d06cb4@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Any volunteer Windows devs to change OpenVPN
	proxying code to use "new" InternetQueryOption API?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Heiko Hund <hhund@...194...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, Apr 28, 2010 at 5:38 PM, Heiko Hund <hhund@...194...> wrote:
> On Wednesday 28 April 2010 16:24:31 Alon Bar-Lev wrote:
>> The IE API is user specific.
>> As OpenVPN runs as a service using own user or system account, IE API
>> is not suitable.
>
> Sadly I haven't found the WinHttpGetProxyForUrl API in MinGW W32API. So, use
> of this might rather be a long-term goal as it takes a while to get it
> included.

No problem to add simple prototypes and perform GetProcAddress().

> If the service is started by the GUI it still makes sense to use user specific
> proxy settings, doesn't it? One could consider auto-proxy for auto-started
> VPNs a misconfiguration, as well. Or am I mislead?

If this is a service that is started, it cannot access your proxy
without more tweaks.
If the GUI runs the OpenVPN.exe in the user context (user with
administrative permission) it is fine.

Alon.

