MIME-Version: 1.0
In-Reply-To: <950C8167-A5FF-4F56-9020-C956EED49557@...2127...>
References: <950C8167-A5FF-4F56-9020-C956EED49557@...2127...>
From: Steffan Karger <steffan@...1856...>
Date: Sat, 23 Apr 2016 11:09:02 +0200
Message-ID: <CAA1Abx+O2t5shgYK44ddmowGiVwV10D+VESfpbyHpq6a8Dc48g@...278...>
Subject: Re: [Openvpn-devel] Unit testing in openvpn?
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
To: Jens <openvpn-devel@...2127...>
Cc: openvpn-devel <Openvpn-devel@lists.sourceforge.net>

On Thu, Apr 21, 2016 at 9:12 AM, Jens <openvpn-devel@...2127...> wrote:
> What are your thoughts? Should we add unit tests at all? What would be yo=
ur preferred way for dependency management. Please defer discussion on /whi=
ch/ unit testing framework to use until we have an agreement on the /if/ an=
d /how/ (just to prevent the =E2=80=98paint the bike shed=E2=80=99 discussi=
on).

Yes, adding unit tests (or at least, a working framework to create
unit tests) is welcome.  We should realize that a large part of the
2.x codebase is really hard to test this way, but for those parts we
can isolate, this still makes sense.

We currently do dependency management through configure / autoconf.
It's not perfect, but we have it in place.  I think I'd prefer using
that for a test framework too, if possible (ie, if 'link to
libxyztest' suffices).

I recognize the risk of bike shedding, but I'm afraid the way we would
integrate a test framework greatly depends on how it works...  Do you
know what are common C test suites / do you have any suggestions?
(For C, I've only worked with proprietary test suites before).

-Steffan

