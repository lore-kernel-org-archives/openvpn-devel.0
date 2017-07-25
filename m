MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
In-Reply-To: <1501010486.4771.113.camel@...1866...>
References: <f7687ebf-a75f-095d-67ca-e32a5c4e53e7@...515...>
 <1500293278.28621.32.camel@...1866...>
 <b6adb528-5d31-fa7b-cd0c-e87b69e0854c@...515...>
 <1501010486.4771.113.camel@...1866...>
From: Emmanuel Deloget <logout@...260...>
Date: Tue, 25 Jul 2017 23:56:52 +0200
Message-ID: <CAKh=nwEKFfAho0F7v0y3QJCq0s9-+iWfvg=YQVRHU=2JhNErcA@...278...>
Subject: Re: [Openvpn-devel] Windows installer with updated pkcs11-helper
 (1.22) available for testing
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
To: David Woodhouse <dwmw2@...1866...>
Cc: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi David, other,

It seems that my "I'm using my phone, sorry for top posting" went far
beyond that because I also forgot to add the list as a recipient.

So, here is my message (minus the top-posting) sent to David only (sorry Da=
vid)

On Tue, Jul 25, 2017 at 9:21 PM, David Woodhouse <dwmw2@...1866...> wrote:
>
> On Tue, 2017-07-25 at 19:53 +0300, Samuli Sepp=C3=A4nen wrote:
> >
> > I released the new Windows installer but without this patch. That said,
> > the patch/PR you linked to makes sense. Does the patch have an active
> > maintainer?
>
> That would be me, I suppose. Until/unless the upstream maintainer
> applies the patch, I or someone else will continue to maintain the
> patch in the Fedora package at least.
>
> > If yes, then I propose is that we
> >
> > - Fork OpenSC/pkcs11-helper to OpenVPN/pkcs11-helper
> > - Apply the patch to our fork
> > - Produce and publish our own pkcs11-helper tarballs
> > - Point openvpn-build to our tarballs
> > - Periodically rebase our fork with upstream
> >
> > Thoughts?
>
>
> Hi,
>
> Sorry for the top posting, I'm writing that from my phone.
>
> To add to the NAK, such a move would make integration to various embedded
> distribution more difficult, as maintainers may have to deal with 2 versi=
ons of the
> same lib (with possibly different behavior needed by different binaries).
>
> Do I would advise against such a solution.
>
> Best regards,
>
> -- Emmanuel Deloget

To which David replied (hope you don't mind if I quote you):

> There is no API/ABI change. One accepts cert identifier strings confirming
> to RFC7512, the other (without the patch) doesn't.
>
> So aside from the RFC-compliance they are interchangeable.

(I think I'm already using this patch, so thanks you David for your work).

A single patch would not a a problem for distro maintainers, but
subsequent/future changes in the forked repository might introduce
other, less compatible changes in the library, leading to two versions
of the same library, with maybe the same ABI and the same name -- and
that worries me a bit (not that much, but I also maintain a fork of
lede for my own purpose, and I'm not sure I'd like to deal with such
complexity :)). Aviding that would require a library name change and
I'm not sure it's a good thing at all.

And you also have to take into account weird people like me who also
add their own changes into various libraries or binaries to suit their
needs (the whole "hey, it's free software, I can change it" thing).
Pointing them to a fork is not going to work well IMHO. It would be
better if the maintainer finally decide to either implement the
required change or merge your patch to the library.

Best regards,

-- Emmanuel Deloget

