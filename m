MIME-Version: 1.0
In-Reply-To: <1329418045-3218-1-git-send-email-davids@...1347...>
References: <20120216182908.GM7024@...1296...>
	<1329418045-3218-1-git-send-email-davids@...1347...>
Date: Thu, 16 Feb 2012 20:53:44 +0200
Message-ID: <CAOazyz2OiaZdWjc6_cc-ZBAnkW53wU2G75YxaQs6j+FKizSM2w@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] use the underscore version of stat
	on Windows
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
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

Again,
All conditional statements should be within single config.h or
config-msvc.h or sysheader.h or anything.
Doing conditional inline makes code complex and unmaintainable.
But as you adds loooooooong patches without proper review I guess it
is not that important.
Alon.

On Thu, Feb 16, 2012 at 8:47 PM, David Sommerseth <davids@...1347...> wrote:
> From: Heiko Hund <heiko.hund@...1489...>
>
> MSVC does not know wstat(). Instead _wstat() must be used here.
> Unfortunately _wstat() takes a 'struct _stat'. A type 'stat_t' is
> introduced to handle this situation in a portable way.
>
> [v2: Use openvpn_stat_t instead of stat_t (David Sommerseth)]
>
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> Signed-off-by: David Sommerseth <davids@...1347...>
> ---
> =C2=A0misc.h =C2=A0| =C2=A0 =C2=A06 ++++--
> =C2=A0pf.c =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
> =C2=A0win32.c | =C2=A0 =C2=A04 ++--
> =C2=A03 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/misc.h b/misc.h
> index e7a0b55..bdada42 100644
> --- a/misc.h
> +++ b/misc.h
> @@ -168,10 +168,12 @@ openvpn_open (const char *path, int flags, mode_t m=
ode)
> =C2=A0#endif
>
> =C2=A0#ifdef WIN32
> -int openvpn_stat (const char *path, struct stat *buf);
> +typedef struct _stat openvpn_stat_t;
> +int openvpn_stat (const char *path, openvpn_stat_t *buf);
> =C2=A0#else
> +typedef struct stat openvpn_stat_t;
> =C2=A0static inline int
> -openvpn_stat (const char *path, struct stat *buf)
> +openvpn_stat (const char *path, openvpn_stat_t *buf)
> =C2=A0{
> =C2=A0 return stat (path, buf);
> =C2=A0}
> diff --git a/pf.c b/pf.c
> index a0e9fc8..0ef839e 100644
> --- a/pf.c
> +++ b/pf.c
> @@ -498,7 +498,7 @@ pf_check_reload (struct context *c)
> =C2=A0 =C2=A0 =C2=A0 && c->c2.pf.filename
> =C2=A0 =C2=A0 =C2=A0 && event_timeout_trigger (&c->c2.pf.reload, &c->c2.t=
imeval, ETT_DEFAULT))
> =C2=A0 =C2=A0 {
> - =C2=A0 =C2=A0 =C2=A0struct stat s;
> + =C2=A0 =C2=A0 =C2=A0openvpn_stat_t s;
> =C2=A0 =C2=A0 =C2=A0 if (!openvpn_stat (c->c2.pf.filename, &s))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s.st_mtime > c->c2.pf.file_last_mod)
> diff --git a/win32.c b/win32.c
> index a8f4ed9..2ba97fc 100644
> --- a/win32.c
> +++ b/win32.c
> @@ -1073,10 +1073,10 @@ openvpn_open (const char *path, int flags, int mo=
de)
> =C2=A0}
>
> =C2=A0int
> -openvpn_stat (const char *path, struct stat *buf)
> +openvpn_stat (const char *path, openvpn_stat_t *buf)
> =C2=A0{
> =C2=A0 struct gc_arena gc =3D gc_new ();
> - =C2=A0int res =3D wstat (wide_string (path, &gc), buf);
> + =C2=A0int res =3D _wstat (wide_string (path, &gc), buf);
> =C2=A0 gc_free (&gc);
> =C2=A0 return res;
> =C2=A0}
> --
> 1.7.4.4
>
>
> -------------------------------------------------------------------------=
-----
> Virtualization & Cloud Management Using Capacity Planning
> Cloud computing makes use of virtualization - but cloud computing
> also focuses on allowing computing to be delivered as a service.
> http://www.accelacomm.com/jaw/sfnl/114/51521223/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

