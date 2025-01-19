MIME-Version: 1.0
References: <gerrit.1733989644000.I3fb01ab76cf3df0874ba92e08f371d17607a8369@...2715...>
 <a7e11016a114631f281dc7c769e55533a80728ac-EmailReplacePatchSet-HTML@...2715...>
In-Reply-To: <a7e11016a114631f281dc7c769e55533a80728ac-EmailReplacePatchSet-HTML@...2715...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Sun, 19 Jan 2025 18:02:46 -0500
Message-ID: <CAEsd45SvAi2eqYYqfajzVnwxK9TuN6cO9PskoQk2oNAC8pu_Qg@...278...>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: heiko@...515..., arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net, frank@...2641...

HI.

On Mon, Jan 13, 2025 at 8:13=E2=80=AFAM d12fk (Code Review) <gerrit@...2092...=
..> wrote:

> With --dns-script in place we no longer need DNS related vars in the
> environment for other script hooks. Code for doing that is removed and
> the function to set --dns stuff made static, for internal use only.
>
> Another thing: since --dns setting overrule DNS related --dhcp-options,
> remove the latter when we got some via --dns.

Does this mean that if there are --dns options which override
--dns-options options, then (for macOS) the foreign_options_N
environment variables related to DNS will not be passed to the up/down
scripts? That would be a a *major* breaking change.

Best regards,

Jon Bullard (Tunnelblick developer)

