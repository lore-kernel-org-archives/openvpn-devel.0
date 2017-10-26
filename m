From: Jeremie Courreges-Anglas <jca@...2272...>
References: <87fuaymq62.fsf@...2274...>
 <44a0a6e8-0662-6fcc-7f97-d35477bd81b0@...68...>
 <87efq4havl.fsf@...2274...>
 <87bml4mhg7.fsf@...2274...>
 <3cb0497a-72d4-f84e-9026-f6b1e1aeb69c@...1435...>
Date: Thu, 26 Oct 2017 12:55:42 +0200
Message-ID: <87k1zi18lt.fsf@...2274...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [patch] Fix time_t printing - NAK
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26 2017, Steffan Karger <steffan.karger@...1435...> wrote:
> Hi,
>
> Sorry for being late to respond.
>
> On 18-10-17 20:36, Jeremie Courreges-Anglas wrote:
>> - there are other places when a time_t is printed in openvpn.  Usually
>>   it is cast to (int), which is not a nice thing to do if you plan to
>>   support dates after 2038.
>>=20
>>   I also stumbled upon this in src/openvpn/common.h
>>=20
>>   /*
>>    * Printf formats for special types
>>    */
>>   #ifdef _WIN64
>>   #define ptr_format              "0x%I64x"
>>   #else
>>   #define ptr_format              "0x%08lx"
>>   #endif
>>   #define time_format             "%lu"
>>   #define fragment_header_format  "0x%08x"
>>=20=20=20
>>   /* these are used to cast the arguments
>>    * and MUST match the formats above */
>>   typedef unsigned long time_type;
>>   #ifdef _WIN64
>>   typedef unsigned long long ptr_type;
>>   #else
>>   typedef unsigned long ptr_type;
>>   #endif
>>=20
>>   time_format and time_type are indeed used in a few places where
>>   a time_t is printed.  Technically, "unsigned long" suffers from the
>>   same problem as "long" on platforms with a 32 bits "long", pushing the
>>   limit to 2106 instead of 2038.
>>=20
>>   I would suggest using "long long" here too, but do you folks think
>>   that the whole "time_format/time_type" indirection makes sense?
>>   After all, those are currently the same on all platforms.
>>=20
>>   I have a diff to fix places in src/openvpn where time_t variables are
>>   cast to (int), but it kinda depends on the approach you folks prefer
>>   to use.
>
> Not sure about the other devs, but I think we should get rid of this
> indirection.  Someone who forgets to cast to long long will likely also
> not use the time_format define.  Better be consistent in casting to long
> long and printing using %lld (which is obviously correct for a long
> long).  Patch is definitely welcome.

ok, thanks for confirming.

>>>> While we are at it, note that tv.tv_usec, per POSIX, is a SIGNED integ=
er
>>>> type capable of representing numbers in the range [-1; 1,000,000] so
>>>> casting tv_usec to unsigned long without checking if it's -1 is
>>>> technically wrong, although I'd be surprised to see gettimeofday()
>>>> return a negative tv_usec - but UINT_MAX or ULONG_MAX likewise.
>>>
>>> It makes sense to respect the fact that suseconds_t can store a negative
>>> value.  But then the same can be said about time_t (since its signedness
>>> is not defined by posix).
>>=20
>> I guess it makes sense to also choose a generic way to print
>> suseconds_t, whose size isn't defined by posix either, and deal with
>> both types at once.  I would suggest using %ld and a cast to (long), as
>> this is the underlying type on at least OpenBSD and Linux.
>
> Sounds good to me.

Then here's the patch.

Notes:
- (hopefully) all time_t values are printed with %lld/(long long).
  For suseconds_t, use %ld and (long).  The patch is only about fixing
  printf-like format strings, it does not attempt to fix potential
  2038-related overflows in the code.
- built-checked with clang.  Sometimes the code was hidden by
  #ifdefs, I tweaked those and added a bunch of "#error foo"  to make
  sure that the modified code was actually built.  mbedtls build also
  tested.
- packet_id_interactive_test() doesn't build, and uses sscanf(%lu) to
  parse a time_t.  Could fix this in another diff and convert to
  %lld/long long.
- looks like multi.c and options.c could use a setenv_long_long()
  function, instead of using setenv_unsigned().

