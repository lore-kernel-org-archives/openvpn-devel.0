Message-ID: <4F475356.9020508@...515...>
Date: Fri, 24 Feb 2012 11:07:34 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <CAOazyz3CAK6Huf7qzAv_Uv+bn5QFFd_cC7A8S_s42HZQGNLC4g@...278...>
In-Reply-To: <CAOazyz3CAK6Huf7qzAv_Uv+bn5QFFd_cC7A8S_s42HZQGNLC4g@...278...>
Subject: Re: [Openvpn-devel] [build] Windows build test
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>


> Hello people who actually use Windows!
>
> I will appreciate if you test my new windows build environment for OpenVP=
N.
>
>
> Visual Studio Complete Batch
>
> install perl
>
>> cd msvc
>> build
> Visual Studio IDE
>
> After you have the dependencies of Complete Batch or your own.
> Create msvc-env-local.bat with OPENVPN_DEPROOT pointing to the
> location of the dependencies.
>
>> msvc-dev
> MSBuild
>
> After you have the dependencies of Complete Batch or your own.
> Create msvc-env-local.bat with OPENVPN_DEPROOT pointing to the
> location of the dependencies.
>
>> msvc-build
>

Hi Alon,

I tried building OpenVPN using the "Visual Studio Complete Batch" method:

$ cd msvc
$ build

All went fine until OpenVPN build itself. The error message is here:

<http://pastebin.com/2uJM4n3y>

A couple of questions:

a) What is the "Complete Batch"?
b) Do I need to create an OpenVPN Visual Studio IDE project to build?
c) Can I avoid b) somehow?

Btw. I started a new Wiki page explaining the new buildsystem:

<https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsystem>

The instructions are mostly from your mails, I just edited them a
little. I hope that's ok for you.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


