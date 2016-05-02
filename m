References: <CAFHpkQENgyAaaWCsWOS1vj+9YR=Cc65muXmsYfmcKc8n09BkPQ@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <5727056E.1000701@...515...>
Date: Mon, 2 May 2016 10:44:46 +0300
MIME-Version: 1.0
In-Reply-To: <CAFHpkQENgyAaaWCsWOS1vj+9YR=Cc65muXmsYfmcKc8n09BkPQ@...278...>
Subject: Re: [Openvpn-devel] CI for openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hello,
>
> I just run cppcheck and ...
>
> [src/openvpnserv/interactive.c:601]: (error) Memory pointed to by
> 'addr_row' is freed twice.
> [src/openvpnserv/interactive.c:700]: (error) Memory pointed to by
> 'fwd_row' is freed twice.
> [src/openvpnserv/interactive.c:1329]: (error) Common realloc mistake:
> 'handles' nulled but not freed upon failure
>
> I suggest to either
>
> 1) add travis-ci support (there are few tests in "t" and we can run
> cppcheck)
> 2) add cppcheck to buildbot (however it is not transparent, I've no idea
> where can I have a look at buildbot logs, for example)

I assume cppcheck produces the same results regardless of the=20
OS/distribution it is running on. If this is the case, then we should=20
add cppcheck tests to Travis-CI.

Using buildbot to running an identical check 150+ times per commit makes=20
no sense.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

