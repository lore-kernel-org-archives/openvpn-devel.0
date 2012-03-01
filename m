MIME-Version: 1.0
In-Reply-To: <2202832.nbUQuJyuNX@...1526...>
References: <4F4CE4FE.3010009@...515...> <12822827.2NuMshZZBO@...1526...>
	<CAOazyz06Ba-FLzm2i15we1tt4tkvV=gzQBadh0TuhzfPWLQW9A@...278...>
	<2202832.nbUQuJyuNX@...1526...>
Date: Thu, 1 Mar 2012 11:36:07 +0200
Message-ID: <CAOazyz2X5qbL4M1EktJ71WX0Qfmga9Af5Wg6=sAJUZaKH20isA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
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
Cc: =?UTF-8?Q?Carsten_Kr=C3=BCger?= <C.Krueger@...448...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Thu, Mar 1, 2012 at 11:24 AM, Heiko Hund <heiko.hund@...1489...> wrote:
>
> On Thursday 01 March 2012 09:22:38 Alon Bar-Lev wrote:
> > Also, (technically) impersonation token cannot be used for network
> > access.
> > So the solution of impersonating to user will not allow a script to
> > mount remote filesystem.
>
> You can't create a process with an impersonation token that's why a
> primary
> token is used.

How do you create primary token of user without him typing his
credentials again? or add the user "replace token" privilege?

Anyway, I am curios to read your view about the alternate solution I suggested.

Alon.

