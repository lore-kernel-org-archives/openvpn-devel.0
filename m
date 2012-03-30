Message-ID: <4F7599E8.5070100@...515...>
Date: Fri, 30 Mar 2012 14:32:56 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <CAOazyz065tGCsmMkqCy57+jHcBLFCuOTBfbtFaeiQYBg5Ye15w@...278...>
	<4F72EF52.8060301@...515...> <4F73B8AD.50408@...1388...>
In-Reply-To: <4F73B8AD.50408@...1388...>
Subject: Re: [Openvpn-devel] [DISCUSS] OpenVPN public repositories at
	github.com
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
To: Michal Ludvig <mludvig@...1388...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> On 03/29/2012 12:00 AM, Samuli Sepp=E4nen wrote:
>> That said, the code itself is hosted externally on SF.net, so we have
>> the _option_ of using GitHub for that part. I'd first look at the big
>> picture of how we want to enhance our development processes and then
>> move on to the tools.
> Although I'm not an OpenVPN developer I've got a real world experience=20
> with moving a project to github. For years I've had my little s3cmd=20
> project (http://s3tools.org/s3cmd) hosted in SVN on SF.net and really=20
> struggled to attract contributors. Once I moved to GIT and github.com=20
> people pretty much immediately begun forking the code, developing=20
> improvements and sending back merge requests:
> https://github.com/s3tools/s3cmd/network
> Obviously I don't merge everything they send me but the contributor base=
=20
> truly exploded and very many improvements now come from these random=20
> developers.
>
> I still keep a copy of the repository in SF.net's GIT but almost never=20
> receive any emailed patches or any feedback at all on that front. All my=
=20
> contributors use github.
>
> Just my 2 cents :)
>
Hmm, interesting. I have a couple of projects at GitHub myself, but
they're for a very limited audience, so I haven't experienced any
contributor explosions myself :).

I think the GitHub approach might help get a lot more contributions from
"random" developers. At the moment, they'd have to go through quite a
hassle to contribute:

1) Figure out where to send the patches (told in the Wiki)
2) Figure out how to subscribe to openvpn-devel
3) Figure out how git-send-email works
4) Send mail to openvpn-devel
5) Make modifications, if required
6) Unsubscribe / filter openvpn-devel mails, unless they want their
inbox to clutter with stuff

GitHub would help with 1-4 and 6. Perhaps we should experiment with
using GitHub as an _alternative_ to mailing list patches and see what
happens? The official development trees could still be hosted at SF.net.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


