From: tincanteksup <tincanteksup@...277...>
References: <ee0e5768-c1d3-47ea-a466-b868b78cbe21@...277...>
 <98e4ad88-d6de-e308-4e2d-665a9333bf83@...277...>
 <5fc681b6-0f69-40a5-9ede-8edc88704e8d@...277...>
Message-ID: <92a4d573-2a65-9a3a-b5e2-e7ba6a7bb9e7@...277...>
Date: Mon, 17 Aug 2020 11:24:48 +0100
MIME-Version: 1.0
In-Reply-To: <5fc681b6-0f69-40a5-9ede-8edc88704e8d@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] 2.5-beta-1 Windows installer problems
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Final update:

So, IPv4 not working was my own error .. sorry for the false alarm.

As for the non-admin user trying to install drivers, this does still happen.

However, what I think is happening is this:

1. Login as admin - install openvpn OK
2. logout/login as normal user
3. Openvpn does "Setting up personal settings for user foo"
4. The installer also asks the user to install TAP and wintun.
5. On Win7 the user is not prompted for admin password so no changes are 
made to the system.

Openvpn then works ipv4 and v6 Tap and wintun.


The same is true for W10 with the exception that: when openvpn is 
uninstalled only either the current user "personal settings" are removed 
or the admin "personal settings" are removed, depending on who is logged 
in at uninstall.

Then the next install does not need to do the "personal settings" for 
the "other" user because they are already there and so the installer 
does not erroneously try to install the drivers again when the user changes.

That is my best guess.

I don't think anybody needs to respond to this thread any further.

Regards
Richard




On 16/08/2020 14:05, tincanteksup wrote:
> I tried this again on a completely fresh Win10 VM.
> 
> The experience was the same, IPv6 works v4 does not.
> 
> When installing as an admin user and then switching to a non-admin, the 
> installation still continues but does ask for admin password.  But the 
> result is still the same, no IPv4.
> 
> Uninstalling and then installing as a non-admin from scratch seems a lot 
> smoother but the final result is the same, no IPv4.
> 
> Summary:
> 
> Win10 install from non-admin seems to be cleanly done but the result is 
> no Ipv4.
> 
> Win10 install as admin user is not so clean.  OpenVPN installer seems to 
> be left in an incomplete state until a non-admin user logs in.  In my 
> opinion, this is not ideal considering the number of single user 
> machines in use.  Microsoft do what they must to protect the system when 
> a single user machine is in use, openvpn should not be so picky..
> 
> Win7 .. same result, no Ipv4.
> 
> Win7 install seems to have the same issues of who is allowed to install 
> openvpn but does a bad job of it, no admin password prompt.
> 
> I know this is a beta so I'm not complaining, only offering feedback
> 
> Regards
> 
> 
> 
> 
> On 15/08/2020 19:31, tincanteksup wrote:
>> Comment inline:
>>
>> On 15/08/2020 19:29, tincanteksup wrote:
>>> Hi,
>>>
>>> I would like to document the very strange issues I had testing the 
>>> 2.5 MSI installers.
>>>
>>> The first test was on a Win7-Ent/32bit VM with 32bit installer.  The 
>>> second test was a real PC with Win7-HomePro/64bit (yeah, user did not 
>>> want w10) 64bit installer. The third test was Win10/64bit VM 64bit 
>>> installer.
>>>
>>> The results were almost identical:
>>>
>>> 1. Logged in as admin user.
>>> 2. Installed over previous installation.
>>>     Completed apparently OK ?
>>> 3. On testing the VPN I found that:
>>>     IPv6 worked (could ping both ways)
>>>     IPv4 did not (could not ping either way)
>>>     Firewall disabled. Dual stack VPN.
>>> 4. Logged out/Logged in as normal user.
>>> 5. OpenVPN Installer forced a re-install of the TAP/wintun drivers.
>>>     The user could select "do not install" but the installer was 
>>> auto-run.
>>
>> I did "Install" the drivers as non-admin user and was *not* prompted 
>> for admin password.
>>
>>
>>>     The user was *not* prompted for admin password.
>>> 6. Using the same VPN config as above, the VPN now functions correctly.
>>>
>>> The only difference was that on Win10 I could not test logging back 
>>> in as a standard user because my VM could not be activated.
>>>
>>> I do not know where would be the bast place to raise these issues and 
>>> so sent my feedback to the list for further consideration.
>>>
>>> Regards
>>> Richard

