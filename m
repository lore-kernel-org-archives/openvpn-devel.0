From: Heiko Hund <heiko@...2662...>
Date: Tue, 21 Jan 2025 01:00:45 +0100
Message-ID: <14650544.uLZWGnKmhe@...2664...>
In-Reply-To: <CAEsd45THxw2U9g=dWvx0_Mutw5KHq3+tvtpyO_xYe3MTOoM+Qw@...278...>
References: <gerrit.1733989644000.I3fb01ab76cf3df0874ba92e08f371d17607a8369@...2715...>
 <5948319.31r3eYUQgx@...2664...>
 <CAEsd45THxw2U9g=dWvx0_Mutw5KHq3+tvtpyO_xYe3MTOoM+Qw@...278...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [L] Change in openvpn[master]: dns: don't
 publish env vars to non-dns scripts
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net, frank@...2641...

On Dienstag, 21. Januar 2025 00:06:19 CET Jonathan K. Bullard wrote:
> On Mon, Jan 20, 2025 at 2:38=E2=80=AFPM Heiko Hund <heiko@...515...> wrot=
e:
> > Yes, that is the intended behavior. However, I'll port the macos DNS
> > setting
> > code from openvpn3 to a macos --dns-script for openvpn 2, which will run
> > automatically. DNS will not break this way, but depending on how the --=
up
> > script is written, that one might. I've not come up with an idea on how=
 to
> > prevent this potential breakage, besides a warning in the release notes
> > unfortunately.
>=20
> Thanks. That will impact Tunnelbllick because we set DNS in our own up/do=
wn
> scripts. But I understand the reasons for the change.
>=20
> Am I correct that the plan for this to go into 2.7 or later, and not into
> 2.6?

Right, the plan is to ship this in 2.7, as it is a way too large change for=
=20
slipping it in somewhere in between.=20

Heiko



