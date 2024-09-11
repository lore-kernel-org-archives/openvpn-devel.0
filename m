MIME-Version: 1.0
References: <20240719131407.75746-1-frank@...2641...>
 <202409090656.4896u92M048226@...2054...>
 <CAKuzo_ixFOt8oNUo1yEd+8rO5R-ThLWVp1cGT4N_ini5J5st4Q@...278...>
 <Zt8sCjW3PqcW2EQc@...1296...>
In-Reply-To: <Zt8sCjW3PqcW2EQc@...1296...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Wed, 11 Sep 2024 07:17:37 -0400
Message-ID: <CAEsd45RYVCHMk+=QOj9xKimG5hFT4PsWiKtp0U3hFpZyF6KGNg@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Static-challenge
 concatenation option
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
To: Gert Doering <gert@...1296...>
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel@lists.sourceforge.net

Hi,

On Mon, Sep 9, 2024 at 1:11=E2=80=AFPM Gert Doering <gert@...1296...> wrote:
>
> Hi,
>
> On Mon, Sep 09, 2024 at 12:01:54PM -0400, Selva Nair wrote:
> > > Is the GUI support already committed?  I seem to remember seeing a PR
> > > for that "weeks ago"... and someone needs to bring Tunnelblick on boa=
rd.
> >
> > I've sent a note to Jon about the change.

The heads-up was much appreciated, Selva.

Tunnelblick has had a mechanism to concatenate the response to the
user's password for about six years. (How the time flies!) I've made
changes so Tunnelblick can use the new OpenVPN mechanism, too. The
changes will be included in the next Tunnelblick beta release.

While working on this, I was able to streamline the Tunnelblick user
experience for challenge/response, so thanks, Selva, for inspiring
that!

Please note that I **did not** test the proposed patch. Instead, I
simulated OpenVPN sending
     PASSWORD:Need 'Auth' username/password SC:<flag>,<prompt>
through the management interface to Tunnelblick.

Best to all,

Jon

