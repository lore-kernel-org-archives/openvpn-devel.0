MIME-Version: 1.0
In-Reply-To: <CAEsd45QsjHX19m8kFsTEixyk1O9VB7gn25rj7aarSe9vuvahXw@...278...>
References: <1340730302-3077-1-git-send-email-alon.barlev@...277...>
	<CAEsd45QsjHX19m8kFsTEixyk1O9VB7gn25rj7aarSe9vuvahXw@...278...>
Date: Wed, 18 Jul 2012 16:37:39 +0300
Message-ID: <CAOazyz15sK3xpvvRu3i86o8BXZ4hk09faxNAQJ_CHsYzdsL7kw@...278...>
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
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Nobody disables the absolute path use.
This patch permits relative use.

On Wed, Jul 18, 2012 at 3:44 PM, Jonathan K. Bullard
<jkbullard@...277...> wrote:
> On Tue, Jun 26, 2012 at 1:05 PM, Alon Bar-Lev <alon.barlev@...277...> wrote:
>>
>> Currently openvpn requires/endorses specifying full path in plugin
>> parameter. As build system already aware of plugin location, it is
>> possible to load plugin relative to this directory, so full path is not
>> required nor more secured.
>>
>> Windows is a little more complex as user may change installation
>> directory at install time, so we read plugindir location from the
>> registry, installer will set this value.
>
>
> (Sorry Alon, I must have overlooked this when it was first posted.)
>
> I do not understand the privilege escalation risk:
>
> A protected (not writable by an unprivileged user) part of Tunnelblick
> controls the options sent to any instance of OpenVPN that runs as a
> privileged user, so it sends only acceptable paths. (A computer
> administrator is the only one who can modify a configuration file, which is
> the other means of specifying a plugin path.)
> If a user runs an instance of OpenVPN from the OpenVPN binary inside of
> Tunnelblick, it runs as the user. So it's not very different form running it
> from the command line.
>
> Aren't other installations of OpenVPN similarly protected? Or are you trying
> to protect against poorly-protected installations?
>
> Or can the server "push" a plugin path? If allowed (I don't think it should
> be) that is a much bigger problem.
>
> Disallowing absolute paths complicates things enormously for Tunnelblick
> (OpenVPN GUI for OS X) for two reasons:
>
> You can have multiple, different copies of Tunnelblick (it is
> self-contained), and
> Each copy of Tunnelblick contains multiple versions of OpenVPN, each with
> its own copy of the down-root plugin.
>
> Currently, Tunnelblick just sends a plugin path which points to the
> appropriate plugin file inside the application itself (an OS X application
> like Tunnelblick is basically a folder with stuff inside it).
>
> If absolute paths are not allowed, Tunnelblick will apparently have to start
> "installing" plugins in a system-wide directory, and track separate copies
> of the down-root plugin by their source (i.e., the specific copy of
> Tunnelblick, and the specific version of OpenVPN the down-root plugin comes
> from. It would also be impossible to deal with a user moving the Tunnelblick
> application somewhere else in the file hierarchy (Most OS X applications,
> including Tunnelblick can be moved around as the user pleases.)
>
> That seems like so much trouble (and has a risk of creating a DLL-hell
> equivalent) that I will probably drop support for the down-root plugin from
> Tunnelblick. I don't think that's a big problem, but it will be for some
> users, and they won't be able to script their way around it.
>

