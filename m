MIME-Version: 1.0
In-Reply-To: <1CED409804E2164C8104F9E623B08B9012CB842339@...1436...>
References: <1333351687-3732-1-git-send-email-dejong@...1435...>
	<1333351687-3732-2-git-send-email-dejong@...1435...>
	<CAOazyz1qqY0NzL0eFnAjqcqPzgs-V8=meTOKnULqdpvvYvO0Zg@...278...>
	<1CED409804E2164C8104F9E623B08B9012CB842339@...1436...>
Date: Mon, 2 Apr 2012 20:50:43 +0300
Message-ID: <CAOazyz26LUdDhZk48P6nAa3pWf4asi4RxGkAh9_Y4AJH3OCSPw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 2/6] Added a configuration option to
 enable prediction resistance in the PolarSSL random number generator.
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

Just that porting to OpenVPN needs to be consistent.
There is no sense in supporting a feature using one cryptographic
library, while this one is also the one that least use...
So I suggest either you port this to openssl as well, or drop this.
I know there are some other abnormalities in crypto, I will dig them
out when I cleanup this code as well.

On Mon, Apr 2, 2012 at 8:42 PM, Adriaan de Jong <dejong@...1435...> wrote:
> Prediction resistance is a useful feature to have in some circles. It's d=
efinitely an option that's useful for OpenVPN-NL, which is why I ported it =
to the mainline. If there is no interest, could we include it in a contrib =
directory or something along those lines?
>
> Adriaan
>
>> -----Original Message-----
>> From: Alon Bar-Lev [mailto:alon.barlev@...277...]
>> Sent: maandag 2 april 2012 11:19
>> To: Adriaan de Jong
>> Cc: openvpn-devel@lists.sourceforge.net
>> Subject: Re: [Openvpn-devel] [PATCH 2/6] Added a configuration option
>> to enable prediction resistance in the PolarSSL random number
>> generator.
>>
>> Hello,
>> I think that we should not have these options specific to one crypto
>> library.
>> Alon.
>>
>> On Mon, Apr 2, 2012 at 10:28 AM, Adriaan de Jong <dejong@...1435...>
>> wrote:
>> > Signed-off-by: Eelse-jan Stutvoet <stutvoet@...1435...>
>> > Signed-off-by: Adriaan de Jong <dejong@...1435...>
>> > ---
>> > =C2=A0doc/openvpn.8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 14 ++++++++++++++
>> > =C2=A0src/openvpn/crypto_polarssl.c | =C2=A0 =C2=A09 +++++++++
>> > =C2=A0src/openvpn/crypto_polarssl.h | =C2=A0 =C2=A07 +++++++
>> > =C2=A0src/openvpn/init.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
=C2=A0 =C2=A06 ++++++
>> > =C2=A0src/openvpn/options.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 22 ++=
++++++++++++++++++++
>> > =C2=A0src/openvpn/options.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A03 +++
>> > =C2=A0src/openvpn/syshead.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A08 ++++++++
>> > =C2=A07 files changed, 69 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/doc/openvpn.8 b/doc/openvpn.8 index 53d6bdb..ee46de6
>> > 100644
>> > --- a/doc/openvpn.8
>> > +++ b/doc/openvpn.8
>> > @@ -3846,6 +3846,20 @@ space-saving optimization that uses the unique
>> > identifier for
>> > =C2=A0datagram replay protection as the IV.
>> > =C2=A0.\"*********************************************************
>> > =C2=A0.TP
>> > +.B \-\-use-prediction-resistance
>> > +Enable prediction resistance on PolarSSL's RNG.
>> > +
>> > +Enabling prediction resistance causes the RNG to reseed in each call
>> > +for random. Reseeding this often can quickly deplete the kernel
>> > +entropy pool.
>> > +
>> > +If you need this option, please consider running a daemon that adds
>> > +entropy to the kernel pool.
>> > +
>> > +Note that this option only works with PolarSSL versions greater than
>> > +1.1.
>> > +.\"*********************************************************
>> > +.TP
>> > =C2=A0.B \-\-test-crypto
>> > =C2=A0Do a self-test of OpenVPN's crypto options by encrypting and
>> > =C2=A0decrypting test packets using the data channel encryption options
>> > diff --git a/src/openvpn/crypto_polarssl.c
>> > b/src/openvpn/crypto_polarssl.c index 158ccfc..96d41b7 100644
>> > --- a/src/openvpn/crypto_polarssl.c
>> > +++ b/src/openvpn/crypto_polarssl.c
>> > @@ -219,6 +219,15 @@ havege_state * rand_ctx_get()
>> >
>> > =C2=A0#endif /* (POLARSSL_VERSION_NUMBER >=3D 0x01010000) */
>> >
>> > +#ifdef ENABLE_PREDICTION_RESISTANCE
>> > +void rand_ctx_enable_prediction_resistance()
>> > +{
>> > + =C2=A0ctr_drbg_context *cd_ctx =3D rand_ctx_get();
>> > +
>> > + =C2=A0ctr_drbg_set_prediction_resistance(cd_ctx, 1); } #endif /*
>> > +ENABLE_PREDICTION_RESISTANCE */
>> > +
>> > =C2=A0int
>> > =C2=A0rand_bytes (uint8_t *output, int len)
>> > =C2=A0{
>> > diff --git a/src/openvpn/crypto_polarssl.h
>> > b/src/openvpn/crypto_polarssl.h index 2f303db..6152878 100644
>> > --- a/src/openvpn/crypto_polarssl.h
>> > +++ b/src/openvpn/crypto_polarssl.h
>> > @@ -96,4 +96,11 @@ ctr_drbg_context * rand_ctx_get();
>> > =C2=A0havege_state * rand_ctx_get();
>> > =C2=A0#endif
>> >
>> > +#ifdef ENABLE_PREDICTION_RESISTANCE
>> > +/**
>> > + * Enable prediction resistance on the random number generator.
>> > + */
>> > +void rand_ctx_enable_prediction_resistance();
>> > +#endif
>> > +
>> > =C2=A0#endif /* CRYPTO_POLARSSL_H_ */
>> > diff --git a/src/openvpn/init.c b/src/openvpn/init.c index
>> > bc7718e..05a07fa 100644
>> > --- a/src/openvpn/init.c
>> > +++ b/src/openvpn/init.c
>> > @@ -2008,6 +2008,12 @@ init_crypto_pre (struct context *c, const
>> > unsigned int flags)
>> >
>> > =C2=A0 if (c->options.mute_replay_warnings)
>> > =C2=A0 =C2=A0 c->c2.crypto_options.flags |=3D CO_MUTE_REPLAY_WARNINGS;
>> > +
>> > +#ifdef ENABLE_PREDICTION_RESISTANCE
>> > + =C2=A0if (c->options.use_prediction_resistance)
>> > + =C2=A0 =C2=A0rand_ctx_enable_prediction_resistance();
>> > +#endif
>> > +
>> > =C2=A0}
>> >
>> > =C2=A0/*
>> > diff --git a/src/openvpn/options.c b/src/openvpn/options.c index
>> > bd83843..5b52ed0 100644
>> > --- a/src/openvpn/options.c
>> > +++ b/src/openvpn/options.c
>> > @@ -545,6 +545,10 @@ static const char usage_message[] =3D
>> > =C2=A0 " =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0using file.\n"
>> > =C2=A0 "--test-crypto =C2=A0 : Run a self-test of crypto features enab=
led.\n"
>> > =C2=A0 " =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0For debugging only.\n"
>> > +#ifdef ENABLE_PREDICTION_RESISTANCE
>> > + =C2=A0"--use-prediction-resistance: Enable prediction resistance on =
the
>> random\n"
>> > + =C2=A0" =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 number generator.\n"
>> > +#endif
>> > =C2=A0#ifdef ENABLE_SSL
>> > =C2=A0 "\n"
>> > =C2=A0 "TLS Key Negotiation Options:\n"
>> > @@ -837,6 +841,9 @@ init_options (struct options *o, const bool
>> > init_gc)
>> > =C2=A0 o->replay_time =3D DEFAULT_TIME_BACKTRACK;
>> > =C2=A0 o->use_iv =3D true;
>> > =C2=A0 o->key_direction =3D KEY_DIRECTION_BIDIRECTIONAL;
>> > +#ifdef ENABLE_PREDICTION_RESISTANCE
>> > + =C2=A0o->use_prediction_resistance =3D false; #endif
>> > =C2=A0#ifdef ENABLE_SSL
>> > =C2=A0 o->key_method =3D 2;
>> > =C2=A0 o->tls_timeout =3D 2;
>> > @@ -1581,6 +1588,9 @@ show_settings (const struct options *o)
>> > =C2=A0 SHOW_STR (packet_id_file);
>> > =C2=A0 SHOW_BOOL (use_iv);
>> > =C2=A0 SHOW_BOOL (test_crypto);
>> > +#ifdef ENABLE_PREDICTION_RESISTANCE
>> > + =C2=A0SHOW_BOOL (use_prediction_resistance); #endif
>> >
>> > =C2=A0#ifdef ENABLE_SSL
>> > =C2=A0 SHOW_BOOL (tls_server);
>> > @@ -3018,6 +3028,11 @@ options_string (const struct options *o,
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_printf (&out, ",no-replay");
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!o->use_iv)
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_printf (&out, ",no-iv");
>> > +
>> > +#ifdef ENABLE_PREDICTION_RESISTANCE
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (o->use_prediction_resistance)
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_printf (&out, ",use-prediction=
-resistance"); #endif
>> > =C2=A0 =C2=A0 =C2=A0 }
>> >
>> > =C2=A0#ifdef ENABLE_SSL
>> > @@ -6416,6 +6431,13 @@ add_option (struct options *options,
>> > =C2=A0 =C2=A0 =C2=A0 options->keysize =3D keysize;
>> > =C2=A0 =C2=A0 }
>> > =C2=A0#endif
>> > +#ifdef ENABLE_PREDICTION_RESISTANCE
>> > + =C2=A0else if (streq (p[0], "use-prediction-resistance"))
>> > + =C2=A0 =C2=A0{
>> > + =C2=A0 =C2=A0 =C2=A0VERIFY_PERMISSION (OPT_P_GENERAL);
>> > + =C2=A0 =C2=A0 =C2=A0options->use_prediction_resistance =3D true;
>> > + =C2=A0 =C2=A0}
>> > +#endif
>> > =C2=A0#ifdef ENABLE_SSL
>> > =C2=A0 else if (streq (p[0], "show-tls"))
>> > =C2=A0 =C2=A0 {
>> > diff --git a/src/openvpn/options.h b/src/openvpn/options.h index
>> > 9e78d00..1be3dfa 100644
>> > --- a/src/openvpn/options.h
>> > +++ b/src/openvpn/options.h
>> > @@ -520,6 +520,9 @@ struct options
>> > =C2=A0 const char *packet_id_file;
>> > =C2=A0 bool use_iv;
>> > =C2=A0 bool test_crypto;
>> > +#ifdef ENABLE_PREDICTION_RESISTANCE
>> > + =C2=A0bool use_prediction_resistance;
>> > +#endif
>> >
>> > =C2=A0#ifdef ENABLE_SSL
>> > =C2=A0 /* TLS (control channel) parms */
>> > diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h index
>> > e60dc44..b14d50d 100644
>> > --- a/src/openvpn/syshead.h
>> > +++ b/src/openvpn/syshead.h
>> > @@ -534,6 +534,14 @@ socket_defined (const socket_descriptor_t sd)
>> > =C2=A0#define MANAGMENT_EXTERNAL_KEY
>> > =C2=A0#endif
>> >
>> > +/* Enable PolarSSL RNG prediction resistance support */ #ifdef
>> > +ENABLE_CRYPTO_POLARSSL #include <polarssl/version.h> #if
>> > +POLARSSL_VERSION_NUMBER >=3D 0x01010000 #define
>> > +ENABLE_PREDICTION_RESISTANCE #endif #endif /* ENABLE_CRYPTO_POLARSSL
>> > +*/
>> > +
>> > =C2=A0/*
>> > =C2=A0* MANAGEMENT_IN_EXTRA allows the management interface to
>> > =C2=A0* read multi-line inputs from clients.
>> > --
>> > 1.7.5.4
>> >
>> >
>> > ---------------------------------------------------------------------
>> -
>> > --------
>> > This SF email is sponsosred by:
>> > Try Windows Azure free for 90 days Click Here
>> > http://p.sf.net/sfu/sfd2d-msazure
>> > _______________________________________________
>> > Openvpn-devel mailing list
>> > Openvpn-devel@lists.sourceforge.net
>> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel

