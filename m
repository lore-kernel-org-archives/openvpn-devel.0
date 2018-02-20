MIME-Version: 1.0
In-Reply-To: <20180220195920.GQ69387@...1296...>
References: <1511026858-23281-1-git-send-email-selva.nair@...277...>
 <1511026858-23281-2-git-send-email-selva.nair@...277...>
 <20180220161429.GB69696@...1296...>
 <CAKuzo_iDwg6YJX4GaXPOU8tGhRoKL3-025N9=a+jNwDaZWSy2A@...278...>
 <20180220195920.GQ69387@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 20 Feb 2018 18:33:35 -0500
Message-ID: <CAKuzo_iiv+3GJXuAV1rD+ZH9ijUybqVVNBW1iaV5KzNTDZgyfQ@...278...>
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

On Tue, Feb 20, 2018 at 2:59 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Tue, Feb 20, 2018 at 11:19:23AM -0500, Selva Nair wrote:
>> Hmm.. I thought I had tested the patch.. Looking at it right now -- hold on :)
>
> Missed you on IRC...
>
> 18:21 < selvanair> cron2: iservives in 2.4 local build and snapshot build works
>                    on Windows 10. Have to go now, but will test Win7 later
>                    today when I can get hold of a one.
> 18:22 < selvanair> s/iservives/iservice
>
> ... seems this is different on Win7...?
>
> To be sure it's not something messed up on my system, I have checked
> the HKLM\Software\OpenVPN\(null) path that it's trying to access - and
> all is there
>
> (standard)  REG_SZ  c:\Program Files\OpenVPN
> config_dir  REG_SZ  c:\Program Files\OpenVPN\config
> ...
>
>
> and according to the documentation in
>
> https://msdn.microsoft.com/en-us/library/windows/desktop/ms724868(v=vs.85).aspx
>
> passing "lpValue = NULL" really should work...  the error code 0x57
> OTOH is documented as
>
>         ERROR_INVALID_PARAMETER
>         87 (0x57)
>         The parameter is incorrect.
>
> ... which isn't exactly helpful to see *which* argument it does not like
> - everything *should* be according to specification...
>
> (It does happen for my own binary and for the installers Samuli builds,
> so it's not "my build environment" - theoretically it could be part 1/2
> of that patch set, which I haven't run yet)

Yeah, I could reproduce it on Windows 7. And, at last,  after several
painful Windows builds, it turns out:

RegGetValue with RRF_RT_REG_EXPAND_SZ|RRF_RT_REG_SZ is broken on
Windows 7 (and most likely Vista too).

But once you know what to look for, just google:

https://stackoverflow.com/questions/47096940/reggetvalue-for-value-that-may-be-either-reg-sz-or-reg-expand-sz

Will send a patch later.

Selva

