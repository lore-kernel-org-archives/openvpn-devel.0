MIME-Version: 1.0
In-Reply-To: <CAOazyz0MOwBnqm5_wpN-Db_ZCbd-p31Gqy4Czm=GNZS8yfN3ZQ@...278...>
References: <CAOazyz15xpgFxzqQFaotZSmS2=-gSmUsMMwy=SZay6bi3EEMAg@...278...>
	<1332621070-28464-1-git-send-email-alon.barlev@...277...>
	<4F9A5EB7.902@...515...> <2620278.PZKTmmtf1E@...1526...>
	<4F9A8928.9080703@...515...>
	<CAOazyz0MOwBnqm5_wpN-Db_ZCbd-p31Gqy4Czm=GNZS8yfN3ZQ@...278...>
Date: Wed, 2 May 2012 12:18:29 +0300
Message-ID: <CAOazyz10RU=mgOw==iWRWAvtuxF8Lb2WHa=cJgKqb4jJO4FRkA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] cleanup: windows: convert argv (UCS-2
 to UTF-8) at earliest
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

News?

On Fri, Apr 27, 2012 at 3:15 PM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> 2012/4/27 Samuli Sepp=C3=A4nen <samuli@...515...>:
>> Il 27.04.2012 12:18, Heiko Hund ha scritto:
>>> On Friday 27 April 2012 09:54:15 Samuli Sepp=C3=A4nen wrote:
>>>> Anyways, I cross-compiled latest "master" with this patch applied and
>>>> "bin" and "lib" directories on top of an existing openvpn-2.3-alpha1
>>>> install. The old "bin" directory was renamed to make sure none of it w=
as
>>>> used. I then renamed "openvpn.ovpn" to "=C3=A4=C3=A4li=C3=B6.ovpn" and=
 "ta.key" to
>>>> "=C3=A4=C3=A4li=C3=B6.key" using Windows Explorer. Then I updated the =
configuration
>>>> file to point to these files using Notepad (and later Wordpad).
>>> Notepad saves UTF-8 files with BOM, which is very uncommon. Maybe that =
was the
>>> problem. I ran into that when I was testing my patch. You might want to=
 try
>>> using Notepad++ and save it as UTF-8 without BOM.
>>>
>>> HTH
>>> Heiko
>> Saved the configuration file to UTF-8 without BOM - after this I got no
>> complaints from OpenVPN-GUI. Launching OpenVPN from the command prompt
>> also worked... tls-auth was undefined in the config, and openvpn called
>> like this:
>
> if bom is a problem we should handle it properly in options.c, as we
> cannot expect users to understand bom issues.
>
>>
>>> openvpn --config =C3=A4=C3=A4li=C3=B6.ovpn --tls-auth =C3=A4=C3=A4li=C3=
=B6.key 1
>>
>> Only minor issue was that the command prompt displayed funky characters
>> instead of the proper ones:
>>
>> <http://users.utu.fi/sjsepp/cmd2.png>
>
> Yes. this is OK.
>
> Alon.

