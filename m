MIME-Version: 1.0
References: <1552943809-6367-1-git-send-email-selva.nair@...277...>
 <5a54b7c9-d466-c8c2-e468-42c16c88d1dd@...277...>
 <2bf767b9-8459-c0bf-3914-9afaee3093f8@...2181...>
In-Reply-To: <2bf767b9-8459-c0bf-3914-9afaee3093f8@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 20 Mar 2019 09:25:44 -0400
Message-ID: <CAKuzo_hbxCOTP_y1_4-i-=8WseuxbnjCEpTkgO5tF=oTcO+W_g@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Improve the documentation for
 --dhcp-option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>
Cc: tincanteksup <tincanteksup@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Wed, Mar 20, 2019 at 4:02 AM Antonio Quartulli <a@...2181...> wrote:
>
> Hi,
>
> On 18/03/2019 22:30, tincanteksup wrote:
> > Hi,
> >
> > this situation has been hanging around for so long is this brief note
> > really enough? Considering that the manual has numerous other URLs why
> > not include this URL here:
> > https://community.openvpn.net/openvpn/wiki/Pushing-DNS-to-clients
> >
> > We already have this:
> > https://community.openvpn.net/openvpn/wiki/SWEET32
> >
>
> the problem with URLs is that they become obsolete and we need to
> re-patch the manual in order to update them (or ensure the URL always
> work/redirect to something).


I have the same opinion about URLs. On top of that the wiki
description is inadequate and inaccurate. But that's a different
topic.

The patch was meant to remove the ambiguity in the current
wording. We could add a line saying many distributions include
such scripts and front-ends such as network manager, tunnelblick,
OpenVPN for Android etc. also handle some dhcp-options. (I don't use
any of them, so guessing here..)

>
>
> However, I was thinking that a WARNING in the log when parsing a
> dhcp-option without any script configured (on non-windows platform) may
> also be beneficial.

This would catch some obvious cases but not when a script is being
used for some other purpose. Still, sounds useful.

Selva

