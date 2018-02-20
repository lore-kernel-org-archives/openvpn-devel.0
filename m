MIME-Version: 1.0
In-Reply-To: <20180220161429.GB69696@...1296...>
References: <1511026858-23281-1-git-send-email-selva.nair@...277...>
 <1511026858-23281-2-git-send-email-selva.nair@...277...>
 <20180220161429.GB69696@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 20 Feb 2018 11:19:23 -0500
Message-ID: <CAKuzo_iDwg6YJX4GaXPOU8tGhRoKL3-025N9=a+jNwDaZWSy2A@...278...>
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

On Tue, Feb 20, 2018 at 11:14 AM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> well, today is the day that I get to break things, it seems...
>
> On Sat, Nov 18, 2017 at 12:40:58PM -0500, selva.nair@...277... wrote:
>> +    /* The default value of REG_KEY is the install path */
>> +    if (GetRegString(key, NULL, install_path, sizeof(install_path), NULL) != ERROR_SUCCESS)
>> +    {
>> +        goto out;
>> +    }
>
> This seems to break on Win7/64 for me.
>
> Trying to start the latest iservice from Samuli's snapshot builds (master,
> but I assume release/2.4 is also affected) returns a non-useful error
> message.
>
> Looking into the event viewer, it tells me:
>
>         openvpnserv error: Falscher Parameter. (0x57)
>         Error querying registry value: HKLM\SOFTWARE\OpenVPN\(null)
>
> ("Falscher Parameter" = "invalid argument")
>
>
> ... so maybe this is not the right way to query the default path?


Hmm.. I thought I had tested the patch.. Looking at it right now -- hold on :)

Selva

