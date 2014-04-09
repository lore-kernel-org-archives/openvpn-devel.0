MIME-Version: 1.0
In-Reply-To: <53442B8A.2030105@...515...>
References: <5343BCAB.3040102@...1790...> <0LikyX-1X9YfO48dR-00d2sy@...1825...>
	<1CED409804E2164C8104F9E623B08B90170093CD3A@...1436...>
	<5343E392.1010803@...1800...>
	<1CED409804E2164C8104F9E623B08B90170093CE96@...1436...>
	<5343FF41.3080406@...1879...> <5344111D.3080408@...515...>
	<5344145F.3010702@...515...> <53442B8A.2030105@...515...>
Date: Wed, 9 Apr 2014 14:25:30 +0600
Message-ID: <CAFHpkQE-6kqi+RT4oF_F+4YULRd=NtJ3rCNK-YR+JrGM47s-sw@...278...>
From: =?KOI8-R?B?6czY0SD7ydDJw8nO?= <chipitsine@...277...>
Subject: Re: [Openvpn-devel] Heartbleed
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
To: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

am I right that "nobind" option gives some protection to windows
openvpn client ?

2014-04-08 23:02 GMT+06:00 Samuli Sepp=E4nen <samuli@...515...>:
>
>>>> Hi,
>>>>
>>>> Am 08.04.2014 15:42, schrieb Steffan Karger:
>>>>>> Perhaps a dumb question, but if the server instance is linked
>>>>>> against an older version of openssl (9.8.x), but the client is
>>>>>> compiled and linked against the vulnerable version, is it still an
>>>>>> issue for both sides, or is the client going to leak private
>>>>>> information ?
>>>>> The client can then leak keys (both private master key and session
>>>>> keys), which completely breaks your secure connection, for that
>>>>> client.
>>>>>
>>>>> So when the server is not vulnerable, each client has to be attacked
>>>>> individually, and not-vulnerable clients have a secure connection to
>>>>> the server. As long as there are vulnerable clients, you should
>>>>> consider those as potentially malicious, and thus you should consider
>>>>> the network as insecure.
>>>> Then OpenVPN should release new Windows Versions.
>>>> The current binaries are linked against OpenSSL (ssleay32.dll,
>>>> libeay32.dll) 1.0.1.5 (-> 1.0.1e).
>>>>
>>>>
>>> Hi all,
>>>
>>> We'll try to push OpenVPN 2.3.3 out today. The Windows installer will
>>> contain OpenSSL 1.0.1g which fixes this particular problem. In addition
>>> several other small changes and enhancements will be included.
>>>
>> Minor correction: I will build and publish OpenVPN 2.3.2 Windows
>> installers with OpenSSL 1.0.1g today; this will fix the security problem
>> at hand. OpenVPN 2.3.3 will follow on Thursday, if I encounter no big
>> problems with the changes it contains.
>>
> An updated installer (I004) with OpenSSL 1.0.1g is now out:
>
> <http://openvpn.net/index.php/download/community-downloads.html>
>
> I smoketested the installers on Windows 7 64-bit and WinXP 32-bit.
>
> --
> Samuli Sepp=E4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
>
> -------------------------------------------------------------------------=
-----
> Put Bad Developers to Shame
> Dominate Development with Jenkins Continuous Integration
> Continuously Automate Build, Test & Deployment
> Start a new project now. Try Jenkins in the cloud.
> http://p.sf.net/sfu/13600_Cloudbees
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

