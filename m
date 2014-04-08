Message-ID: <5344145F.3010702@...515...>
Date: Tue, 08 Apr 2014 18:23:11 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <5343BCAB.3040102@...1790...>	<0LikyX-1X9YfO48dR-00d2sy@...1825...>	<1CED409804E2164C8104F9E623B08B90170093CD3A@...1436...>	<5343E392.1010803@...1800...>	<1CED409804E2164C8104F9E623B08B90170093CE96@...1436...>	<5343FF41.3080406@...1879...>
	<5344111D.3080408@...515...>
In-Reply-To: <5344111D.3080408@...515...>
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
To: =?ISO-8859-1?Q?Enno_Gr=F6per?= <groepeen@...1879...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>> Hi,
>>
>> Am 08.04.2014 15:42, schrieb Steffan Karger:
>>>> Perhaps a dumb question, but if the server instance is linked
>>>> against an older version of openssl (9.8.x), but the client is
>>>> compiled and linked against the vulnerable version, is it still an
>>>> issue for both sides, or is the client going to leak private
>>>> information ?
>>> The client can then leak keys (both private master key and session
>>> keys), which completely breaks your secure connection, for that
>>> client.
>>>
>>> So when the server is not vulnerable, each client has to be attacked
>>> individually, and not-vulnerable clients have a secure connection to
>>> the server. As long as there are vulnerable clients, you should
>>> consider those as potentially malicious, and thus you should consider
>>> the network as insecure.
>> Then OpenVPN should release new Windows Versions.
>> The current binaries are linked against OpenSSL (ssleay32.dll,=20
>> libeay32.dll) 1.0.1.5 (-> 1.0.1e).
>>
>>
> Hi all,
>
> We'll try to push OpenVPN 2.3.3 out today. The Windows installer will
> contain OpenSSL 1.0.1g which fixes this particular problem. In addition
> several other small changes and enhancements will be included.
>
Minor correction: I will build and publish OpenVPN 2.3.2 Windows
installers with OpenSSL 1.0.1g today; this will fix the security problem
at hand. OpenVPN 2.3.3 will follow on Thursday, if I encounter no big
problems with the changes it contains.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


