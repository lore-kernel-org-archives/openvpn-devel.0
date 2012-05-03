MIME-Version: 1.0
In-Reply-To: <4FA263B8.5020901@...515...>
References: <CAOazyz15xpgFxzqQFaotZSmS2=-gSmUsMMwy=SZay6bi3EEMAg@...278...>
	<1332621070-28464-1-git-send-email-alon.barlev@...277...>
	<4F9A5EB7.902@...515...> <2620278.PZKTmmtf1E@...1526...>
	<4F9A8928.9080703@...515...>
	<CAOazyz0MOwBnqm5_wpN-Db_ZCbd-p31Gqy4Czm=GNZS8yfN3ZQ@...278...>
	<4FA23334.7030406@...1114...>
	<CAOazyz3cAmjfHFbXqo80RfSbPeRMZ=QAb1UVDHaSRSR3xE4Seg@...278...>
	<4FA263B8.5020901@...515...>
Date: Thu, 3 May 2012 20:47:32 +0300
Message-ID: <CAOazyz0eYxwfMztiy8zRzqktQ_SdxOU_S3guGJWkZN86NoA4dw@...278...>
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
Cc: James Yonan <james@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Thu, May 3, 2012 at 1:53 PM, Samuli Sepp=C3=A4nen <samuli@...515...> wro=
te:
>
>> On Thu, May 3, 2012 at 10:26 AM, David Sommerseth
>> <openvpn.list@...1114...> wrote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> On 27/04/12 14:15, Alon Bar-Lev wrote:
>>>> 2012/4/27 Samuli Sepp=C3=A4nen <samuli@...515...>:
>>>>> Il 27.04.2012 12:18, Heiko Hund ha scritto:
>>>>>> On Friday 27 April 2012 09:54:15 Samuli Sepp=C3=A4nen wrote:
>>>>>>> Anyways, I cross-compiled latest "master" with this patch
>>>>>>> applied and "bin" and "lib" directories on top of an existing
>>>>>>> openvpn-2.3-alpha1 install. The old "bin" directory was
>>>>>>> renamed to make sure none of it was used. I then renamed
>>>>>>> "openvpn.ovpn" to "=C3=A4=C3=A4li=C3=B6.ovpn" and "ta.key" to "=C3=
=A4=C3=A4li=C3=B6.key"
>>>>>>> using Windows Explorer. Then I updated the configuration file
>>>>>>> to point to these files using Notepad (and later Wordpad).
>>>>>> Notepad saves UTF-8 files with BOM, which is very uncommon.
>>>>>> Maybe that was the problem. I ran into that when I was testing
>>>>>> my patch. You might want to try using Notepad++ and save it as
>>>>>> UTF-8 without BOM.
>>>>>>
>>>>>> HTH Heiko
>>>>> Saved the configuration file to UTF-8 without BOM - after this I
>>>>> got no complaints from OpenVPN-GUI. Launching OpenVPN from the
>>>>> command prompt also worked... tls-auth was undefined in the
>>>>> config, and openvpn called like this:
>>>> if bom is a problem we should handle it properly in options.c, as
>>>> we cannot expect users to understand bom issues.
>>>>
>>>>>> openvpn --config =C3=A4=C3=A4li=C3=B6.ovpn --tls-auth =C3=A4=C3=A4li=
=C3=B6.key 1
>>>>> Only minor issue was that the command prompt displayed funky
>>>>> characters instead of the proper ones:
>>>>>
>>>>> <http://users.utu.fi/sjsepp/cmd2.png>
>>>> Yes. this is OK.
>>> Just so that I understand this more properly. =C2=A0The reason this is
>>> okay, is that because cmd.exe is not UTF-8 capable when displaying the
>>> log data?
>> Yes.
>> The cmd uses the plain old DOS code page, and needs special fonts.
>> If you add --log parameter you will see this correctly.
>>
>> Alon.
>>
> Tested with --log parameter. The logfile[1] seems to use the UTF-8
> encoding, and with proper viewers/editors the Scandinavian characters
> (a/o umlauts, =C3=A4/=C3=B6) look just fine. On Windows most editors/view=
ers[3]
> display funky two-byte characters, but that's probably expected.
>
> [1] An example log file is available here, search for "tls_auth_file":
> <http://users.utu.fi/sjsepp/openvpn-log.txt>
> [2] E.g. less and vi (in Git Bash), Wordpad, etc.
>

So I guess now we are good.
Is anything else missing?

Alon.

