MIME-Version: 1.0
References: <20191213191634.250-1-lstipakov@...277...>
 <20191213191901.300-1-lstipakov@...277...>
 <CAKuzo_jNn9NG-chJHx62H2CTiB64dCrq3S3_oW7oR8Tngf4F9w@...278...>
 <CAGyAFMVReSwJsYAKo5S4pV4POV31g0roxz4P2Ajvr+8hoEYbeA@...278...>
In-Reply-To: <CAGyAFMVReSwJsYAKo5S4pV4POV31g0roxz4P2Ajvr+8hoEYbeA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 16 Dec 2019 15:17:06 -0500
Message-ID: <CAKuzo_hMws66xJsN69qa6WmgXNdrSKioHQrpE9VZ89-J2O7+KA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v6 4/7] wintun: ring buffers based I/O
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

Hi

On Mon, Dec 16, 2019 at 3:01 PM Lev Stipakov <lstipakov@...277...> wrote:
>
> Hi,
>
> Thanks for looking into this. See my comments below.
>
>> TLDR:
>> (i) stealing SYSTEM access from winlogon.exe is not a good thing to do
>
>
> This doesn't happen for the majority of use cases - only when iservice is not used. We also
> elevate only for the single DeviceIOControl call.

I understand. But stealing access token from winlogon.exe is a hack and not
something I would expect to see in a trustworthy executable. Diagnostic
and forensic tools may be justified in doing such things.

>
> Below you mentioned psexec as a one of workarounds, but I think
> those will make user experience worse.

I was not suggesting it as an approach for "users" -- only for testing
or for those
who insist running OpenVPN from command line.

> Also consider the case when OpenVPN GUI is running as Administrator.

That would be a wrong way of using the GUI in 2.4 + releases. We need not and
should not (IMO) support the GUI running as admin. That said, now that vista is
no longer supported we can enable the use of iservice with GUI running as admin.

>
>> (ii) with a small change we can support multiple tunnels and  provide better
>> diagnostics when there are no free wintun adapters -- but this could also
>> be a follow up patch.
>
>
> This is already implemented by Simon on top of my patches - see https://github.com/rozmansi/openvpn/commits/wintun
>
>> > -    /* for wintun kernel doesn't send DHCP requests, so use ipapi to set IP address and netmask */
>>
>> > +    /* for wintun kernel doesn't send DHCP requests, so use netsh to set IP address and netmask */
>> >      if (options->wintun)
>> >      {
>> > -        options->tuntap_options.ip_win32_type = IPW32_SET_IPAPI;
>> > +        options->tuntap_options.ip_win32_type = IPW32_SET_NETSH;
>>
>> This shouldn't be required. I would prefer to not use netsh
>> for tasks where API calls are available. We know IPAPI works
>> as we use it in the service.
>
>
> I remember having some issues with IPAPI which got resolved when I switched to netsh.
>
> However, I did some testing and I cannot reproduce IPAPI specific issues anymore. Too bad I didn't investigate
> it further back then. The problem I see now can also be reproduced also with netsh:
>
>  - connect with tap adapter
>  - kill openvpn process
>  - connect with wintun adapter
>
> IPAPI / netsh fails to set IP address, since it is already assigned to another adapter.
>
> If this is OK, I would prefer to submit a separate patch which switches back to netsh. tun.c code
> has changed in follow-up patches (mostly here https://patchwork.openvpn.net/patch/918/), those patches
> are based on an assumption that wintun uses netsh.
>
>>
>> > +                msg(M_FATAL, "ERROR:  Failed to register ring buffers: %lu", GetLastError());
>>
>> The correct error here is, very likely, the adapter is
>> already in use. To trigger that, why not do register_ring_buffers
>> soon after opening the device and on failure move on to the
>> next device (if any).
>>
>> That will also allow running multiple tunnels with no further changes
>> provided the user manually creates wintum adapters.
>
>
> As mentioned before, this is already implemented by Simon:  https://github.com/rozmansi/openvpn/commit/5bc09580e8771d8422feae4504fe2a74b7412fd1
>
>>
>> > +bool
>>
>> > +impersonate_as_system()
>> > +{
>>
>> This is implemented by stealing the access token from
>> winlogon.exe. I don't think such tricks belong to OpenVPN.
>> It may also trip some anti-virus software.
>>
>> That said, probably there are no "legitimate" ways of getting
>> LOCAL SYSTEM rights on Windows without running a service.
>>
>> Why does wintun require SYSTEM for using it? If there is a
>> good reason for that, we should not let every admin
>> user bypass it.
>
>
> I'll defer it to Simon.
>
>>
>>
>> I would suggest to not elevate to system as the code will still
>> work in two important cases
>> (i) started by automatic service
>> (ii) started using interactive service (e.g., through the GUI)
>>
>> Those who really need to test OpenVPN with wintun from
>> command prompt can use diagnostic tools available to get
>> a cmd prompt as system (e.g., psexec). That also  makes
>> it explicit that SYSTEM privilege is required.
>>
>> In the longer run, we could provide a script to launch
>> openvpn.exe using the interactive service. Modifying the
>> automatic service to use interactive service for launching
>> looks easy to do as well. Then, all privileged operations could
>> be removed from openvpn core.
>
>
> I think it is good not to break user experience and allow run openvpn as
> an administrator without iservice using wintun at the expense on elevation
> to system for single API call.

I have already said what I think of it. As an admin I wouldn't like to see
users running processes that elevate to SYSTEM like this.

Selva

