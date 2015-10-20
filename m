References: <56211F0D.2010806@...515...> <18065708.JIrWLiTMeq@...2001...>
	<ac7rqc.nwgq22.2u3ktu-qmf@...2076...>
	<2892922.l0hsuaC9oU@...2001...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <5625EA0A.3000908@...515...>
Date: Tue, 20 Oct 2015 10:15:22 +0300
MIME-Version: 1.0
In-Reply-To: <2892922.l0hsuaC9oU@...2001...>
Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

>> Are you saying that the interactive service also doubles as a Windows sy=
stem
>> service? If so, can it be  configured to autostart selected openvpn
>> connections on boot and restart them if they crash/stop?
>
> No, and I do not think that the service should take care of that. That's
> rather things that can be handled by the GUI.

What about persistent connections, especially on Windows servers?

I've already done a proof of concept "openvpnserv.exe" replacement using=20
NSSM:

<https://community.openvpn.net/openvpn/wiki/IntegratingOpenvpnWithNssm>

I also started writing a small C# program that can manage OpenVPN=20
connections in NSSM in a user-friendly fashion, because the standard=20
NSSM GUI is way too complex and generic for our well-specified use-case.

>> Now, can anyone provide proof that having a Windows team would actually
>> _hurt_ the project? If not, what does it matter if it fails? We could ju=
st
>> scrap the idea retroactively.
>
> Hehe nice turn demanding proof, that'll shut up ppl. =3D)

Yes, that was the idea, because I know you guys don't have any proof. It=20
seemed to have worked fine :).

That said, I don't have any proof either, but I think we all can agree=20
that the situation with Windows in OpenVPN is not optimal, and that we=20
should try to do something about it.

Best regards,

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

