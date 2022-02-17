MIME-Version: 1.0
References: <20220107145359.311-1-lstipakov@...277...>
 <CAGyAFMXNQnQ_jeoQXJSkW8xXn8QM0nqeJHYB5xL288U6t+TcJw@...278...>
 <CAFHpkQFwO0qMqWhtUidv0TNWyGrsnMHqYVib12yCzowBgL1KtQ@...278...>
 <CAFHpkQE-LBkt-Lyz97vLdgQFt7VPLmedw8ogNojVy2p3GsdaiQ@...278...>
In-Reply-To: <CAFHpkQE-LBkt-Lyz97vLdgQFt7VPLmedw8ogNojVy2p3GsdaiQ@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 17 Feb 2022 10:53:00 +0200
Message-ID: <CAGyAFMWQLs2=BoF6fhUcG6gLN5LvPA9xHZ8JRocdH5-DL5LW_w@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2.5] msvc: adjust build options to
 harden binaries
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

Hi,

Thanks for testing.

> original patch does not apply

Indeed it doesn't apply anymore since recent changes to vcxproj files.
I have rebased it.

> minor build issues still there: test =C2=B7 chipitsine/openvpn@...2652...=
 (github.com)

Those are likely because this was not applied
https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21774.h=
tml
to your 2.5 branch.
I have mentioned it in the patch email, but not in a commit message.

> also, I have a question on <SDLCheck>true</SDLCheck>, in your patch it is=
 not applied to all configurations, but to few of them. is it on purpose ?

For some reasons I missed debug configurations in some projects, I'll add t=
hose.

Here are my GHa builds:

master: https://github.com/lstipakov/openvpn/actions/runs/1857589993
release/2.5: https://github.com/lstipakov/openvpn/actions/runs/1857547158

--=20
-Lev

