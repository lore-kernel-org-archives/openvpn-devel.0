From: Kristof Provost <kprovost@...2661...>
Date: Tue, 08 Mar 2022 15:45:10 +0100
Message-ID: <97D71D19-9B45-477B-919C-A563EC93B054@...2661...>
In-Reply-To: <d0cd57b8-82aa-31cf-1db5-c328ab775748@...2181...>
References: <20220224165557.22060-1-kprovost@...2661...>
 <d0cd57b8-82aa-31cf-1db5-c328ab775748@...2181...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH DCO]: FreeBSD DCO support
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 8 Mar 2022, at 15:23, Antonio Quartulli wrote:
> On 24/02/2022 17:55, Kristof Provost via Openvpn-devel wrote:
>> I've had to add a lot of '|| defined(TARGET_FREEBSD)', and I think the
>> code could be a bit cleaner if we'd make these calls conditional only on
>> defined(ENABLE_DCO), and instead expect every DCO implementation to
>> provide them, if only as stubs. I've not done that here.
>
> Can you name what new internal APIs would you want to add?
> I am also in favor of less ifdefs and have APIs that can be defined as st=
ub or not based on the platform.
>
We=E2=80=99ve got a significant number of cases where we call DCO functions=
 for Linux & FreeBSD but not for Windows.
One example is the call to dco_event_state() in multi_tcp_wait() and io_wai=
t_doword().
If windows provided an implementation for that, even if it did no work, we =
could replace =E2=80=98#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)=
=E2=80=99 with an =E2=80=98#ifdef ENABLE_DCO=E2=80=99. If we provided a stu=
b implementation for the DCO functions even for non-DCO builds we wouldn=E2=
=80=99t need any =E2=80=98#ifdef=E2=80=99 at all.

> A comment for your kernel API:
> I have seen you created an API named "OVPN_SET_TIMEOUT", however I'd sugg=
est to name it "OVPN_SET_PEER" (like on Linux and Windows), because the ide=
a is that this call will be used to set any additional/optional per-peer pa=
ram.
>
> For example, we have been recently working on mssfix, which we may want t=
o set on a per-peer basis (more params may come later).
>
> The SET_PEER call will allow to set all these params (if specified).
>
> What do you think?
>
I think I renamed it because I found the =E2=80=98SET_PEER=E2=80=99 name to=
 be easy to confuse with =E2=80=98NEW_PEER=E2=80=99, but I=E2=80=99m happy =
to align to other platforms.

Best regards,
Kristof

