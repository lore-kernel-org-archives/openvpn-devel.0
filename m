MIME-Version: 1.0
References: <20191213191634.250-1-lstipakov@...277...>
 <20191213191901.300-1-lstipakov@...277...>
 <CAKuzo_jNn9NG-chJHx62H2CTiB64dCrq3S3_oW7oR8Tngf4F9w@...278...>
 <CAGyAFMVReSwJsYAKo5S4pV4POV31g0roxz4P2Ajvr+8hoEYbeA@...278...>
 <CAKuzo_hMws66xJsN69qa6WmgXNdrSKioHQrpE9VZ89-J2O7+KA@...278...>
 <CAGyAFMWfEnYrNOwugvO6y1HoFsdih0xu9Lm1_fO=QgrgeyxzzQ@...278...>
In-Reply-To: <CAGyAFMWfEnYrNOwugvO6y1HoFsdih0xu9Lm1_fO=QgrgeyxzzQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 16 Dec 2019 17:20:33 -0500
Message-ID: <CAKuzo_h4n=emRPH+WuK91zZ4n8_SGz0eE-0g91_HinRosbSv3g@...278...>
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

On Mon, Dec 16, 2019 at 4:31 PM Lev Stipakov <lstipakov@...277...> wrote:
>>
>> I have already said what I think of it. As an admin I wouldn't like to see
>> users running processes that elevate to SYSTEM like this.
>
>
> Would it be too much if
>
>  - openvpn.exe process detects that it is not started by interactive service
>  - interactive service process is running
>  - wintun is used as --windows-driver
>

I think this is possible and in fact I had something like this in mind
as well I wrote we could provide an openvpn launcher script.

And I would like to do this even if wintun is in use as ability to run
openvpn.exe as a regular would be a plus for everyone.

> then openvpn behaves as a command-line version of openvpn-gui - connects to service, which
> runs openvpn.exe, and then prints output, received via management interface, to console?

It may be better to redirect the output to the stdout or file as usual
so that no
user visible changes and easier to implement too. Just keep the process id
returned from the service and when the user kills the front-end, terminate the
background process started by the service too.

This should also allow to run the automatic service as LocalService or a
special service user as many services do.

Selva

>
> --
> -Lev

