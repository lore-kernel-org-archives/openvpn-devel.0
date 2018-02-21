MIME-Version: 1.0
In-Reply-To: <20180221074259.GT69387@...1296...>
References: <1511026858-23281-1-git-send-email-selva.nair@...277...>
 <1511026858-23281-2-git-send-email-selva.nair@...277...>
 <20180220161429.GB69696@...1296...>
 <CAKuzo_iDwg6YJX4GaXPOU8tGhRoKL3-025N9=a+jNwDaZWSy2A@...278...>
 <20180220195920.GQ69387@...1296...>
 <CAKuzo_iiv+3GJXuAV1rD+ZH9ijUybqVVNBW1iaV5KzNTDZgyfQ@...278...>
 <20180221074259.GT69387@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 21 Feb 2018 08:20:34 -0500
Message-ID: <CAKuzo_iu-PeP6qHtMbQi69=3RSN1U9JNTFwso32s_H96KM3uNA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Make most registry values optional
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Wed, Feb 21, 2018 at 2:42 AM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Tue, Feb 20, 2018 at 06:33:35PM -0500, Selva Nair wrote:
>> > (It does happen for my own binary and for the installers Samuli builds,
>> > so it's not "my build environment" - theoretically it could be part 1/2
>> > of that patch set, which I haven't run yet)
>>
>> Yeah, I could reproduce it on Windows 7. And, at last,  after several
>> painful Windows builds, it turns out:
>>
>> RegGetValue with RRF_RT_REG_EXPAND_SZ|RRF_RT_REG_SZ is broken on
>> Windows 7 (and most likely Vista too).
>
> Thanks for investigating and finding the root cause.  "This is not what
> the documentation says...!" -> I need to actually *run* these things, not
> just test compile.

When I say painful builds, I mean edit build[*], copy to Windows, run
in a few configurations, look through the event viewer, rinse rather
repeat. And finally when it seems to start working connect to a my
work VPN,  remove the registry keys and try to break it etc..

FYI, I don't just "test compile", and leave it at that.

Selva

[*] Yes, that fetch-all and rebuild from scratch part of openvpn-build
is very time consuming. Making it work the usual "remake only what
changed" way would save a lot of time and frustration.

