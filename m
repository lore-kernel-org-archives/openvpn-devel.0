Message-ID: <4219537b-74c6-c39b-499e-8d09e1f6f649@...1227...>
Date: Mon, 16 Jan 2023 15:36:31 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <6c0e8ca1-9518-1bc0-65cb-f742311ef08f@...1227...>
 <CAKuzo_i+zwgpg_zq050WQtNm+s0p-OMDkLGUUHn+hSApJfrorA@...278...>
 <1d60ed5a-0a1c-9723-b797-78663f477633@...1227...>
 <CAKuzo_gSCb_mydAbHeaVdbHOG9Km2fZLyOaQoCrrCDqQei0sJA@...278...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAKuzo_gSCb_mydAbHeaVdbHOG9Km2fZLyOaQoCrrCDqQei0sJA@...278...>
Subject: Re: [Openvpn-devel] Amend OpenVPN license to allow continued mbed
 TLS support (allow mbed TLS 3.x linking)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 15.01.23 um 17:51 schrieb Selva Nair:
> Hi,
> 
> On Sun, Jan 15, 2023 at 8:53 AM Arne Schwabe <arne@...1227... 
> <mailto:arne@...1227...>> wrote:
> 
>     Am 15.01.23 um 14:23 schrieb Selva Nair:
>      > Hi,
>      >
>      >     We would like to be able to continue to build/ship OpenVPN
>     with mbed
>      >     TLS. We want all contributors to ask if they agree to license
>     change
>      >     that adds explicit permission to link with Apache 2 licensed
>     libraries:
>      >
>      >
>      >     Special exception for linking OpenVPN with Apache 2 licensed
>     libraries:
>      >
>      >         In addition, as a special exception, OpenVPN Inc and
>     contributors
>      >         give permission to link the code of this program to libraries
>      >     with the
>      >         "APACHE LICENSE, VERSION 2.0", and distribute linked
>     combination
>      >         including the two.  You must obey the GNU General Public
>     License in
>      >         all respects for all of the code used other than these
>      >     libraries.  If
>      >         you modify this file, you may extend this exception to your
>      >     version of
>      >         the file, but you are not obligated to do so.  If you do
>     not wish to
>      >         do so, delete this exception statement from your version.
>      >
>      >
>      > Instead of this exemption I would vote for a change to 'GPL v2 or
>     any
>      > later version'.
>      > That would keep the license in the spirit by which people like me
>      > contributed.
>      >
>      > Using an existing license that has already been vetted also
>     avoids the need
>      > for legal counsel.
>      >
>      > I do not understand the argument about 'GPLv2 and later...' and
>     embedded
>      > devices. Those who
>      > are currently embedding based on GPL v2 can continue to do so,
>     those who
>      > want/need v3
>      > can do so too. Those who need v3 but also want to lock the
>     firmware on a
>      > consumer device
>      > may be affected. But that's a choice they make, why would we want to
>      > promote that?
>      >
>      > Some may find this discussion a waste of time but let's not belittle
>      > people's contributions.
>      > I do care about how my work is licensed.
> 
>     Okay. I think the embedded thing is a bit of a misunderstanding. I am
>     not trying to promote that. What I wanted is to express why changing to
>     GPLv3 might not be an option as some license holders of OpenVPN will
>     not
>     be okay with changing to GPL3 since they need that. 
> 
> 
> Thanks for the clarification. I was not aware of that.
> That's very unfortunate, though. So some want to keep the loopholes of 
> GPL v2, and also the goodies that come with an Apache 2.0 exception, all 
> together!
> 
>     So the situation is basically, we need somehow to still be able to link
>     Apache 2.0 licensed SSL libraries. While we have an exception for
>     OpenSSL, some might argue that this only covers the old OpenSSL license.
> 
>     So to go forward we either need to change OpenVPN 2.x to a license
>     compatible with Apache 2.0 like GPL3 or adding an excerption for
>     linking
>     against Apache 2.0.
> 
>     At the hackathon we discussed the options and there already voices
>     against going GPL3 instead of GPL2 but everyone there was okay with
>     staying with GPL2 and adding an exception.
> 
>     This approach of taking the exception route instead of GPL3 is mostly a
>     pragmatic approach to be able to have something that might have a
>     chance
>     of succeeding.
> 
> 
> Given all that, I'll reluctantly agree to the proposed exception.
> 
> It's not critical at this stage, but the wording "...libraries with the 
> 'APACHE LICENSE, VERSION 2.0', ..." sounds ambiguous. Is that a legally 
> vetted form or a draft?

Enough people have looked over that but I am not sure a lawyer has done 
it to be honest.

Arne


