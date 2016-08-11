References: <1470684488-21307-1-git-send-email-davids@...515...>
	<1470684488-21307-4-git-send-email-davids@...515...>
	<CAKuzo_jZtCO1df5f3EWFPtEwgDsdOcB4jH9q=Co4Ye8WG5urcg@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <b769e14d-3e0b-4e36-380a-d2de4e3cf014@...2080...>
Date: Thu, 11 Aug 2016 16:20:20 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jZtCO1df5f3EWFPtEwgDsdOcB4jH9q=Co4Ye8WG5urcg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v4 3/4] autotools: Add support for
 extracting version information from pkg-config modules
Reply-To: openvpn-users@lists.sourceforge.net
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
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 11/08/16 08:45, Selva Nair wrote:
> Hi,
> 
> I missed this patch -- must have deleted from the inbox by mistake. So
> that explains my silly comment about pkg.m4 in a previous mail.
> 

:)

[...snip...]

> PKG_CHECK_EXISTS( [libsystemd > 216],
>                      [AC_DEFINE([SYSTEMD_ASKPASS_HAS_ECHO], [1],
>                            [systemd-ask-password supports --echo option])]
>                     )
> 
> Then add --echo only if SYSTEMD_ASKPASS_HAS_ECHO is defined.

I thought I had tested this approach too and that it failed, hence this
patch updating pkg.m4 and all these other hacks; I knew it was hacky but
it was something which worked across several of my test boxes at that
time.  But when I test it now, it works very fine on both Fedora 23 and
SL7.2 (RHEL7.2 clone).  Well, it's about a year since I fought this, and
patch 3+4 have mostly been unchanged isince then.

As this approach is far better, I'll retract patch 3 and update patch 4
to use this approach instead.  I'll name the macro a bit different
though (SYSTEMD_NEWER_THAN_216), as that reflects more what this
pkg-config check does.

So we can completely disregard "[PATCH v4 3/4] autotools: Add support
for extracting version information from pkg-config modules".


-- 
kind regards,

David Sommerseth
OpenVPN Technologies, Inc


