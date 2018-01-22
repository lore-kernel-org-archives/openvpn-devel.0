MIME-Version: 1.0
In-Reply-To: <07f28923-1023-fe7b-2b3e-e57ad3f6bc8f@...2080...>
References: <1515959073-10376-1-git-send-email-selva.nair@...277...>
 <1515959073-10376-3-git-send-email-selva.nair@...277...>
 <e059b07e-5684-1dbe-cfdf-1271efc594dc@...1227...>
 <CAKuzo_jN9EOK5aPr2dn+m+ynarY-Snt2pwOmz9cV32BpKSFq=w@...278...>
 <CAKuzo_hYwcRDJjYW7i=Ekmi93TAXRb+n=sNyi4y=+gS+vbbtAA@...278...>
 <caf0faaa-428f-29c4-797f-8be8ac4f0f47@...1435...>
 <CAKuzo_jRh+7KSfw6GTVuXTDnMQCDfrH3g5m=N9GGDTDVLijBhg@...278...>
 <07f28923-1023-fe7b-2b3e-e57ad3f6bc8f@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 22 Jan 2018 10:27:45 -0500
Message-ID: <CAKuzo_iVUouudtkpuRBJj_x2RrgD0q07RUg4T1q6RNghAwCbOg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] Allow external EC key through
 --management-external-key
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Mon, Jan 22, 2018 at 8:21 AM, David Sommerseth
<openvpn@...2080...> wrote:
>
> On 18/01/18 16:49, Selva Nair wrote:
> > Hi
> >
> > On Wed, Jan 17, 2018 at 3:53 AM, Steffan Karger <steffan.karger@...1435...
> > <mailto:steffan.karger@...1435...>> wrote:
> >
> >     Hi,
> >
> >     On 17-01-18 05:24, Selva Nair wrote:
> >     > Also I'm toying with the idea of renaming ecdsa-sig/ECDSA-SIGN by
> >     > pkey-sig/PKEY-SIGN so that eventually we may be able to use it for
> >     > all types of keys and retire rsa-sig. Any thoughts on that?
> >
> >     This was my first though when looking at these patches.  Haven't looked
> >     at the code yet, but functionally I think that's the way to go.  Even if
> >     it were that Ed25519 / Ed448 sigs are technically not ECDSA sigs.
> >
> >
> > I was waiting for the chatlog before finalizing v2. Looks like there are a
> > number of opinions
> > that seem to converge towards the same view.
> >
> > This is what I have in my current v2 ready to go out:
> >
> > (i) Current behaviour for rsa signatures stays for now: daemon sends
> >>RSA_SIGN  client responds
> > with rsa-sig
> > (ii) Daemon sends >PK_SIG client responds with pk-sig [*]
> > Initially this will be used only for EC, but trivial to switch RSA to this in
> > future.
> > So document that new mgmt clients should be prepared to handle all supported
> > key types via >PK_SIGN/pk-sig and >RSA_SIGN will be eventually removed.
> >
> > As a nice side effect, clients are allowed to respond with pk-sig even if the
> > challenge was
> >>RSA_SIGN. As a not so nice side effect, the daemon will reply with "SUCCESS
> > rsa-sign
> > succeeded" because that's what it asked for -- I suppose we can live with that.
> >
> > We can deprecate and remove >RSA_SIGN at a later date by a hard switch when
> > all known clients are capable of handling >PK_SIGN
> >
> > Does this sound like an acceptable solution?
> >
> > Question: while at it should we alter the syntax to
> >>PK_SIGN,xxx,<base64>
> >
> > where xxx will be empty for now, but it reserves space for extra info that may
> > come handy for some future signature types (like use PSS padding for RSA or
> > use PureEdDSA or whatever).
>
> Hi,
>
> I've discussed this quickly with James quite recently.  We are concerned about
> breaking existing front-end integrations by doing too much funky stuff with
> RSA_SIGN for EC support.  That in particular touches the signal renaming to
> PK_SIGN.
>
> So we have another suggestion.  For external keys to be used,
> --management-external-key is needed.  Add an optional argument to this option,
> which indicates a version.  If this argument is not provided, everything works
> as it is today - without EC support.  If using: --management-external-key 2
> ... for version 2, do a hard-shift to PK_SIGN with RSA and EC support.
>
> This way we ensure we don't break any existing implementations, we can allow a
> period of transition to the new version, and we can in the future when we are
> sure PK_SIGN works well and has seen deployment elsewhere start a deprecation
> process if the legacy version 1.  But we're not put in a situation where
> anything changes suddenly and abruptly.
>
> Any thoughts?


This is similar to what Arne proposed while reviewing version 1 of the
patch. But I was not excited about encoding client capability into a
config option. On further thought, this may offer a little less
unpleasant UX to some users and I'm ok with it.

I guess tunnelblick supports this options so Jonathan (and Arne) may
have more insight.

The current patch also allows a delayed deprecation of RSA_SIGN giving
time for clients to prepare to handle PK_SIGN. But the UX differs a
little:

- lay user: everything just works always if the provider/admin is good;
or someone fixes things for them.

- client developers: as long as we deprecate commands/options
responsibly (no hard switching), and document it, they/we will cope

So its about average/advanced users changing their RSA cert to EC with
--management-external-key and a client that doesn't yet support
PK_SIGN:

- Present patch: connection process appears stuck (but UI is still
responsive) and logs show the daemon is waiting for signature

- This proposal: connection fails with: "External EC cert/key not
supported in this config. Try using --management-external-key 2"
User edits the config option and the connection process appears stuck .....

I suppose the latter is a bit better.

Selva

