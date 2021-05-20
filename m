MIME-Version: 1.0
References: <20210520150932.2565217-1-arne@...1227...>
 <20210520150932.2565217-2-arne@...1227...>
 <CNUI9sxE2HOdFvol4LftF6DPWGfmpSUabfpLXMOJQXcFcL_bM-zvF9u3oX68guJWALVYyC13DWKt4-9cVq3c8KjneyoFY32pgNpNYCQmTIM=@protonmail.com>
 <46a3a2a9-83a4-2fbe-2fd4-684a51c001f9@...1227...>
 <nehG6AKTksx4AeryA432f6vVe5OGFQSmkbS2TYGGS6MumnC0d8xRfGsZxR_uXmDN2b8Yfvt6zQX0fwG83sqvWlyuLsdneHWr-3Wz8vDc9Qw=@protonmail.com>
In-Reply-To: <nehG6AKTksx4AeryA432f6vVe5OGFQSmkbS2TYGGS6MumnC0d8xRfGsZxR_uXmDN2b8Yfvt6zQX0fwG83sqvWlyuLsdneHWr-3Wz8vDc9Qw=@protonmail.com>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 20 May 2021 16:33:58 -0400
Message-ID: <CAKuzo_gEZfiRiwEfE9dj3CjNRTpTX0sZfOX371SPAjVGxXximA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/2] Add detailed man page section to
 setup a OpenVPN setup with peer-fingerprint
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
Cc: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On Thu, May 20, 2021 at 3:50 PM tincantech via Openvpn-devel
<openvpn-devel@lists.sourceforge.net> wrote:
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> Hi,
>
> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original =
Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
> On Thursday, 20 May 2021 19:30, Arne Schwabe <arne@...1227...> wrote:
>
> > Am 20.05.2021 um 18:56 schrieb tincantech:
> >
> > > Hi,
> > > again, I do not understand why openvpn choose to switch to .pem
> > > for this tutorial.  PEM -> Private Email, which this is not.
> > > You have a certificate and a key and every other openvpn tutorial
> > > on openvpn and probably the entire planet uses .crt and .key.
> > > This seems to be a poor decision in my opinion.
> >
> > pem as extension for keys is pretty common and specifies more the
> > encoding than the type. E.g. there is also the der encoding.
> >
> > Arne
>
> I accept the principle but openvpn *only* uses PEM-enc, that I know of.
>
> So, why switch to .pem when it has never been used before by openvpn?
>
> If you are all happy to let it go that way then so-be-it,

I'm not sure I fully understand the discussion here, but we should
stick with consistent extensions for cert and key files in
documentation and examples. Currently we use the phrase "PEM certs" in
one place and "in .pem format" elsewhere. "PEM encoded" or "PEM
format" would be a better description. We use server.crt, server,key
etc in some places, .pem in some other.

OpenVPN doesn't care about the file extension of keys or certs as long
as the content is PEM. In that sense, having .pem in examples may
appear to be self-documenting but we have to be consistent. Use of
.pem has the drawback that we can use the same filename for cert and
key.

In practice I prefer .crt and .key as they are generally understood as
PEM encoded, and allow the same filename stub to be used for both cert
and key files: like server.crt and server.key while with pem it will
have to be something like server-cert.pem and server-key.pem.

Also, fwiw, .pem is not recognized by Windows explorer, .crt is -- one
could double click on the latter and load into the cert store, not so
with .pem.


Selva