Works well in my client-side tests.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
 filename=0001-Print-time_t-as-long-long-and-suseconds_t-as-long.patch
Content-Transfer-Encoding: quoted-printable

From=206aa57eed8692f9790f5c6ad68087f849a6cf9633 Mon Sep 17 00:00:00 2001
From: Jeremie Courreges-Anglas <jca@...2272...>
Date: Thu, 26 Oct 2017 11:40:05 +0200
Subject: [PATCH] Print time_t as long long and suseconds_t as long

As per previous commit, this is a simple solution to cope with the
various sizes of time_t on different archs, including those that use 64
bits time_t on ILP32 archs to cope with y2038.

Also:
=2D convert the time_type/time_format abstraction that used unsigned long
  to inlined long long code
=2D print suseconds_t as a long, which appears to be the underlying type
  on most Unix systems around

Signed-off-by: Jeremie Courreges-Anglas <jca@...2272...>
=2D--
 src/openvpn/common.h      |  2 --
 src/openvpn/error.c       |  4 ++--
 src/openvpn/event.c       | 10 +++++-----
 src/openvpn/forward.c     |  2 +-
 src/openvpn/multi.c       |  6 +++---
 src/openvpn/otime.c       | 18 +++++++++---------
 src/openvpn/packet_id.c   | 16 ++++++++--------
 src/openvpn/reliable.c    |  4 ++--
 src/openvpn/shaper.c      |  4 ++--
 src/openvpn/shaper.h      |  8 ++++----
 src/openvpn/ssl_openssl.c |  8 ++++----
 11 files changed, 40 insertions(+), 42 deletions(-)

diff --git a/src/openvpn/common.h b/src/openvpn/common.h
index bb08c01f..4ea3938d 100644
=2D-- a/src/openvpn/common.h
+++ b/src/openvpn/common.h
@@ -57,12 +57,10 @@ typedef int interval_t;
 #else
 #define ptr_format              "0x%08lx"
 #endif
=2D#define time_format             "%lu"
 #define fragment_header_format  "0x%08x"
=20
 /* these are used to cast the arguments
  * and MUST match the formats above */
=2Dtypedef unsigned long time_type;
 #ifdef _WIN64
 typedef unsigned long long ptr_type;
 #else
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 7b46c5ec..26455455 100644
=2D-- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -342,9 +342,9 @@ x_msg_va(const unsigned int flags, const char *format, =
va_list arglist)
                 struct timeval tv;
                 gettimeofday(&tv, NULL);
