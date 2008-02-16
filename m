Message-ID: <9e0cf0bf0802161014j6de5ddd2l37f42bbd835d4a90@...278...>
Date: Sat, 16 Feb 2008 20:14:08 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <4aff28800802160957i114f38f4o2fdd483a780ff203@...278...>
MIME-Version: 1.0
References: <4aff28800802160916r506572a0r44a9e619e31ce5ee@...278...>
	<9e0cf0bf0802160925w2dd86c02mb6f8dd5cfd4ab9e5@...278...>
	<4aff28800802160957i114f38f4o2fdd483a780ff203@...278...>
Subject: Re: [Openvpn-devel] Compiling OpenVPN 2.1rc7
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
To: Diaa Sami <diaasami@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On 2/16/08, Diaa Sami <diaasami@...277...> wrote:
> Alon Bar-Lev wrote:
> > I can't help you with the none standard build system of OpenVPN and
> > dependencies.
>
> Why is this a non-standard build system, I thought it was.
> if it isn't then what's the standard build system for Windows?

Should be one autoconf/automake for all platforms.
But James rejects this.

> > But I can help with the pkcs11-helper issue.
> >
> > Can you please provide config.log of that build?
>
> please find it attached
>

I see nothing wrong here...
Can you please remove ac_cv_type_size_t=no and --disable-static from configure?
And also end me the complete build log?

Thanks!
Alon.

