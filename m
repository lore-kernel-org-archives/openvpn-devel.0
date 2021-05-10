MIME-Version: 1.0
References: <20210429171504.1081888-1-tincantech@...2282...>
 <0a188829-5a2c-362c-eb6f-61ffe657042d@...1227...>
 <_HUflzeIntsfJCr8BbPWvJqUE4YsZ4mnoeBBWWAWz5wXnrnJDSOgFNA8jXs4BX8W8rVR0-mttPOc8wCQ1Ou96EEB2a-ytMFQs33l9yGgwIU=@protonmail.com>
 <635b6cff-1742-e69d-fe91-fc33a5495a7f@...1227...>
 <tu-jUfrw68jHsNHY4mkYfTk6lbF5HjbdUUgJihX0J0-32Lq2yks9rUPrsX7v4fEA5TTb4-fj6mfZXe_ERsXLiLBBiwBQpkA0_ozsihQxIKc=@protonmail.com>
 <20210510172920.GP976@...1296...>
 <y2lmaEJRnB6BjT22cIwFGYiqA1Qq1Ipbqkl4m9N4EaxQvx75mCaX8p53HPHFkoNMmDBX7s4szU1E2pGbIFwgJrbolUA6Yh5SYv4E2e-mGs0=@protonmail.com>
In-Reply-To: <y2lmaEJRnB6BjT22cIwFGYiqA1Qq1Ipbqkl4m9N4EaxQvx75mCaX8p53HPHFkoNMmDBX7s4szU1E2pGbIFwgJrbolUA6Yh5SYv4E2e-mGs0=@protonmail.com>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 10 May 2021 18:10:33 -0400
Message-ID: <CAKuzo_g59fe97KOzuAfzuGKGR0_eLCyrULupw-u-irBebS2L1Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add daemon_pid to --tls-crypt-v2-verify
 environment
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
To: tincantech <tincantech@...2282...>
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Mon, May 10, 2021 at 4:24 PM tincantech via Openvpn-devel
<openvpn-devel@lists.sourceforge.net> wrote:
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> Hi,
>
> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original =
Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
> On Monday, 10 May 2021 18:29, Gert Doering <gert@...1296...> wrote:
>
> > Hi,
> >
> > On Wed, May 05, 2021 at 10:00:37PM +0000, tincantech via Openvpn-devel =
wrote:
> >
> > > thanks for the feedback, I can resubmit with an improved commit messa=
ge
> > > and corrected email if required.
> >
> > This is how I understand Arne - he's happy with the code change, just
> > wants the commit message to explain a bit better why this is relevant.
> >
> > So, there is an ACK-and-merge pending :-)
> >
>
> well, personally.. it's complicated..

I think it's a good thing to pass daemon_pid to all scripts uniformly.
Can't think of any downside. And, on Windows it's a pain to get the
parent pid from a batch file. Personally, I do not have a use case
though.


Selva

