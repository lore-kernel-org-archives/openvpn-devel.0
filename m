References: <1447093954-5508-1-git-send-email-dpb@...2087...>
	<5640F3F4.5060302@...2070...> <op.x7upukdanngjn5@...2088...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <5641BA21.8030200@...515...>
Date: Tue, 10 Nov 2015 11:34:25 +0200
MIME-Version: 1.0
In-Reply-To: <op.x7upukdanngjn5@...2088...>
Subject: Re: [Openvpn-devel] [PATCH] Fix a few typos in the Russian
 localization
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
To: =?UTF-8?B?0KDQvtC80LDQvSDQlNC+0L3Rh9C10L3QutC+?= <dpb@...2087...>, openvpn-devel@lists.sourceforge.net, ValdikSS <iam@...2070...>

Yeah, it's well hidden right now. I'll move openvpn-gui to the main=20
OpenVPN project on GitHub today / later this week, so it will be easier=20
to find.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

> Oh, OK then. I didn't know about the fork.
>
> ValdikSS <iam@...2070...> =D0=BF=D0=B8=D1=81=D0=B0=D0=BB =D0=B2 =D1=81=D0=
=B2=D0=BE=D1=91=D0=BC =D0=BF=D0=B8=D1=81=D1=8C=D0=BC=D0=B5 Mon, 09 Nov 2015
> 22:28:52 +0300:
>
>> Thanks for the patch but all these and another typos are already fixed
>> in the mattock's repository
>> https://github.com/mattock/openvpn-gui/commit/b5b00c272674233c5c951c0e47=
3f2341065a9fc4
>> and would be included in next release.
>>
>> On 09.11.2015 21:32, =D0=A0=D0=BE=D0=BC=D0=B0=D0=BD =D0=94=D0=BE=D0=BD=
=D1=87=D0=B5=D0=BD=D0=BA=D0=BE wrote:
>>> ---
>>>   res/openvpn-gui-res-ru.rc | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/res/openvpn-gui-res-ru.rc b/res/openvpn-gui-res-ru.rc
>>> index a9f8f48..08e7f97 100644
>>> --- a/res/openvpn-gui-res-ru.rc
>>> +++ b/res/openvpn-gui-res-ru.rc
>>> @@ -123,12 +123,12 @@ FONT 8, "Microsoft Sans Serif"
>>>   LANGUAGE LANG_RUSSIAN, SUBLANG_DEFAULT
>>>   BEGIN
>>>       ICON ID_ICO_APP, 0, 8, 16, 21, 20
>>> -    LTEXT "OpenVPN GUI v" PACKAGE_VERSION " - =D0=B3=D1=80=D0=B0=D1=84=
=D0=B8=D1=87=D1=81=D0=B5=D0=BA=D0=B8=D0=B9 =D0=B8=D0=BD=D1=82=D0=B5=D1=80=
=D1=84=D0=B5=D0=B9=D1=81
>>> Windows =D0=B4=D0=BB=D1=8F OpenVPN\n" \
>>> +    LTEXT "OpenVPN GUI v" PACKAGE_VERSION " - =D0=B3=D1=80=D0=B0=D1=84=
=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8=D0=B9 =D0=B8=D0=BD=D1=82=D0=B5=D1=80=
=D1=84=D0=B5=D0=B9=D1=81
>>> Windows =D0=B4=D0=BB=D1=8F OpenVPN\n" \
>>>             "Copyright (C) 2004-2005 Mathias Sundman
>>> <info@...454...>\n" \
>>>             "http://openvpn.se/", 0, 36, 15, 206, 26
>>>       LTEXT "OpenVPN - =D0=BF=D1=80=D0=B8=D0=BB=D0=BE=D0=B6=D0=B5=D0=BD=
=D0=B8=D0=B5 =D0=B4=D0=BB=D1=8F =D0=B1=D0=B5=D0=B7=D0=BE=D0=BF=D0=B0=D1=81=
=D0=BD=D0=BE=D0=B3=D0=BE =D1=82=D1=83=D0=BD=D0=BD=D0=B5=D0=BB=D0=B8=D1=80=
=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F
>>> IP-=D1=81=D0=B5=D1=82=D0=B5=D0=B9 " \
>>>             "=D1=87=D0=B5=D1=80=D0=B5=D0=B7 =D0=B5=D0=B4=D0=B8=D0=BD=D1=
=81=D1=82=D0=B2=D0=B5=D0=BD=D0=BD=D1=8B=D0=B9 UDP-=D0=BF=D0=BE=D1=80=D1=82 =
=D1=81 =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=B6=D0=BA=D0=BE=D0=B9 =D0=B0=
=D1=83=D1=82=D0=B5=D0=BD=D1=82=D0=B8=D1=84=D0=B8=D0=BA=D0=B0=D1=86=D0=B8=D0=
=B8
>>> =D1=81=D0=B5=D1=81=D1=81=D0=B8=D0=B9 " \
>>> -          "=D0=B8 =D0=BE=D0=B1=D0=BC=D0=B5=D0=BD=D0=B0 =D0=BA=D0=BB=D1=
=8E=D1=87=D0=B0=D0=BC=D0=B8 =D0=BD=D0=B0 =D0=BE=D1=81=D0=BD=D0=BE=D0=B2=D0=
=B5 SSL/TLS, =D1=88=D0=B8=D1=84=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F,
>>> =D0=B0=D1=83=D1=82=D0=B5=D0=BD=D1=86=D0=B8=D1=84=D0=B8=D0=BA=D0=B0=D1=
=86=D0=B8=D0=B8 " \
>>> +          "=D0=B8 =D0=BE=D0=B1=D0=BC=D0=B5=D0=BD=D0=B0 =D0=BA=D0=BB=D1=
=8E=D1=87=D0=B0=D0=BC=D0=B8 =D0=BD=D0=B0 =D0=BE=D1=81=D0=BD=D0=BE=D0=B2=D0=
=B5 SSL/TLS, =D1=88=D0=B8=D1=84=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F,
>>> =D0=B0=D1=83=D1=82=D0=B5=D0=BD=D1=82=D0=B8=D1=84=D0=B8=D0=BA=D0=B0=D1=
=86=D0=B8=D0=B8 " \
>>>             "=D0=B8 =D1=81=D0=B6=D0=B0=D1=82=D0=B8=D1=8F =D0=BF=D0=B0=
=D0=BA=D0=B5=D1=82=D0=BE=D0=B2.\n" \
>>>             "\n" \
>>>             "Copyright (C) 2002-2005 OpenVPN Solutions LLC
>>> <info@...515...>\n" \
>>> @@ -164,7 +164,7 @@ BEGIN
>>>       IDS_MENU_SETTINGS "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=
=BA=D0=B8=E2=80=A6"
>>>       IDS_MENU_CLOSE "=D0=92=D1=8B=D1=85=D0=BE=D0=B4"
>>>       IDS_MENU_CONNECT "=D0=9F=D0=BE=D0=B4=D0=BA=D0=BB=D1=8E=D1=87=D0=
=B8=D1=82=D1=8C=D1=81=D1=8F"
>>> -    IDS_MENU_DISCONNECT "=D0=9E=D1=82=D0=BA=D0=BB=D1=8E=D1=87=D0=B8=D1=
=82=D1=81=D1=8F"
>>> +    IDS_MENU_DISCONNECT "=D0=9E=D1=82=D0=BA=D0=BB=D1=8E=D1=87=D0=B8=D1=
=82=D1=8C=D1=81=D1=8F"
>>>       IDS_MENU_STATUS "=D0=9E=D1=82=D0=BE=D0=B1=D1=80=D0=B0=D0=B7=D0=B8=
=D1=82=D1=8C =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5"
>>>       IDS_MENU_VIEWLOG "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=
=8C =D0=B6=D1=83=D1=80=D0=BD=D0=B0=D0=BB"
>>>       IDS_MENU_EDITCONFIG "=D0=A0=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=B8=
=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D0=BA=D0=BE=D0=BD=D1=84=D0=B8=D0=B3=
=D1=83=D1=80=D0=B0=D1=86=D0=B8=D1=8E"
>>> @@ -253,7 +253,7 @@ BEGIN
>>>                     "--log_dir\t\t\t: =D0=9F=D1=83=D1=82=D1=8C =D0=BA =
=D0=BF=D0=B0=D0=BF=D0=BA=D0=B5 =D1=81 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0=D0=BC=
=D0=B8 =D0=B6=D1=83=D1=80=D0=BD=D0=B0=D0=BB=D0=B0.\n"
>>> \
>>>                     "--priority_string\t\t: =D0=A1=D1=82=D1=80=D0=BE=D0=
=BA=D0=B0 =D0=BF=D1=80=D0=B8=D0=BE=D1=80=D0=B8=D1=82=D0=B5=D1=82=D0=B0 (=D0=
=A1=D0=BC.
>>> install.txt =D0=B4=D0=BB=D1=8F =D0=B4=D0=BE=D0=BF. =D0=B8=D0=BD=D1=84=
=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D0=B8).\n" \
>>>                     "--append_string\t\t: 1=3D=D0=9F=D1=80=D0=B8=D1=81=
=D0=BE=D0=B5=D0=B4=D0=B8=D0=BD=D1=8F=D1=82=D1=8C =D0=BA =D1=84=D0=B0=D0=B9=
=D0=BB=D1=83
>>> =D0=B6=D1=83=D1=80=D0=BD=D0=B0=D0=BB=D0=B0. 0=3D=D0=9E=D1=87=D0=B8=D1=
=89=D0=B0=D1=82=D1=8C =D1=84=D0=B0=D0=B9=D0=BB =D0=B6=D1=83=D1=80=D0=BD=D0=
=B0=D0=BB=D0=B0 =D0=BF=D1=80=D0=B8 =D1=81=D0=BE=D0=B5=D0=B4=D0=B8=D0=BD=D0=
=B5=D0=BD=D0=B8=D0=B8.\n" \
>>> -                  "--log_viewer\t\t: =D0=9F=D1=83=D1=82=D1=8C =D0=BA =
=D0=BF=D1=80=D0=BE=D1=81=D0=BC=D0=BE=D1=82=D1=80=D0=BE=D0=B2=D1=89=D0=B8=D0=
=BA=D1=83
>>> =D0=B6=D1=83=D1=80=D0=BD=D0=B0=D0=BB=D0=B0r.\n" \
>>> +                  "--log_viewer\t\t: =D0=9F=D1=83=D1=82=D1=8C =D0=BA =
=D0=BF=D1=80=D0=BE=D1=81=D0=BC=D0=BE=D1=82=D1=80=D0=BE=D0=B2=D1=89=D0=B8=D0=
=BA=D1=83 =D0=B6=D1=83=D1=80=D0=BD=D0=B0=D0=BB=D0=B0.\n"
>>> \
>>>                     "--editor\t\t\t: =D0=9F=D1=83=D1=82=D1=8C =D0=BA =
=D1=80=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=BE=D1=80=D1=83 =D0=BA=D0=BE=D0=BD=
=D1=84=D0=B8=D0=B3=D1=83=D1=80=D0=B0=D1=86=D0=B8=D0=B8.\n" \
>>>                     "--allow_edit\t\t: 1=3D=D0=9F=D0=BE=D0=BA=D0=B0=D0=
=B7=D0=B0=D1=82=D1=8C =D0=BF=D1=83=D0=BD=D0=BA=D1=82 =D0=BC=D0=B5=D0=BD=D1=
=8E
>>> =D0=A0=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=
=82=D1=8C =D0=BA=D0=BE=D0=BD=D1=84=D0=B8=D0=B3=D1=83=D1=80=D0=B0=D1=86=D0=
=B8=D1=8E.\n" \
>>>                     "--allow_service\t\t: 1=3D=D0=9F=D0=BE=D0=BA=D0=B0=
=D0=B7=D0=B0=D1=82=D1=8C =D0=BC=D0=B5=D0=BD=D1=8E =D0=A1=D0=BB=D1=83=D0=B6=
=D0=B1=D0=B0
>>> OpenVPN.\n" \
> -------------------------------------------------------------------------=
-----
> Presto, an open source distributed SQL query engine for big data, initial=
ly
> developed by Facebook, enables you to easily query your data on Hadoop in=
 a
> more interactive manner. Teradata is also now providing full enterprise
> support for Presto. Download a free open source copy now.
> http://pubads.g.doubleclick.net/gampad/clk?id=3D250295911&iu=3D/4140
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>



