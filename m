MIME-Version: 1.0
References: <1552943809-6367-1-git-send-email-selva.nair@...277...>
 <5a54b7c9-d466-c8c2-e468-42c16c88d1dd@...277...>
 <2bf767b9-8459-c0bf-3914-9afaee3093f8@...2181...>
 <CAKuzo_hbxCOTP_y1_4-i-=8WseuxbnjCEpTkgO5tF=oTcO+W_g@...278...>
 <f4674758-5cf1-b725-c0cf-5f6b4ae3f9fd@...1227...>
In-Reply-To: <f4674758-5cf1-b725-c0cf-5f6b4ae3f9fd@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 20 Mar 2019 13:02:11 -0400
Message-ID: <CAKuzo_gqbf8jUvHYHckbrbV_DZhZhSmeVdXCE_1DQbXxETzOKw@...278...>
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
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On Wed, Mar 20, 2019 at 9:45 AM Arne Schwabe <arne@...1227...> wrote:
>
> Am 20.03.19 um 14:25 schrieb Selva Nair:
> > Hi,
> >
> > On Wed, Mar 20, 2019 at 4:02 AM Antonio Quartulli <a@...2181...> wrote:
> >>
> >> Hi,
> >>
> >> On 18/03/2019 22:30, tincanteksup wrote:
> >>> Hi,
> >>>
> >>> this situation has been hanging around for so long is this brief note
> >>> really enough? Considering that the manual has numerous other URLs why
> >>> not include this URL here:
> >>> https://community.openvpn.net/openvpn/wiki/Pushing-DNS-to-clients
> >>>
> >>> We already have this:
> >>> https://community.openvpn.net/openvpn/wiki/SWEET32
> >>>
> >>
> >> the problem with URLs is that they become obsolete and we need to
> >> re-patch the manual in order to update them (or ensure the URL always
> >> work/redirect to something).
> >
> >
> > I have the same opinion about URLs. On top of that the wiki
> > description is inadequate and inaccurate. But that's a different
> > topic.
> >
> > The patch was meant to remove the ambiguity in the current
> > wording. We could add a line saying many distributions include
> > such scripts and front-ends such as network manager, tunnelblick,
> > OpenVPN for Android etc. also handle some dhcp-options. (I don't use
> > any of them, so guessing here..)
> >
>
> Yes. Most platforms and client interpret this option. Only OpenVPN
> itself only interprets it only Windows and Android. It should probably
> changed to reflect reality.

In case of Android, its only sent to the management, right? As the man
page is about
OpenVPN core, I would say the current statement that the option is
handled only on
Windows is correct.

But its useful to expand on the usage on other platforms. I can add a
line about scripts in OS
distributions and front-ends/UI like Android that can transparently handle it.

Selva

