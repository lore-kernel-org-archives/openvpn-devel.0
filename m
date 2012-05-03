MIME-Version: 1.0
Sender: fabian@...1547...
In-Reply-To: <4FA239AB.4080308@...1114...>
References: <1335636013-7717-1-git-send-email-alon.barlev@...277...>
	<4FA239AB.4080308@...1114...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Thu, 3 May 2012 15:33:16 +0200
Message-ID: <CAP+U6t+wn7bcxssSjiuQXFks_4W6EySrh+VjnBth5Go55etGbw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] build: add git revision to --version
 output if build from git repository
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, openvpn-devel@lists.sourceforge.net

Hi,

2012/5/3 David Sommerseth <openvpn.list@...1114...>:
> What I would like to see is something more like what's found in TOR
> projects' obfsproxy, where the Makefile generates a micro-version.i,
> which is included. =C2=A0As this file is forced to be (re-)created each
> time, it will always be accurate.
>
> I don't say that obfsproxy have done the implementation correct, but
> it can at least be a seed for inspiration:

I agree that the Makefile-based approach is more useful. Regarding the
implementation: Depending on compile vs link time it might be faster
to move the re-compiled part into a dedicated version.c which only
contains a

  const char *get_ovpn_version()
  {
    return PACKAGE_VERSION_EXTRA_GIT_REVISION;
  }

Cheers
Fabian

