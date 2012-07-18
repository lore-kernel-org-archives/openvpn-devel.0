MIME-Version: 1.0
In-Reply-To: <9202180.5BEupnUWkl@...1526...>
References: <1340730302-3077-1-git-send-email-alon.barlev@...277...>
	<9202180.5BEupnUWkl@...1526...>
Date: Wed, 18 Jul 2012 16:34:42 +0300
Message-ID: <CAOazyz1JWMxzhq8KC=ChtRDFD+q0V3dZnE-sNb7JEGKFD9OjvQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] plugin: load plugin relative to
	plugindir
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
Cc: openvpn-devel@lists.sourceforge.net

Hi!

On Wed, Jul 18, 2012 at 2:44 PM, Heiko Hund <heiko.hund@...1489...> wrote:
> Hi Alon
>
> On Tuesday 26 June 2012 20:05:02 Alon Bar-Lev wrote:
>> Currently openvpn requires/endorses specifying full path in plugin
>> parameter.
>
> Specifying a custom full path is probably something we need to ban in the
> (near) future, as it imposes an attack vector for privilege escalation by code
> injection when openvpn is not running as another user or has access to
> privilege escalation by other means (like the yet to be submitted Windows
> interactive service).
>
> This patch is a step towards this so I think it's absolutely worth a feature
> ACK.
>
>>  AM_CFLAGS = \
>> +     -DOPENVPN_PLUGINDIR="\"$(plugindir)\"" \
>
> Couldn't OPENVPN_PLUGINDIR be an AC_DEFINE in config.h instead? Would keep the
> command line shorter and more readable.
>
>> +         if (ExpandEnvironmentStringsW(plugindir, _plugindir_expanded,
> SIZE(_plugindir_expanded)) != 0)
>
> There's _countof defined in the Windows headers that could replace the non-std
> SIZE here. I had to look SIZE() up. It does the right thing, though.
>
>> +      _snwprintf(_abs_so_pathname, SIZE(_abs_so_pathname), L"%s%C%s",
>> plugindir, OS_SPECIFIC_DIRSEP, wide_string(p->so_pathname, &gc));
>
> You need to make sure _abs_so_pathname is zero terminated here. However, I
> found that _snwprintf does not return a negative value when the buffer is too
> small. Contrary to http://msdn.microsoft.com/en-us/library/2ts7cx93.aspx
> So, this could need more research to get right.

Thank you so much!
I did not know sn*printf of MS are not C99 complaint!

Alon.

