Resent-To: "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>
Resent-Message-ID: <5745E29A.8060204@...1127...>
References: <1464130427-25002-1-git-send-email-selva.nair@...277...>
	<57457A80.4030506@...2080...>
	<CAKuzo_jawxTrgwQtzOhb7vqHJ3LEvULjPNphTRugYmyWMZenSQ@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <5745D00F.1030309@...2080...>
Date: Wed, 25 May 2016 18:17:19 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jawxTrgwQtzOhb7vqHJ3LEvULjPNphTRugYmyWMZenSQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Pass echo option to systemd-ask-password
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>

On 25/05/16 17:27, Selva Nair wrote:
> 
> Well, if a major rewrite of console input is planned, consider
> replacing getpass() as well. It has arbitrary password length
> limitations on some platforms. At the same time I'm not sure I
> understand the need for this overhaul.

Currently the interface is basically stdio/stdout.  But with a more
modular API for querying user, you can enable more fancy ways of
querying the user.  In the systemd team, they're talking about moving
away from systemd-tty-ask-password's API to a DBus oriented API (but it
is dragging, as they can't do that without kdbus in place for querying
users at boot time).  The idea is that OpenVPN should be completely
agnostic to if the user input is from a tty console or a fancy graphical
GUI.  The OS/distribution just needs to support a method through this API.

The other advantage this new API has is that it can be expanded to ask
for all the information at once, instead of the current sequential
approach (first username, then password, then key passphrase or PKCS11
PIN, etc, etc).  I've barely started looking at that, but I would need
to get the overall API in place first before starting to rearrange the
code sections where OpenVPN needs user input.

So combined, it can support a more simpler interaction with the OpenVPN
daemon.

In regards to the getpass() issues, that should be possible to improve
though.

> Your patch has
> 
> +#if SYSTEMD_VERSION > 216
> +    if( echo )
> +    {
> +argv_printf_cat(&argv, "--echo");
> +    }
> +#endif
> 
> How would such a compile time check be any useful -- the version will
> have to be checked at run-time, isn't it?
> 
> So, should I withdraw the patch or try to fix it by hacking up a
> run-time version check?

There exists no way to query at runtime which version systemd is running
(or at least it didn't when I started poking at that).  And it was
considered that if you have version newer than 216 you would never
downgrade systemd, so a compile time check would generally be good
enough.  This works at least very well in the RHEL/Fedora build
environments where all builds happens in chroots managed by mock, where
the buildroots have the same package versions installed as the
distribution the build is targeted at.


-- 
kind regards,

David Sommerseth


