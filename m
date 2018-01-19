MIME-Version: 1.0
In-Reply-To: <CAFHpkQFu5rRhNDfGDC5NCcRrMOH+-bZd-mi7wLkM6uNas+dSXQ@...278...>
References: <CAFHpkQGe-aeaV2we=M_xB41W36dwAa8rRRzmt6rteVvAHuXFKA@...278...>
 <CAKuzo_i_J7+yFwv60gd3MinAOu7SdoUmvVMKsHZG-3Fep5EFmw@...278...>
 <CAFHpkQFu5rRhNDfGDC5NCcRrMOH+-bZd-mi7wLkM6uNas+dSXQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 18 Jan 2018 23:56:41 -0500
Message-ID: <CAKuzo_iu=Yf9CGFwNi8waQw-v1kog21VUWVoX+fN2M2owTy9mw@...278...>
Subject: Re: [Openvpn-devel] consider exe_path optional ?
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
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

>
>
> I do not think that speciying a path is somewhat related to security (for
> example, I can put a malware named "openvpn.exe" in that path).

It is indeed a security measure. You cannot put a malware in that path
unless you are admin
or an admin sets HKLM\Software\OpenVPN's default value to a location
wriite-able by you.
In either case an admin's blessing is needed.

As the service runs as system and executes certain requests from
openvpn.exe that it starts
on a limited user's behalf, this protection is necessary and is
deliberately imposed.

Selva

