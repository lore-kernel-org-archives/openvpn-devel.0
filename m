From: Kristof Provost <kprovost@...2661...>
Date: Tue, 08 Mar 2022 15:49:11 +0100
Message-ID: <5CD07A68-5F0C-4A6A-AAAF-4FE9F85F1D99@...2661...>
In-Reply-To: <00098d0c-c226-442e-8cf7-fa27188181d5@...2181...>
References: <20220224165557.22060-1-kprovost@...2661...>
 <20220224165557.22060-3-kprovost@...2661...>
 <f4d55b82-4a9d-fd09-a8d9-f4ec6a8692d1@...2181...>
 <DED07A0F-3068-494D-BECA-B043BD97D49B@...2661...>
 <00098d0c-c226-442e-8cf7-fa27188181d5@...2181...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 2/2] ovpn-dco: introduce FreeBSD
 data-channel offload support
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

On 8 Mar 2022, at 15:36, Antonio Quartulli wrote:
> On 08/03/2022 15:29, Kristof Provost wrote:
>> Theoretically I=E2=80=99d prefer to use the OS header, but I can certain=
ly see the upside of not having that dependency. We=E2=80=99ll always have =
to do the runtime check (dco_available()) anyway, so I can certainly live w=
ith that.
>>
>>> p.s. as a side note, the rest of the code contains some "code style" is=
sues. Nothing major, but wanted to mention it (we can discuss on IRC if you=
 want).
>>>
>> I=E2=80=99m happy to fix that. Do you have a rough list of what=E2=80=99=
s wrong?
>> https://community.openvpn.net/openvpn/wiki/CodeStyle is the authoritativ=
e style guide, right?
>
> Correct. Not everything might be there, so feel free to ask for any clari=
fication on IRC. Your code is already pretty clean actually.
> Some things I have seen:
> - We tend to avoid "if (a =3D=3D NULL)" (or "!=3D 0") in favor of just "i=
f (a)";
> - We avoid spaces after the cast operator;
> - we always use brackets {} for one-line blocks;
>
Thanks!

Most of those are probably because I=E2=80=99m used to FreeBSD=E2=80=99s st=
yle (https://www.freebsd.org/cgi/man.cgi?query=3Dstyle&apropos=3D0&sektion=
=3D0&manpath=3DFreeBSD+13.0-RELEASE+and+Ports&arch=3Ddefault&format=3Dhtml)=
, but consistency is important.

I=E2=80=99ll update the patch (and also address the SET_TIMEOUT thing) soon=
. I=E2=80=99ve got a bit of travel coming up, so I=E2=80=99m not quite sure=
 when it=E2=80=99ll be though.

Best regards,
Kristof

