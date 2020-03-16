MIME-Version: 1.0
References: <20200313130133.19045-1-samuli@...515...>
 <285d114f-89b4-992d-f8b1-5cec175994ca@...2080...>
In-Reply-To: <285d114f-89b4-992d-f8b1-5cec175994ca@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 16 Mar 2020 09:48:12 -0400
Message-ID: <CAKuzo_gDkHGy0j78hH33zeXKnsi=7NF8PvFNJQQpq7kf2-=Gbg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Document some limitations of
 --auth-user-pass
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
To: David Sommerseth <openvpn@...2080...>
Cc: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Mon, Mar 16, 2020 at 8:39 AM David Sommerseth
<openvpn@...2080...> wrote:
>
> On 13/03/2020 14:01, samuli@...515... wrote:
> > From: Samuli Sepp=C3=A4nen <samuli@...515...>
> >
> > URL: https://community.openvpn.net/openvpn/ticket/757
> > Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
> > ---
> >  doc/openvpn.8 | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/doc/openvpn.8 b/doc/openvpn.8
> > index 864f94e8..9e54890e 100644
> > --- a/doc/openvpn.8
> > +++ b/doc/openvpn.8
> > @@ -4127,6 +4127,12 @@ The server configuration must specify an
> >  .B \-\-auth\-user\-pass\-verify
> >  script to verify the username/password provided by
> >  the client.
> > +
> > +Note that OpenVPN GUI on Windows does not prompt for the
> > +password if the file contains only the username. However,
> > +OpenVPN versions from 2.4 up bundle OpenVPN GUI version 11
> > +which is able to cache usernames and passwords internally.
> > +
>
> Could we rephrase this, to not live in the past.  This will go into maste=
r and
> probably also release/2.4.  I also doubt anyone using man pages on 2.3 wo=
uld
> even read this.  If there are Windows users on 2.3, there are no excuse n=
ot to
> upgrade - unless it's an enterprise deployment, where end users most like=
ly
> would not even care (they should anyway complain to their IT department
> regardless, for using outdated security software).
>
> I would just rephrase it to say:
>
>   OpenVPN GUI v11 and newer uses its own internal username/password stora=
ge
>   independent of the --auth-user-pass file provided.  The file argument is
>   ignored on such installations.

I wish it behaved  like that. Unfortunately the file argument is not
ignored in such cases. If the file has only username, openvpn.exe
reads it from the file and then fails to prompt for password as there
is no console available.

I propose to change this behaviour to: if --management-query-passwords
is set (which the GUI does), ignore the file given in auth-user-pass
and prompt both username and password from management. I think its
only logical for a later option (in this case the one set by the GUI)
to override a previous one. Anyway we do already ignore it if the file
is "stdin".

Selva

