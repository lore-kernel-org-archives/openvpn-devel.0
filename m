MIME-Version: 1.0
References: <33ef1f35-333c-cb25-bdbe-194f03e6ba4f@...515...>
 <32d9790b-0dd3-e7db-5a29-120359d08400@...1147...>
In-Reply-To: <32d9790b-0dd3-e7db-5a29-120359d08400@...1147...>
From: Emmanuel Deloget <logout@...260...>
Date: Wed, 24 Oct 2018 15:22:13 +0200
Message-ID: <CAKh=nwHFGHZXtVTHzQRUoR+otaQRu7gLM3i098fpVFN7gPuYtg@...278...>
Subject: Re: [Openvpn-devel] Adding Google Analytics code to Trac?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: janjust@...1147...
Cc: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hello,

On Wed, Oct 24, 2018 at 3:02 PM Jan Just Keijser <janjust@...1147...> wrote:
>
> Hi,
>
> On 24/10/18 13:47, Samuli Sepp=C3=A4nen wrote:
> > Hi,
> >
> > The OpenVPN Inc. webmaster would like to add Google Analytics to
> > community.openvpn.net, i.e. our Trac wiki/bug tracker. I said we need to
> > consult the community first because GA can be seen as a form of spying.
> > Here's our webmaster's view on this subject:
> >
> > ---
> >
> > "The goal of this would be to understand what information first-time
> > users are finding the most valuable on community.openvpn.net."
> >
> > "As this is a publicly accessible community without the requirement to
> > join to read the articles, it would be advantageous for all to
> > understand which pieces of content the public are finding the most
> > useful, what encourages them to become a part of the community, and what
> > potentially persuaded them to use start using a commercial product."
> >
> > "As openvpn.net links to community.openvpn.net and vice versa this will
> > also help us to understand the complete journey of a user and help to
> > improve the website experience, which can only be seen as a positive."
> >
> > ---
> >
> > In today's community meeting there was some concern about the spying
> > aspect of Google Analytics, but nobody was strongly opposed. This was I
> > believe, in part, because it is fairly easy to block Google Analytics if
> > one so wishes.
> >

Wouldn't it be easier to use a server-side script to do the same
thing? There are many "analytics" scripts out there that don't rely on
google or any other web service. If the webmaster is in PHP, he can
use http://www.openwebanalytics.com/ or any other subsystem.

Best regards,

-- Emmanuel Deloget

