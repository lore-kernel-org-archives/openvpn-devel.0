MIME-Version: 1.0
References: <20200313130133.19045-1-samuli@...515...>
 <285d114f-89b4-992d-f8b1-5cec175994ca@...2080...>
 <CAKuzo_gDkHGy0j78hH33zeXKnsi=7NF8PvFNJQQpq7kf2-=Gbg@...278...>
 <31ca48e1-deb8-7122-6f77-051b08e1b563@...2080...>
 <20200317102500.GP1431@...1296...>
In-Reply-To: <20200317102500.GP1431@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 29 Mar 2020 16:43:58 -0400
Message-ID: <CAKuzo_gLrEhfiA_cETadphR3Geg+8YZtPTkw_Op6AL3OWbOrzA@...278...>
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
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: David Sommerseth <openvpn@...2080...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Tue, Mar 17, 2020 at 6:25 AM Gert Doering <gert@...1296...> wrote:
>
> Hi,
>
> On Tue, Mar 17, 2020 at 11:06:53AM +0100, David Sommerseth wrote:
> > On 16/03/2020 14:48, Selva Nair wrote:
> > [...snip...]
> > >> I would just rephrase it to say:
> > >>
> > >>   OpenVPN GUI v11 and newer uses its own internal username/password storage
> > >>   independent of the --auth-user-pass file provided.  The file argument is
> > >>   ignored on such installations.
> > >
> > > I wish it behaved  like that. Unfortunately the file argument is not
> > > ignored in such cases. If the file has only username, openvpn.exe
> > > reads it from the file and then fails to prompt for password as there
> > > is no console available.
> >
> > Ouch ... that is a pointless misbehavior.  Lets try to fix that.
>
> Have you recovered from your latest adventures in "password query code
> in OpenVPN" already? :-)
>
> Not sure if the management commands permit the "we have a username but
> no password" flow today... Arne, Selva?
>
> But yes, this needs to be either a clear error, or "work correctly"
>
> > > I propose to change this behaviour to: if --management-query-passwords
> > > is set (which the GUI does), ignore the file given in auth-user-pass
> > > and prompt both username and password from management. I think its
> > > only logical for a later option (in this case the one set by the GUI)
> > > to override a previous one. Anyway we do already ignore it if the file
> > > is "stdin".
> >
> > Agreed!
>
> No, as this will break working configs *if* both username + password
> are in the file (did we ever merge the "inline auth-user-pass" patch?).

See the patch in mail for what looks like an acceptable solution to me.


Selva

