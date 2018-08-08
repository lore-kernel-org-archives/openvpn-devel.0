Date: Wed, 08 Aug 2018 11:19:26 +0000
From: "Jonathan K. Bullard" <jkbullard@...2282...>
Reply-To: "Jonathan K. Bullard" <jkbullard@...2282...>
Message-ID: <ZgrKsxO9FdpzY1wI-Hcz7zojELowC6KJPE-yxV3BuzQr1cf3PZLScekJ7UCY2XCEANlwFKsdynqQhUE-iDcW1tlKwIOAMyARQKjuyYIBv1c=@protonmail.com>
In-Reply-To: <CAKuzo_hB9K67VsTuDEd2kK0H14ZvgF=H2QxDN9ccpOuWHBHMNA@...278...>
References: <fjYAooPkYrgmB8fJ2mP-rtaCjsb7EX1oVv_jiph22aEwZQA8Y7QI2ZUsYmpwXnxF0HRogHWWmBt_JM30y1d7pW--UIqczqXre9h7hbIhHUo=@protonmail.com>
 <CAKuzo_hB9K67VsTuDEd2kK0H14ZvgF=H2QxDN9ccpOuWHBHMNA@...278...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Clarify and expand management interface
 documentation
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
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Thanks, Selva. I agree with all of your comments except two, details below:

On August 2, 2018 11:32 AM, Selva Nair <selva.nair@...277...> wrote:
<SNIP>
> >      >NEED-OK:Need 'token-insertion-request' confirmation MSG:Please in=
sert your cryptographic token
> >
> >
> > -   The management client, if it is a GUI, can flash a dialog
> >
> > -   The management interface client, if it is a GUI, can flash a dialog
> >     box containing the text after the "MSG:" marker to the user.
> >     When the user acknowledges the dialog box,
> >
> >
> > -   the management client can issue this command:
> >
> > -   the management interface client can issue this command:
>
> can issue should be "must issue" isn't it?

Other examples use "should", which I like better.


>
> >       needok token-insertion-request ok
> >
> >
> > or
> > @@ -486,10 +516,10 @@ Example:
> >
> >      >NEED-STR:Need 'name' input MSG:Please specify your name
> >
> >
> > -   The management client, if it is a GUI, can flash a dialog
> >
> > -   The management interface client, if it is a GUI, can flash a dialog
> >     box containing the text after the "MSG:" marker to the user.
> >     When the user acknowledges the dialog box,
> >
> >
> > -   the management client can issue this command:
> >
> > -   the management interface client can issue this command:
>
> Same here -- clarify that a response must be provided?

Same here : ) -- other examples use "should", which I like better.


I'll send a v2 incorporating your other comments soon.

Best regards,

Jon

