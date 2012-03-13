MIME-Version: 1.0
Sender: fabian@...1547...
In-Reply-To: <70094734.yG4fYDZvM3@...1526...>
References: <4F4CE4FE.3010009@...515...> <4F5E08D2.2040302@...515...>
	<CAOazyz0mnZZVbGiMxmkn_JW5+yZ8AUeejeVWi0pMbu9okieRpw@...278...>
	<70094734.yG4fYDZvM3@...1526...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Tue, 13 Mar 2012 13:55:23 +0100
Message-ID: <CAP+U6tJaseSTk4D8Oh9Vk2f+7+CDMqfXR_8r8FC8joa-9e-dUg@...278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
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
To: Heiko Hund <heiko.hund@...1489...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, =?UTF-8?Q?Carsten_Kr=C3=BCger?= <C.Krueger@...448...>, openvpn-devel@lists.sourceforge.net

Hi,

2012/3/13 Heiko Hund <heiko.hund@...1489...>:
> On Monday 12 March 2012 19:01:41 Alon Bar-Lev wrote:
>> What is the baseline? This what we should agree first...
>> Should openvpn daemon be run on completely unprivileged account or not.
>
> I don't support the idea about running openvpn.exe with elevated privileges.
> It has been run as the user before and that worked fine until Microsoft
> limited access to system resources in Vista. The service approach with the
> elevation pipe solves exactly that problem.

I agree that being able to run openvpn in an unprivileged account is a
worthwhile goal. The GUI/service-proposal does not appear to achieve
that while the other two do.

For regular desktop systems the unprivileged account could potentially
be the interactive users account. For enterprise systems, the
unprivileged account should probably be separate from the interactive
user's account. Only the COM+ approach appears to achieve the latter
requirement.  Of course, the GUI/service-proposal could be combined
with the interactive service proposal to achieve something quite
similar. (I don't see the interactive service proposal as sufficient
for the enterprise case, because the user still has too much control
over the connection (where to connect, what scripts to run, etc.))

Cheers
Fabian

