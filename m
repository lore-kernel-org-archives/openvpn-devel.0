Message-ID: <4FD079C7.6070406@...515...>
Date: Thu, 07 Jun 2012 12:52:07 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4FD0735C.7090902@...515...> <CBF6422A.24DA%brabander@...1435...>
	<1CED409804E2164C8104F9E623B08B9012D498A813@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B9012D498A813@...1436...>
Subject: Re: [Openvpn-devel] PolarSSL 1.1.0 support?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Adriaan de Jong <dejong@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>> -----Original Message-----
>> From: Frank de Brabander [mailto:brabander@...1435...]
>> Sent: donderdag 7 juni 2012 11:36
>> To: Samuli Sepp=E4nen; openvpn-devel@lists.sourceforge.net
>> Subject: Re: [Openvpn-devel] PolarSSL 1.1.0 support?
>>
>> Maybe this should actually be changed to >=3D 1.1.2, since there is a
>> security issue with versions from 0.99-pre4 up to and including
>> PolarSSL 1.1.1.
>>
> The trouble there is that some distro's tend to only backport the securit=
y patches, and not the version patches. This would throw an extra obstacle =
in their way. Is it really our responsibility to verify that you are using =
a secure version of an SSL library?=20
>
> Adriaan
I think it's the packager's responsibility to use/depend on secure
versions of libraries - either latest ones or ones with backported
security fixes. Also, if we did this for PolarSSL, we'd have to do it
for OpenSSL and all other dependencies as well.

Samuli

