MIME-Version: 1.0
In-Reply-To: <CBF6422A.24DA%brabander@...1435...>
References: <4FD0735C.7090902@...515...> <CBF6422A.24DA%brabander@...1435...>
Date: Thu, 7 Jun 2012 12:41:25 +0300
Message-ID: <CAOazyz09OYEq+8-vKDH98ac7qe7GzLxvjuTVQPfGVQrR0OsCEg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] PolarSSL 1.1.0 support?
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
To: Frank de Brabander <brabander@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello,
Build system should only care about the interface, not the "quality"
of the dependency.
So if we are built OK with >=3D1.1.0 than this should be the boundary.
Thanks,
Alon.

On Thu, Jun 7, 2012 at 12:35 PM, Frank de Brabander
<brabander@...1435...> wrote:
> Maybe this should actually be changed to >=3D 1.1.2, since there is a
> security issue with versions from 0.99-pre4 up to and including PolarSSL
> 1.1.1.
>
> On 07-06-12 11:24, "Samuli Sepp=C3=A4nen" <samuli@...515...> wrote:
>
>>Hi,
>>
>>I noticed that my Ubuntu 10.04 and 12.04 buildslaves which had PolarSSL
>>1.1.0 failed build during the configure phase:
>>
>>checking polarssl version... configure: error: invalid polarssl version
>>
>>Updating to PolarSSL 1.1.1 or later solves this issue. However, commit
>>1d92d06dca5ac says "Removed support for PolarSSL < 1.1", so 1.1.0 should
>>work, right?
>>
>>--
>>Samuli Sepp=C3=A4nen
>>Community Manager
>>OpenVPN Technologies, Inc
>>
>>irc freenode net: mattock
>>
>>
>>
>>
>>
>>--------------------------------------------------------------------------
>>----
>>Live Security Virtual Conference
>>Exclusive live event will cover all the ways today's security and
>>threat landscape has changed and how IT managers can respond. Discussions
>>will include endpoint security, mobile security and the latest in malware
>>threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
>>_______________________________________________
>>Openvpn-devel mailing list
>>Openvpn-devel@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>
> -------------------------------------------------------------------------=
-----
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond. Discussions
> will include endpoint security, mobile security and the latest in malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

