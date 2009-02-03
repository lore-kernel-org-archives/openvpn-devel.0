MIME-Version: 1.0
In-Reply-To: <499929A843E2C541A8AD31A881A2B6A202DF3E70@...1006...>
References: <499929A843E2C541A8AD31A881A2B6A202DF38BE@...1006...>
	<200902021218.12326.alon.barlev@...277...>
	<499929A843E2C541A8AD31A881A2B6A202DF3E70@...1006...>
Date: Tue, 3 Feb 2009 20:12:47 +0200
Message-ID: <9e0cf0bf0902031012x6e2c8504s315bf673a3f46fcf@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Diff format
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
To: David Balazic <David.Balazic@...1005...>
Cc: openvpn-devel@lists.sourceforge.net

There had been multiple issues.
You can investigate last posting and find what exactly was the problem.
I truly don't care.
It did not apply.
Alon.

On 2/3/09, David Balazic <David.Balazic@...1005...> wrote:
>   They must be using a custom version or something strange like that.
>  The
>  TAB is placed there by the routine 'print_context_label()' in context.c,
>  you
>  can view the CVS history at
>
>  http://cvs.savannah.gnu.org/viewvc/diffutils/src/context.c?root=diffutil
>  s&view=log
>
>  and it's been right there since version 1.1, seventeen years ago (see
>  line 46).
>
>   So AFAICT GNU diff has /always/ done this.
>
>
>  Regards,
>
> David
>

