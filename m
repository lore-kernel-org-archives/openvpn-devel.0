From: "Vladislav Grishenko" <themiron@...2010...>
References: <20200922004005.10268-1-themiron@...2010...>
 <75c379c2-35da-da12-d21f-44b1d6b1065b@...1227...>
In-Reply-To: <75c379c2-35da-da12-d21f-44b1d6b1065b@...1227...>
Date: Tue, 22 Sep 2020 14:34:00 +0500
Message-ID: <010d01d690c3$80edd120$82c97360$@yandex-team.ru>
MIME-Version: 1.0
Content-Language: ru
Subject: Re: [Openvpn-devel] [PATCH] Fix update_time() and
 openvpn_gettimeofday()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: 'Arne Schwabe' <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi Arne,

> But that also
> implies it is the other way round on other platforms. The update_time fun=
ction is
> called in multiple critical places. Do we have any idea about this?

On Linux with glibc's implementation both time() and gettimeofday() results=
 in the same clock_gettime() call over VDSO (https://man7.org/linux/man-pag=
es/man7/vdso.7.html).
On FreeBSD (and so), same if VDSO is used both time() and gettimeofday() wi=
ll use clock_gettime too with even additional "tv->tv_usec =3D 0" for time(=
).
So, on most of architectures there will be no difference after replacing ti=
me() to gettimeofday() except. asm commands for moving 32/64bit tv_usec, it=
'll be not visible.
On some acrhs/systems where VDSO is not supported - same syscall will happe=
n.

> I remember
> vaguely that the default gettimeofday in FreeBSD is more accurate than the
> Linux variant (involves a kernel call) but you can request a version simi=
lar to the
> Linux one by some flag (reading from a shared readonly memory page that is
> read only).

As for clock drifting, it maybe feasible to use clock_gettime() with CLOCK_=
MONOTONIC and get rid of homegrown time adj code at all -> returned time wi=
ll always be monotonic by design.
At least on supported platforms (!_WIN32).

--
Best Regards, Vladislav Grishenko

> -----Original Message-----
> From: Arne Schwabe <arne@...1227...>
> Sent: Tuesday, September 22, 2020 1:41 PM
> To: Vladislav Grishenko <themiron@...2010...>; openvpn-
> devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] [PATCH] Fix update_time() and
> openvpn_gettimeofday()
>=20
>=20
> > --- a/src/openvpn/otime.h
> > +++ b/src/openvpn/otime.h
> > @@ -78,13 +78,9 @@ openvpn_gettimeofday(struct timeval *tv, void *tz)
> > static inline void
> >  update_time(void)
> >  {
> > -#ifdef _WIN32
> > -    /* on _WIN32, gettimeofday is faster than time(NULL) */
> > +    /* can't use time(NULL), now_usec needs to be updated */
> >      struct timeval tv;
> >      openvpn_gettimeofday(&tv, NULL);
> > -#else
> > -    update_now(time(NULL));
> > -#endif
> >  }
> >
> >  #else /* !TIME_BACKTRACK_PROTECTION */
> >
>=20
> I am hesitant about this change, it mentions that gettimeofday is faster =
on
> Windows than time(NULL) and we prefer it there for this reason. But that =
also
> implies it is the other way round on other platforms. The update_time fun=
ction is
> called in multiple critical places. Do we have any idea about this? I rem=
ember
> vaguely that the default gettimeofday in FreeBSD is more accurate than the
> Linux variant (involves a kernel call) but you can request a version simi=
lar to the
> Linux one by some flag (reading from a shared readonly memory page that is
> read only).
>=20
> Arne



