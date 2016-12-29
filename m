From: "Morris, Russell" <rmorris@...1315...>
Date: Thu, 29 Dec 2016 18:07:41 +0000
Message-ID: <BN3PR0801MB21784AE9B26383369CD92FB1B96B0@...2222...>
References: <BN3PR0801MB217880CEEA7136F564901C3FB96B0@...2222...>
	<d44d622e-8834-ec81-85a5-3b8c296ab7a7@...515...>
	<BN3PR0801MB217827E689DB44305463AC68B96B0@...2222...>
	<786900e2-0abc-bacb-ae49-c5aedfca8d7a@...515...>
In-Reply-To: <786900e2-0abc-bacb-ae49-c5aedfca8d7a@...515...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN Service Flagged as Trojan
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

That's good - thanks! Not sure how to fix Windows flagging this though - I'=
m assuming others will have the same issue.

... Russell



-----Original Message-----
From: Samuli Sepp=E4nen [mailto:samuli@...515...]=20
Sent: Thursday, December 29, 2016 12:03 PM
To: Morris, Russell <rmorris@...1315...>; openvpn-devel@...1223...=
et
Subject: Re: [Openvpn-devel] OpenVPN Service Flagged as Trojan

Your sha1sum matches that of "openvpnserv2-1.3.0.0.exe" on the download ser=
ver, which is correct. So there is nothing suspicious about your copy of op=
envpnserv2.exe.

Samuli

Il 29/12/2016 18:40, Morris, Russell ha scritto:
> Hi,
>
> Sure you bet! Had to restore it from Quarantine (was removed by Window De=
fender). Here are the checksums - do they look right?
>
> SHA-1: 12A92A1314394994E5493DEEDECCE1B885E88497
> MD5: 4628C852B721472918C0F07C954AD11D
> CRC32: BC4B4D67
>
> Thanks,
> ... Russell
>
>
> -----Original Message-----
> From: Samuli Sepp=E4nen [mailto:samuli@...515...]
> Sent: Thursday, December 29, 2016 3:44 AM
> To: Morris, Russell <rmorris@...1315...>;=20
> openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] OpenVPN Service Flagged as Trojan
>
> Hi Russell,
>
> Interesting. Can you send me the sha1sum or md5sum of your openvpnserv2.e=
xe?
>
> We've typically had false positives related to the OpenVPN installers, bu=
t never with the bundled executables afaik.
>
> Samuli
>
> Il 29/12/2016 05:45, Morris, Russell ha scritto:
>> Something you may want to know about - at least on my Windows 10=20
>> machine, when I try to run openvpnserv2.exe . Windows Defender=20
>> identifies it as a Trojan - quarantines and removes it . L.
>>
>>
>>
>> Thanks,
>>
>> . Russell
>>
>>
>>
>>
>>
>>
>>
>> ---------------------------------------------------------------------
>> -
>> -------- Check out the vibrant tech community on one of the world's=20
>> most engaging tech sites, SlashDot.org! http://sdm.link/slashdot
>>
>>
>>
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
>
>