=20
=2D                fprintf(fp, "%lld.%06lu %x %s%s%s%s",
+                fprintf(fp, "%lld.%06ld %x %s%s%s%s",
                         (long long)tv.tv_sec,
=2D                        (unsigned long)tv.tv_usec,
+                        (long)tv.tv_usec,
                         flags,
                         prefix,
                         prefix_sep,
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index d1230704..2fb112b8 100644
=2D-- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -1041,10 +1041,10 @@ se_wait_fast(struct event_set *es, const struct tim=
eval *tv, struct event_set_re
     struct timeval tv_tmp =3D *tv;
     int stat;
=20
=2D    dmsg(D_EVENT_WAIT, "SE_WAIT_FAST maxfd=3D%d tv=3D%d/%d",
+    dmsg(D_EVENT_WAIT, "SE_WAIT_FAST maxfd=3D%d tv=3D%lld/%ld",
          ses->maxfd,
=2D         (int)tv_tmp.tv_sec,
=2D         (int)tv_tmp.tv_usec);
+         (long long)tv_tmp.tv_sec,
+         (long)tv_tmp.tv_usec);
=20
     stat =3D select(ses->maxfd + 1, &ses->readfds, &ses->writefds, NULL, &=
tv_tmp);
=20
@@ -1065,8 +1065,8 @@ se_wait_scalable(struct event_set *es, const struct t=
imeval *tv, struct event_se
     fd_set write =3D ses->writefds;
     int stat;
=20
=2D    dmsg(D_EVENT_WAIT, "SE_WAIT_SCALEABLE maxfd=3D%d tv=3D%d/%d",
=2D         ses->maxfd, (int)tv_tmp.tv_sec, (int)tv_tmp.tv_usec);
+    dmsg(D_EVENT_WAIT, "SE_WAIT_SCALEABLE maxfd=3D%d tv=3D%lld/%ld",
+         ses->maxfd, (long long)tv_tmp.tv_sec, (long)tv_tmp.tv_usec);
=20
     stat =3D select(ses->maxfd + 1, &read, &write, NULL, &tv_tmp);
=20
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 6cc59383..a91a8d9a 100644
=2D-- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -618,7 +618,7 @@ check_coarse_timers_dowork(struct context *c)
     process_coarse_timers(c);
     c->c2.coarse_timer_wakeup =3D now + c->c2.timeval.tv_sec;
=20
=2D    dmsg(D_INTERVAL, "TIMER: coarse timer wakeup %d seconds", (int) c->c=
2.timeval.tv_sec);
+    dmsg(D_INTERVAL, "TIMER: coarse timer wakeup %lld seconds", (long long=
)c->c2.timeval.tv_sec);
=20
     /* Is the coarse timeout NOT the earliest one? */
     if (c->c2.timeval.tv_sec > save.tv_sec)
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index c798c438..4545bce1 100644
=2D-- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2388,14 +2388,14 @@ multi_process_post(struct multi_context *m, struct =
multi_instance *mi, const uns
         multi_set_pending(m, ANY_OUT(&mi->context) ? mi : NULL);
=20
 #ifdef MULTI_DEBUG_EVENT_LOOP
=2D        printf("POST %s[%d] to=3D%d lo=3D%d/%d w=3D%d/%d\n",
+        printf("POST %s[%d] to=3D%d lo=3D%d/%d w=3D%lld/%ld\n",
                id(mi),
                (int) (mi =3D=3D m->pending),
                mi ? mi->context.c2.to_tun.len : -1,
                mi ? mi->context.c2.to_link.len : -1,
                (mi && mi->context.c2.fragment) ? mi->context.c2.fragment->=
outgoing.len : -1,
=2D               (int)mi->context.c2.timeval.tv_sec,
=2D               (int)mi->context.c2.timeval.tv_usec);
+               (long long)mi->context.c2.timeval.tv_sec,
+               (long)mi->context.c2.timeval.tv_usec);
 #endif
     }
=20
diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index 3e576cc0..d741ae07 100644
=2D-- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -88,9 +88,9 @@ const char *
 tv_string(const struct timeval *tv, struct gc_arena *gc)
 {
     struct buffer out =3D alloc_buf_gc(64, gc);
=2D    buf_printf(&out, "[%d/%d]",
=2D               (int) tv->tv_sec,
=2D               (int )tv->tv_usec);
+    buf_printf(&out, "[%lld/%ld]",
+               (long long)tv->tv_sec,
+               (long)tv->tv_usec);
     return BSTR(&out);
 }
=20
@@ -103,7 +103,7 @@ const char *
 tv_string_abs(const struct timeval *tv, struct gc_arena *gc)
 {
     return time_string((time_t) tv->tv_sec,
=2D                       (int) tv->tv_usec,
+                       (long) tv->tv_usec,
                        true,
                        gc);
 }
@@ -132,7 +132,7 @@ time_string(time_t t, int usec, bool show_usec, struct =
gc_arena *gc)
=20
     if (show_usec && tv.tv_usec)
     {
=2D        buf_printf(&out, " us=3D%d", (int)tv.tv_usec);
+        buf_printf(&out, " us=3D%ld", (long)tv.tv_usec);
     }
=20
     return BSTR(&out);
@@ -198,10 +198,10 @@ time_test(void)
         t =3D time(NULL);
         gettimeofday(&tv, NULL);
 #if 1
=2D        msg(M_INFO, "t=3D%u s=3D%u us=3D%u",
=2D            (unsigned int)t,
=2D            (unsigned int)tv.tv_sec,
=2D            (unsigned int)tv.tv_usec);
+        msg(M_INFO, "t=3D%lld s=3D%lld us=3D%ld",
+            (long long)t,
+            (long long)tv.tv_sec,
+            (long)tv.tv_usec);
 #endif
     }
 }
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index a3ff5722..4e0e9868 100644
=2D-- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -608,14 +608,14 @@ packet_id_debug_print(int msglevel,
         }
         buf_printf(&out, "%c", c);
     }
=2D    buf_printf(&out, "] " time_format ":" packet_id_format, (time_type)p=
->time, (packet_id_print_type)p->id);
+    buf_printf(&out, "] %lld:" packet_id_format, (long long)p->time, (pack=
et_id_print_type)p->id);
     if (pin)
     {
=2D        buf_printf(&out, " " time_format ":" packet_id_format, (time_typ=
e)pin->time, (packet_id_print_type)pin->id);
+        buf_printf(&out, " %lld:" packet_id_format, (long long)pin->time, =
(packet_id_print_type)pin->id);
     }
=20
=2D    buf_printf(&out, " t=3D" time_format "[%d]",
=2D               (time_type)prev_now,
+    buf_printf(&out, " t=3D%lld[%d]",
+               (long long)prev_now,
                (int)(prev_now - tv.tv_sec));
=20
     buf_printf(&out, " r=3D[%d,%d,%d,%d,%d]",
@@ -668,8 +668,8 @@ packet_id_interactive_test(void)
         {
             packet_id_reap_test(&pid.rec);
             test =3D packet_id_test(&pid.rec, &pin);
=2D            printf("packet_id_test (" time_format ", " packet_id_format =
") returned %d\n",
=2D                   (time_type)pin.time,
+            printf("packet_id_test (%lld, " packet_id_format ") returned %=
d\n",
+                   (long long)pin.time,
                    (packet_id_print_type)pin.id,
                    test);
             if (test)
@@ -681,8 +681,8 @@ packet_id_interactive_test(void)
         {
             long_form =3D (count < 20);
             packet_id_alloc_outgoing(&pid.send, &pin, long_form);
=2D            printf("(" time_format "(" packet_id_format "), %d)\n",
=2D                   (time_type)pin.time,
+            printf("(%lld(" packet_id_format "), %d)\n",
+                   (long long)pin.time,
                    (packet_id_print_type)pin.id,
                    long_form);
             if (pid.send.id =3D=3D 10)
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 93541a9d..bfd8c247 100644
=2D-- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -788,14 +788,14 @@ reliable_debug_print(const struct reliable *rel, char=
 *desc)
     printf("********* struct reliable %s\n", desc);
     printf("  initial_timeout=3D%d\n", (int)rel->initial_timeout);
     printf("  packet_id=3D" packet_id_format "\n", rel->packet_id);
=2D    printf("  now=3D" time_format "\n", now);
+    printf("  now=3D%lld\n", (long long)now);
     for (i =3D 0; i < rel->size; ++i)
     {
         const struct reliable_entry *e =3D &rel->array[i];
         if (e->active)
         {
             printf("  %d: packet_id=3D" packet_id_format " len=3D%d", i, e=
->packet_id, e->buf.len);
=2D            printf(" next_try=3D" time_format, e->next_try);
+            printf(" next_try=3D%lld", (long long)e->next_try);
             printf("\n");
         }
     }
diff --git a/src/openvpn/shaper.c b/src/openvpn/shaper.c
index 19dd54d0..de2da6db 100644
=2D-- a/src/openvpn/shaper.c
+++ b/src/openvpn/shaper.c
@@ -76,8 +76,8 @@ shaper_soonest_event(struct timeval *tv, int delay)
         }
     }
 #ifdef SHAPER_DEBUG
=2D    dmsg(D_SHAPER_DEBUG, "SHAPER shaper_soonest_event sec=3D%d usec=3D%d=
 ret=3D%d",
=2D         (int)tv->tv_sec, (int)tv->tv_usec, (int)ret);
+    dmsg(D_SHAPER_DEBUG, "SHAPER shaper_soonest_event sec=3D%lld usec=3D%l=
d ret=3D%d",
+         (long long)tv->tv_sec, (long)tv->tv_usec, (int)ret);
 #endif
     return ret;
 }
diff --git a/src/openvpn/shaper.h b/src/openvpn/shaper.h
index 6fac16d5..34f316fd 100644
=2D-- a/src/openvpn/shaper.h
+++ b/src/openvpn/shaper.h
@@ -147,11 +147,11 @@ shaper_wrote_bytes(struct shaper *s, int nbytes)
         tv_add(&s->wakeup, &tv);
=20
 #ifdef SHAPER_DEBUG
=2D        dmsg(D_SHAPER_DEBUG, "SHAPER shaper_wrote_bytes bytes=3D%d delay=
=3D%d sec=3D%d usec=3D%d",
+        dmsg(D_SHAPER_DEBUG, "SHAPER shaper_wrote_bytes bytes=3D%d delay=
=3D%ld sec=3D%lld usec=3D%ld",
              nbytes,
=2D             (int)tv.tv_usec,
=2D             (int)s->wakeup.tv_sec,
=2D             (int)s->wakeup.tv_usec);
+             (long)tv.tv_usec,
+             (long long)s->wakeup.tv_sec,
+             (long)s->wakeup.tv_usec);
 #endif
     }
 }
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 92a662b5..0bfb6939 100644
=2D-- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1363,8 +1363,8 @@ bio_debug_data(const char *mode, BIO *bio, const uint=
8_t *buf, int len, const ch
     if (len > 0)
     {
         open_biofp();
=2D        fprintf(biofp, "BIO_%s %s time=3D" time_format " bio=3D" ptr_for=
mat " len=3D%d data=3D%s\n",
=2D                mode, desc, time(NULL), (ptr_type)bio, len, format_hex(b=
uf, len, 0, &gc));
+        fprintf(biofp, "BIO_%s %s time=3D%lld bio=3D" ptr_format " len=3D%=
d data=3D%s\n",
+                mode, desc, (long long)time(NULL), (ptr_type)bio, len, for=
mat_hex(buf, len, 0, &gc));
         fflush(biofp);
     }
     gc_free(&gc);
@@ -1374,8 +1374,8 @@ static void
 bio_debug_oc(const char *mode, BIO *bio)
 {
     open_biofp();
=2D    fprintf(biofp, "BIO %s time=3D" time_format " bio=3D" ptr_format "\n=
",
=2D            mode, time(NULL), (ptr_type)bio);
+    fprintf(biofp, "BIO %s time=3D%lld bio=3D" ptr_format "\n",
+            mode, (long long)time(NULL), (ptr_type)bio);
     fflush(biofp);
 }
=20
=2D-=20
2.14.2


--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


--=20
jca | PGP : 0x1524E7EE / 5135 92C1 AD36 5293 2BDF  DDCC 0DFA 74AE 1524 E7EE

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEUTWSwa02UpMr393MDfp0rhUk5+4FAlnxvy4ACgkQDfp0rhUk
5+5R3RAAi3GcrfKOllKO8JioNRZWLcaoHHhiX84tnSeweLZReDg0eIrYKaUQTRxi
2/3j3SnzafRjQu6FKsGv2q7NqueOGBbvXLljPqsekB7qBE28KnQ7OtMPFlkpH/4+
iGs4GHt8CMdgPGntZVUbN2YGQJ+QuKUoEMa+llrItkQe7cWRXespuZxa/LhEYwEB
xg9y81ZxB7s32QAxdYoAhWg+2QqD0ubFlspOIEgkwRKHTjbxAnOYwEir0++k1p9G
NBqvwrxsQPap3Kwop78W7gPISd39L2jXNKC89cF1ILtEb+QhLlPYqgIFNh6zeYBQ
WjizxjvKJz/wgHmDldE6JPtNihyxPXjWJaiUdwd77987teEcbCzoqO4gddvVcq59
0jm+bQTotQ3v4SwLX4P/qfJJ0YrvNX2hwgcL+kRBWeGzQmeJCrSS326PCDxTdPeb
2Bsu9/0lJ08F2dVaDm8XihE60tvb6lv2Xr5DQvc4Qwbbmlfz2o62xC+0uZhb2lU3
Ue+bbqEECNhswYbCSNA0DY2gJwNC1UqYYJ+M636Wfk5FvueBNoZ3/42F/ThaRyvu
Vhb7Q9Y2X9PtiMkxpdaI6xeu5q2jeqnHiWIqrAx2PRmyFUz2CF3ZJPLxSBkN/Qq1
/QeT1stWIzC8HEkBtLWyGQQ+XqKjfrPalPukSkj0BOFLKxKSZBs=
=+/Rl
-----END PGP SIGNATURE-----
--==-=-=--

