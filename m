From: Kristof Provost <kprovost@...2661...>
Date: Thu, 09 Mar 2023 10:03:47 +0100
Message-ID: <94DF064D-721F-4AA7-B76B-93786572AEEE@...2661...>
In-Reply-To: <62eccc04-3b65-edd7-9233-3ba3dc1999e1@...2181...>
References: <20230309005208.29704-1-a@...2181...>
 <F9C9036B-0A31-4F9A-AD15-682141A1C069@...2661...>
 <62eccc04-3b65-edd7-9233-3ba3dc1999e1@...2181...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] dco: print version to log if available
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
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

On 9 Mar 2023, at 9:57, Antonio Quartulli wrote:
> On 09/03/2023 09:36, Kristof Provost wrote:
>> On 9 Mar 2023, at 1:52, Antonio Quartulli wrote:
>>> In order to provide better support in case of troubleshooting issues,
>>> it's important to know what exact DCO version is loaded on the user
>>> system.
>>>
>>> Therefore print the DCO version during bootup.
>>>
>>> For Windows and FreeBSD we currently implement a placeholder printing '=
v0'.
>>> This should be improved with a follow-up patch.
>>>
>> FreeBSD is a bit special in this regard, because the DCO driver is part =
of the base operating system and not an add-on as in Linux and Windows.
>>
>> Arguably the thing to do for FreeBSD is to log the OS version.
>
> Isn't it possible to install DCO "out-of-tree" (as we can do on Linux)?
>
With some effort it could be done, but any version (in the source tree) bef=
ore DCO was actually imported isn=E2=80=99t going to work. I made a few (sm=
all) tweaks to the network stack to make things work.

Realistically this isn=E2=80=99t something people will do, and if they do d=
ecide to the usual warranty applies (i.e. they get to keep all of the piece=
s it breaks into).

> However, what you said will also apply to linux in the future: we will al=
so need to report the kernel version, *if* DCO is compiled in (to be implem=
ented).
>
> This said, reporting the kernel/os version is absolutely appropriate if t=
hat's what identifies the DCO version.
>
There=E2=80=99s no API in FreeBSD=E2=80=99s DCO to identify its version eit=
her, which is another reason to just use the OS version.

> Is that something you could implement in dco_freebsd.c?
>
Sure. I=E2=80=99ll send a patch later today.

Best regards,
Kristof

