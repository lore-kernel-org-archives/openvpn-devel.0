MIME-Version: 1.0
In-Reply-To: <1CED409804E2164C8104F9E623B08B9012CB842337@...1436...>
References: <1333351687-3732-1-git-send-email-dejong@...1435...>
	<CAOazyz0MDBg75y+CRdYNEOdYBE83B_pYfZ3pz+JLyUdAyF6xgQ@...278...>
	<CAP+U6tK3UHd=KR1th0vxdLnRUsZm47qKgk=BeNgzSmvYUFMdvw@...278...>
	<4F797A66.8050502@...1114...>
	<CAOazyz0uhi_ao2SN3Moi+tXRVhaJPd-O1eam0tqLo_6rehVREg@...278...>
	<4F7981C4.80409@...1114...>
	<CAOazyz1eV7V7aB9WFr0LwJM-dyegeK1wyeLXJQAoDTB+J02E3A@...278...>
	<1CED409804E2164C8104F9E623B08B9012CB842337@...1436...>
Date: Mon, 2 Apr 2012 21:50:55 +0300
Message-ID: <CAOazyz21wp6-w5hC4tm9+gRm5gLqJWMow4b0fdsyroMGMA143A@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 1/6] Added support for new PolarSSL 1.1
	RNG
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Adriaan de Jong <dejong@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Mon, Apr 2, 2012 at 8:31 PM, Adriaan de Jong <dejong@...1435...> wrote:
>> -----Original Message-----
>> From: Alon Bar-Lev [mailto:alon.barlev@...277...]
>> Sent: maandag 2 april 2012 12:42
>> To: David Sommerseth
>> Cc: openvpn-devel@lists.sourceforge.net
>> Subject: Re: [Openvpn-devel] [PATCH 1/6] Added support for new PolarSSL
>> 1.1 RNG
>>
>> On Mon, Apr 2, 2012 at 1:39 PM, David Sommerseth
>> <openvpn.list@...1114...> wrote:
>> > -----BEGIN PGP SIGNED MESSAGE-----
>> > Hash: SHA1
>> >
>> > On 02/04/12 12:25, Alon Bar-Lev wrote:
>> >> No no no.... I did not imply that this will be dynamic interface.
>> >> Nor that there is a use case.
>> >>
>> >> The current state of the code (even before the merge of polarssl)
>> was
>> >> very complex. Now it is even more complex, with none clean/strict
>> >> separation between the common crypto code and the library specific
>> >> crypto code... Yes, I know these resides in different sources, but
>> it
>> >> is more similar to what we call "spaghetti" programming.
>> >>
>> >> What I suggest of doing is to create static callback structure which
>> >> is the interface of crypto library used by openvpn. This is
>> >> *STATIC* linkage.
>> >>
>> >> For example: typedef struct { result_t (*x509_get_username) (char
>> >> *cn, int cn_len, char *x509_username_field, x509_cert *cert) ... }
>> >> openvpn_crypto_enigne_t;
>> >>
>> >> I guess you understand how this struct will look like.
>> >>
>> >> Now, a nice side effect would be the ability to have both libraries
>> >> linked against openvpn, while choosing the engine at
>> configuration...
>> >> Of course there is no real world use for this, except for build (one
>> >> build checks both libraries) and test (we can use test one build for
>> >> both).
>> >>
>> >> The main mission is to clean up the code, reducing the complexity,
>> >> making sure we can follow each crypto call to either common,
>> >> crypto-library-atom, or openvpn specific.
>> >>
>> >> Is that more clear?
>> >
>> > Ahh, yeah! =C2=A0That makes more sense.
>> >
>> > But I just need to be sure we're having the right focus. =C2=A0Are we
>> > getting done with the autotools clean-up? =C2=A0If not, what's missing=
? =C2=A0I
>> > see more and more clean-up patches touching the C code now, so I just
>> > want to be sure we're basically done with autotools. =C2=A0Otherwise,
>> > getting rid of syshead.h is probably one of the next bigger steps.
>>
>> Right.
>> Next stage is getting rid of syshead.h... The following is to cleanup
>> the crypto, I though that if someone can work on this in parallel we
>> will do this twice as fast :)
>>
>> But before we continue we need to stabilize the project again, creating
>> the missing repositories, deciding about the github/sourceforge is
>> needed. Deciding about the way to review and merge large changes.
>>
>
> I'd prefer to leave further modularisation for 2.4. We could even make th=
at a more general goal for 2.4, modularising not just crypto/SSL, but also =
authentication, and maybe even some of the network stuff. It would be nice =
to leave a few targets for 2.4 :).
>
> I don't see the need to further delay 2.3 for this, as it is not a bug fi=
x. Others might disagree here, and the topic is open for debate :). In gene=
ral, it might be a good idea to freeze development of 2.3 at some point to =
prevent endless alpha syndrome.
>
> Adriaan
>

Well, I don't care about version numbers... they are just snapshots in time.
We need a branch with this one way or the other... If that branch is
good, it can enter the next version whatever it may be...

Alon.

