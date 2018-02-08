References: <CAFHpkQEFPO+TsXdqva=OGg_9FnErDH7Uw9fs876Co_q2A4=rmA@...278...>
 <CAKuzo_hdyx3MH5Cw=gEujHhEvQ1wnOaZ2r0n7=j3GSsv_C1Z2Q@...278...>
 <CAFHpkQFtN6jk5bNcksmoBDjjMd3UbW4sN+y5rH0zUb2sgDq=gg@...278...>
 <6febf54c-f7ab-2297-2c75-72235e14e1c5@...2080...>
 <CAKuzo_gQaniVbD2QuEBb1x+xe8wULUjJkhXMWocyxi=oDknz0w@...278...>
 <66f25180-945c-1dc9-a5ca-62d3cacdff2c@...2080...>
 <87b2c993-9711-a7f5-fb3f-d3e2a26da610@...2181...>
 <3bb917b3-3ed2-8097-49ff-1aebca097561@...2080...>
 <CAKuzo_goKLjm6Sukuzu0Ghijum_F57vxX28cMf4DY9voro_i5Q@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <e858ff28-efdc-1ac4-9145-83ca295b5ba5@...1227...>
Date: Thu, 8 Feb 2018 18:07:31 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_goKLjm6Sukuzu0Ghijum_F57vxX28cMf4DY9voro_i5Q@...278...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [Openvpn-users] "Reconnect" button in
 openvpn-gui
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>
Cc: Antonio Quartulli <a@...2181...>, "openvpn users list (openvpn-users@lists.sourceforge.net)" <openvpn-users@lists.sourceforge.net>

Am 08.02.18 um 16:31 schrieb Selva Nair:
> Hi,
> 
> On Thu, Feb 8, 2018 at 7:20 AM, David Sommerseth
> <openvpn@...2080...> wrote:
>> On 08/02/18 04:36, Antonio Quartulli wrote:
>>>
>>>
>>> On 08/02/18 04:41, David Sommerseth wrote:
>>>> On 07/02/18 21:21, Selva Nair wrote:
>>>>
>>>>> In my view auth-token handling in openvpn.exe is broken at multiple levels:
>>>>>
>>>>> Client process:
>>>>> (i) it should not remember the token after a reconnect is issued
>>>>
>>>> Agreed.  This should trigger retrieving new user input in regards to SIGHUP at
>>>> least.  Not sure yet about SIGUSR1 though.  SIGHUP has a cleared semantic
>>>> though (hang-up).
>>>
>>> I discussed this Arne as well as he also had users complaining about this.
>>>
>>> The conclusion we came was that it may be meaningful, upon reconnection,
>>> to try sending the token once (the token might be handled by external
>>> server side scripts and might still be alive, so one attempt is worth)
>>> and if it fails then we should dump the token, ask the user for the
>>> password and reconnect.
> 
> But this is the current behaviour, isn't it? So what's the difference?
> I think its wrong to reuse auth-token of one "connection"  in another
> one.  A client restart leads to a new connection and that should get a
> new token. Else a stolen token could be used in a new TLS session --
> may sound far-fetched as one also has to steal the private key, but as
> far as a user is concerned token is a place holder for their password
> and OTP. It should be reused only for reneg.
> 
> I think the correct and easy fix is to wipe the token on the client
> when it restarts by SIGUSR1 or SIGHUP.  If a server side script
> doesn't like it that script is anyway broken.

No it isn't. Current behaviour is to exit with AUTH_FAILED in that case.

And always forgetting it on SIGUSR1 with normal reconnect will
absolutely annoy users with mobile devices and otp password. Every roam
between wifi and mobile will then reask for the password. SOmething the
auth-token is designed to avoid.

Arne

