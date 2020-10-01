Message-ID: <2fd674eb36cdc08f2d5115adc9673b84.squirrel@...2260...>
In-Reply-To: <de392f2b-a11f-f747-0fe5-636b4a0e5a12@...2080...>
References: <84a29b8afab02733064c2cf715ae0b8c.squirrel@...2257...>
 <f27fb070-c84e-2319-2db5-b0cda50fe3c9@...1227...>
 <c319712b9f596989d66570d9624d8357.squirrel@...2260...>
 <de392f2b-a11f-f747-0fe5-636b4a0e5a12@...2080...>
Date: Thu, 1 Oct 2020 18:36:11 +0200
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Add --up-pre with the same functionality as
 --down-pre
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn@...2080...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

> On 01/10/2020 17:03, Simon Matter wrote:
>> I really can't understand why this small patch was refused for years and
>> I
>> still feel nobody ever really looked at it.
>
> Perhaps this also an indication of the corner case this patch is covering?
>
> This patch started 7 years ago.  There has been 2 other users being
> supportive
> in the Trac ticket, where at least one of them do have another functional
> alternative (--management with --management-hold).
>
> From what I recall from the last review years ago, the behavior was also
> not
> well defined in restart scenarios (--up-restart) - where the script might
> be
> run with different privileges, the --chroot might also change things.
> Which
> makes this patch very fragile for users.
>
> All of these issues are avoided with the --management and
> --management-hold.

How do all these issues affect --up-pre but not the existing --down-pre?
Why was --down-pre never removed over all the years if it makes things so
fragile for users?

>
> And if you still require more flexibility when starting client
> configurations,
> you should rather consider OpenVPN 3 Linux - which can be much more fine
> grained controlled via an API.  OpenVPN 3 Linux can also be used by
> unprivileged users out-of-the-box, resulting in better security for what
> is
> being executed and when it is being executed.

OpenVPN 3 Linux is not an option here as it is limited to Linux.

Regards,
Simon


