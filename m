Message-ID: <5614C973.6090400@...515...>
Date: Wed, 07 Oct 2015 10:27:47 +0300
From: =?windows-1252?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <CADxRZqx68w6zJ1-fAt7Mn=TC0B6n6fkBt4U0WO=ECrz546iOQw@...278...>	<CADxRZqyfmK5k9dFZetHkrFmuiVQ7Z1tZ2wVsEiYyqdHKKZkwtw@...278...>	<CADxRZqyq7SqNUOgW8Vg7SCBmox-CKxkUfMEcLy6FtNAeAJnZrg@...278...>
	<56138ACC.6090508@...2070...>
In-Reply-To: <56138ACC.6090508@...2070...>
Subject: Re: [Openvpn-devel] russian language fixes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: ValdikSS <iam@...2070...>, Anatoly Pugachev <matorola@...277...>, openvpn-devel@lists.sourceforge.net

Hi,

It seems that openvpn-gui development has stalled for quite a while, and=20
I've had my own share of issues with getting patches in. To simplify the=20
OpenVPN release process at my end I forked openvpn-gui a while back:

<https://github.com/mattock/openvpn-gui>

We may want to use my private openvpn-gui fork for now - the official=20
openvpn-gui tarballs[1] are already built from my own Git repo. If=20
something happens in the official SF.net openvpn-gui Git repo we can=20
always merge those changes back to my fork.

As discussed in previous community meeting we also need to consider to=20
option of replacing openvpn-gui with something that's more actively=20
maintained.

Thoughts?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

[1] <http://build.openvpn.net/downloads/releases/>


> I posted the similar patch a year ago directly to openvpn-gui
> sourceforge page and it seems to be gone.
> So please apply this.
>
> On 06.10.2015 11:45, Anatoly Pugachev wrote:
>>
>> Hello!
>>
>> Can you please apply patch from trac ticket 446. Thanks.
>>
>> https://community.openvpn.net/openvpn/ticket/446
>>
>>
>>
>> ------------------------------------------------------------------------=
------
>>
>>
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>
>
> -------------------------------------------------------------------------=
-----
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


