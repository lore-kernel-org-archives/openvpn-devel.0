MIME-Version: 1.0
In-Reply-To: <4F58B5D3.8030805@...515...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-50-git-send-email-alon.barlev@...277...>
	<4F58B5D3.8030805@...515...>
Date: Thu, 8 Mar 2012 21:25:25 +0200
Message-ID: <CAOazyz2TVnmZ0EEisRJRV2hi2VT3L5=01dgVjHC9us_1toZBVQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 49/52] build: move wrappers into
	platform module
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
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Well, at first I wanted to split it into its own libplatform distinct
from libcompat.

libcompat - emulation of missing library functions, drop-in replacement.
libplatform - extensions to library functions, such as unicode or
security additions.

But then I've seen that there is too much openvpn specific logic,
especially in log messages. So I left what I would have placed in
libplatform in platform.c for now.

After this round we should consider if we want to progress in this.

One missing part is the exec wrappers which needs some work before
moving to platform.

Alon.

2012/3/8 Samuli Sepp=C3=A4nen <samuli@...515...>:
> This probably makes sense, lots of good refactorings. That said, I'd
> like to know how you selected what goes to platform.c?
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
>
>> + Some fixups within the platform.c functions.
>> - need to check environment set on Windows.
>>
>> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
>> ---
>> =C2=A0src/openvpn/Makefile.am =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
>> =C2=A0src/openvpn/buffer.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
>> =C2=A0src/openvpn/crypto.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A06 +-
>> =C2=A0src/openvpn/error.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
>> =C2=A0src/openvpn/init.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 18 +-
>> =C2=A0src/openvpn/manage.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 16 +-
>> =C2=A0src/openvpn/misc.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0295 ++-----=
-----------------------------
>> =C2=A0src/openvpn/misc.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0106 +------=
-------
>> =C2=A0src/openvpn/mstats.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
>> =C2=A0src/openvpn/multi.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
>> =C2=A0src/openvpn/openvpn.h =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A04 +-
>> =C2=A0src/openvpn/openvpn.vcproj | =C2=A0 =C2=A08 +
>> =C2=A0src/openvpn/options.c =C2=A0 =C2=A0 =C2=A0| =C2=A0 14 +-
>> =C2=A0src/openvpn/packet_id.c =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
>> =C2=A0src/openvpn/pf.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A06 +-
>> =C2=A0src/openvpn/platform.c =C2=A0 =C2=A0 | =C2=A0369 +++++++++++++++++=
+++++++++++++++++++++++++++
>> =C2=A0src/openvpn/platform.h =C2=A0 =C2=A0 | =C2=A0142 +++++++++++++++++
>> =C2=A0src/openvpn/ps.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A02 +-
>> =C2=A0src/openvpn/ssl_openssl.c =C2=A0| =C2=A0 =C2=A02 +-
>> =C2=A0src/openvpn/ssl_verify.c =C2=A0 | =C2=A0 =C2=A08 +-
>> =C2=A0src/openvpn/status.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A06 +-
>> =C2=A0src/openvpn/tun.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 12 +-
>> =C2=A0src/openvpn/win32.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 27 ----
>> =C2=A023 files changed, 584 insertions(+), 468 deletions(-)
>> =C2=A0create mode 100644 src/openvpn/platform.c
>> =C2=A0create mode 100644 src/openvpn/platform.h
>>
>> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
>> index 333eebc..6ba12b8 100644
>> --- a/src/openvpn/Makefile.am
>> +++ b/src/openvpn/Makefile.am
>> @@ -58,6 +58,7 @@ openvpn_SOURCES =3D \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 mbuf.c mbuf.h \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 memdbg.h \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 misc.c misc.h \
>> + =C2=A0 =C2=A0 =C2=A0 platform.c platform.h \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 console.c console.h \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 mroute.c mroute.h \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 mss.c mss.h \
>> diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
>> index ad30223..5eee3ee 100644
>> --- a/src/openvpn/buffer.c
>> +++ b/src/openvpn/buffer.c
>> @@ -1080,7 +1080,7 @@ buffer_list_advance (struct buffer_list *ol, int n)
>> =C2=A0struct buffer_list *
>> =C2=A0buffer_list_file (const char *fn, int max_line_len)
>> =C2=A0{
>> - =C2=A0FILE *fp =3D openvpn_fopen (fn, "r");
>> + =C2=A0FILE *fp =3D platform_fopen (fn, "r");
>> =C2=A0 =C2=A0struct buffer_list *bl =3D NULL;
>>
>> =C2=A0 =C2=A0if (fp)
>> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
>> index 2e2e5d7..f811966 100644
>> --- a/src/openvpn/crypto.c
>> +++ b/src/openvpn/crypto.c
>> @@ -868,7 +868,7 @@ read_key_file (struct key2 *key2, const char *file, =
const unsigned int flags)
>> =C2=A0#endif
>> =C2=A0 =C2=A0 =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0in =3D alloc_buf_gc (2048, &gc);
>> - =C2=A0 =C2=A0 =C2=A0fd =3D openvpn_open (file, O_RDONLY, 0);
>> + =C2=A0 =C2=A0 =C2=A0fd =3D platform_open (file, O_RDONLY, 0);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd =3D=3D -1)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_ERR, "Cannot open file key file '%s'"=
, file);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0size =3D read (fd, in.data, in.capacity);
>> @@ -1029,7 +1029,7 @@ read_passphrase_hash (const char *passphrase_file,
>> =C2=A0 =C2=A0 =C2=A0const int min_passphrase_size =3D 8;
>> =C2=A0 =C2=A0 =C2=A0uint8_t buf[64];
>> =C2=A0 =C2=A0 =C2=A0int total_size =3D 0;
>> - =C2=A0 =C2=A0int fd =3D openvpn_open (passphrase_file, O_RDONLY, 0);
>> + =C2=A0 =C2=A0int fd =3D platform_open (passphrase_file, O_RDONLY, 0);
>>
>> =C2=A0 =C2=A0 =C2=A0if (fd =3D=3D -1)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_ERR, "Cannot open passphrase file: '%s=
'", passphrase_file);
>> @@ -1079,7 +1079,7 @@ write_key_file (const int nkeys, const char *filen=
ame)
>> =C2=A0 =C2=A0const int bytes_per_line =3D 16;
>>
>> =C2=A0 =C2=A0/* open key file */
>> - =C2=A0fd =3D openvpn_open (filename, O_CREAT | O_TRUNC | O_WRONLY, S_I=
RUSR | S_IWUSR);
>> + =C2=A0fd =3D platform_open (filename, O_CREAT | O_TRUNC | O_WRONLY, S_=
IRUSR | S_IWUSR);
>>
>> =C2=A0 =C2=A0if (fd =3D=3D -1)
>> =C2=A0 =C2=A0 =C2=A0msg (M_ERR, "Cannot open shared secret file '%s' for=
 write", filename);
>> diff --git a/src/openvpn/error.c b/src/openvpn/error.c
>> index 1f2dd86..d6ad639 100644
>> --- a/src/openvpn/error.c
>> +++ b/src/openvpn/error.c
>> @@ -640,7 +640,7 @@ x_check_status (int status,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0my_errno);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (x_cs_err_delay_ms)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sleep_milliseconds (x_cs_err_delay_=
ms);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 platform_sleep_milliseconds (x_cs_e=
rr_delay_ms);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0gc_free (&gc);
>> =C2=A0 =C2=A0 =C2=A0}
>> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
>> index bba3cf8..bc7718e 100644
>> --- a/src/openvpn/init.c
>> +++ b/src/openvpn/init.c
>> @@ -935,7 +935,7 @@ do_genkey (const struct options * options)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"shared secret ou=
tput file (--secret)");
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (options->mlock) =C2=A0 =C2=A0 =C2=A0/* sh=
ould we disable paging? */
>> - =C2=A0 =C2=A0 =C2=A0 do_mlockall (true);
>> + =C2=A0 =C2=A0 =C2=A0 platform_mlockall (true);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0nbits_written =3D write_key_file (2, options-=
>shared_secret_file);
>>
>> @@ -1022,7 +1022,7 @@ do_uid_gid_chroot (struct context *c, bool no_dela=
y)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (c->options.chroot_dir)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (no_delay)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_chroot (c->options.chroot_dir);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 platform_chroot (c->options.chroot_=
dir);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_INFO, "NOTE: chroot %s"=
, why_not);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> @@ -1030,8 +1030,8 @@ do_uid_gid_chroot (struct context *c, bool no_dela=
y)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* set user and/or group that we want to setu=
id/setgid to */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (no_delay)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_group (&c0->group_state);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_user (&c0->user_state);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 platform_group_set (&c0->platform_state_gr=
oup);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 platform_user_set (&c0->platform_state_use=
r);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c0->uid_gid_set =3D true;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (c0->uid_gid_specified)
>> @@ -2780,8 +2780,8 @@ do_init_first_time (struct context *c)
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* get user and/or group that we want to setu=
id/setgid to */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0c0->uid_gid_specified =3D
>> - =C2=A0 =C2=A0 =C2=A0 get_group (c->options.groupname, &c0->group_state=
) |
>> - =C2=A0 =C2=A0 =C2=A0 get_user (c->options.username, &c0->user_state);
>> + =C2=A0 =C2=A0 =C2=A0 platform_group_get (c->options.groupname, &c0->pl=
atform_state_group) |
>> + =C2=A0 =C2=A0 =C2=A0 platform_user_get (c->options.username, &c0->plat=
form_state_user);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* get --writepid file descriptor */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0get_pid_file (c->options.writepid, &c0->pid_s=
tate);
>> @@ -2791,13 +2791,13 @@ do_init_first_time (struct context *c)
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* should we disable paging? */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (c->options.mlock && c->did_we_daemonize)
>> - =C2=A0 =C2=A0 =C2=A0 do_mlockall (true); =C2=A0 =C2=A0 /* call again i=
n case we daemonized */
>> + =C2=A0 =C2=A0 =C2=A0 platform_mlockall (true); =C2=A0 =C2=A0 =C2=A0 /*=
 call again in case we daemonized */
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* save process ID in a file */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0write_pid (&c0->pid_state);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* should we change scheduling priority? */
>> - =C2=A0 =C2=A0 =C2=A0set_nice (c->options.nice);
>> + =C2=A0 =C2=A0 =C2=A0platform_nice (c->options.nice);
>> =C2=A0 =C2=A0 =C2=A0}
>> =C2=A0}
>>
>> @@ -3342,7 +3342,7 @@ init_instance (struct context *c, const struct env=
_set *env, const unsigned int
>>
>> =C2=A0 =C2=A0/* should we disable paging? */
>> =C2=A0 =C2=A0if (c->first_time && options->mlock)
>> - =C2=A0 =C2=A0do_mlockall (true);
>> + =C2=A0 =C2=A0platform_mlockall (true);
>>
>> =C2=A0#if P2MP
>> =C2=A0 =C2=A0/* get passwords if undefined */
>> diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
>> index 85c9aca..1dddd41 100644
>> --- a/src/openvpn/manage.c
>> +++ b/src/openvpn/manage.c
>> @@ -1146,7 +1146,7 @@ man_dispatch_command (struct management *man, stru=
ct status_output *so, const ch
>> =C2=A0 =C2=A0 =C2=A0}
>> =C2=A0 =C2=A0else if (streq (p[0], "pid"))
>> =C2=A0 =C2=A0 =C2=A0{
>> - =C2=A0 =C2=A0 =C2=A0msg (M_CLIENT, "SUCCESS: pid=3D%d", openvpn_getpid=
 ());
>> + =C2=A0 =C2=A0 =C2=A0msg (M_CLIENT, "SUCCESS: pid=3D%d", platform_getpi=
d ());
>> =C2=A0 =C2=A0 =C2=A0}
>> =C2=A0#ifdef MANAGEMENT_DEF_AUTH
>> =C2=A0 =C2=A0else if (streq (p[0], "nclients"))
>> @@ -1429,7 +1429,7 @@ man_record_peer_info (struct management *man)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const in_addr_t a =3D n=
tohl (addr.sin_addr.s_addr);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const int p =3D ntohs (=
addr.sin_port);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FILE *fp =3D openvpn_fopen (=
man->settings.write_peer_info_file, "w");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FILE *fp =3D platform_fopen =
(man->settings.write_peer_info_file, "w");
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fp)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf (=
fp, "%s\n%d\n", print_in_addr_t (a, 0, &gc), p);
>> @@ -2013,17 +2013,17 @@ man_settings_init (struct man_settings *ms,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (client_user)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct user_state s;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_user (client_user, &s);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 ms->client_uid =3D user_state_uid (&s);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct platform_state_user s;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 platform_user_get (client_user, &s);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 ms->client_uid =3D platform_state_user_uid=
 (&s);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (D_MANAGEMENT, "MANAGEMENT: clien=
t_uid=3D%d", ms->client_uid);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ASSERT (ms->client_uid >=3D 0);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (client_group)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct group_state s;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_group (client_group, &s);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 ms->client_gid =3D group_state_gid (&s);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct platform_state_group s;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 platform_group_get (client_group, &s);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 ms->client_gid =3D platform_state_group_gi=
d (&s);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (D_MANAGEMENT, "MANAGEMENT: clien=
t_gid=3D%d", ms->client_gid);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ASSERT (ms->client_gid >=3D 0);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
>> index 2571194..2ded9bf 100644
>> --- a/src/openvpn/misc.c
>> +++ b/src/openvpn/misc.c
>> @@ -56,122 +56,6 @@ int script_security =3D SSEC_BUILT_IN; /* GLOBAL */
>> =C2=A0/* contains SM_x value defined in misc.h */
>> =C2=A0int script_method =3D SM_EXECVE; /* GLOBAL */
>>
>> -/* Redefine the top level directory of the filesystem
>> - =C2=A0 to restrict access to files for security */
>> -void
>> -do_chroot (const char *path)
>> -{
>> - =C2=A0if (path)
>> - =C2=A0 =C2=A0{
>> -#ifdef HAVE_CHROOT
>> - =C2=A0 =C2=A0 =C2=A0const char *top =3D "/";
>> - =C2=A0 =C2=A0 =C2=A0if (chroot (path))
>> - =C2=A0 =C2=A0 =C2=A0 msg (M_ERR, "chroot to '%s' failed", path);
>> - =C2=A0 =C2=A0 =C2=A0if (openvpn_chdir (top))
>> - =C2=A0 =C2=A0 =C2=A0 msg (M_ERR, "cd to '%s' failed", top);
>> - =C2=A0 =C2=A0 =C2=A0msg (M_INFO, "chroot to '%s' and cd to '%s' succee=
ded", path, top);
>> -#else
>> - =C2=A0 =C2=A0 =C2=A0msg (M_FATAL, "Sorry but I can't chroot to '%s' be=
cause this operating system doesn't appear to support the chroot() system c=
all", path);
>> -#endif
>> - =C2=A0 =C2=A0}
>> -}
>> -
>> -/* Get/Set UID of process */
>> -
>> -bool
>> -get_user (const char *username, struct user_state *state)
>> -{
>> - =C2=A0bool ret =3D false;
>> - =C2=A0CLEAR (*state);
>> - =C2=A0if (username)
>> - =C2=A0 =C2=A0{
>> -#if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
>> - =C2=A0 =C2=A0 =C2=A0state->pw =3D getpwnam (username);
>> - =C2=A0 =C2=A0 =C2=A0if (!state->pw)
>> - =C2=A0 =C2=A0 =C2=A0 msg (M_ERR, "failed to find UID for user %s", use=
rname);
>> - =C2=A0 =C2=A0 =C2=A0state->username =3D username;
>> - =C2=A0 =C2=A0 =C2=A0ret =3D true;
>> -#else
>> - =C2=A0 =C2=A0 =C2=A0msg (M_FATAL, "cannot get UID for user %s -- platf=
orm lacks getpwname() or setuid() system calls", username);
>> -#endif
>> - =C2=A0 =C2=A0}
>> - =C2=A0return ret;
>> -}
>> -
>> -void
>> -set_user (const struct user_state *state)
>> -{
>> -#if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
>> - =C2=A0if (state->username && state->pw)
>> - =C2=A0 =C2=A0{
>> - =C2=A0 =C2=A0 =C2=A0if (setuid (state->pw->pw_uid))
>> - =C2=A0 =C2=A0 =C2=A0 msg (M_ERR, "setuid('%s') failed", state->usernam=
e);
>> - =C2=A0 =C2=A0 =C2=A0msg (M_INFO, "UID set to %s", state->username);
>> - =C2=A0 =C2=A0}
>> -#endif
>> -}
>> -
>> -/* Get/Set GID of process */
>> -
>> -bool
>> -get_group (const char *groupname, struct group_state *state)
>> -{
>> - =C2=A0bool ret =3D false;
>> - =C2=A0CLEAR (*state);
>> - =C2=A0if (groupname)
>> - =C2=A0 =C2=A0{
>> -#if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
>> - =C2=A0 =C2=A0 =C2=A0state->gr =3D getgrnam (groupname);
>> - =C2=A0 =C2=A0 =C2=A0if (!state->gr)
>> - =C2=A0 =C2=A0 =C2=A0 msg (M_ERR, "failed to find GID for group %s", gr=
oupname);
>> - =C2=A0 =C2=A0 =C2=A0state->groupname =3D groupname;
>> - =C2=A0 =C2=A0 =C2=A0ret =3D true;
>> -#else
>> - =C2=A0 =C2=A0 =C2=A0msg (M_FATAL, "cannot get GID for group %s -- plat=
form lacks getgrnam() or setgid() system calls", groupname);
>> -#endif
>> - =C2=A0 =C2=A0}
>> - =C2=A0return ret;
>> -}
>> -
>> -void
>> -set_group (const struct group_state *state)
>> -{
>> -#if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
>> - =C2=A0if (state->groupname && state->gr)
>> - =C2=A0 =C2=A0{
>> - =C2=A0 =C2=A0 =C2=A0if (setgid (state->gr->gr_gid))
>> - =C2=A0 =C2=A0 =C2=A0 msg (M_ERR, "setgid('%s') failed", state->groupna=
me);
>> - =C2=A0 =C2=A0 =C2=A0msg (M_INFO, "GID set to %s", state->groupname);
>> -#ifdef HAVE_SETGROUPS
>> - =C2=A0 =C2=A0 =C2=A0{
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0gid_t gr_list[1];
>> - =C2=A0 =C2=A0 =C2=A0 gr_list[0] =3D state->gr->gr_gid;
>> - =C2=A0 =C2=A0 =C2=A0 if (setgroups (1, gr_list))
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_ERR, "setgroups('%s') failed", stat=
e->groupname);
>> - =C2=A0 =C2=A0 =C2=A0}
>> -#endif
>> - =C2=A0 =C2=A0}
>> -#endif
>> -}
>> -
>> -/* Change process priority */
>> -void
>> -set_nice (int niceval)
>> -{
>> - =C2=A0if (niceval)
>> - =C2=A0 =C2=A0{
>> -#ifdef HAVE_NICE
>> - =C2=A0 =C2=A0 =C2=A0errno =3D 0;
>> - =C2=A0 =C2=A0 =C2=A0if (nice (niceval) < 0 && errno !=3D 0)
>> - =C2=A0 =C2=A0 =C2=A0 msg (M_WARN | M_ERRNO, "WARNING: nice %d failed: =
%s", niceval, strerror(errno));
>> - =C2=A0 =C2=A0 =C2=A0else
>> - =C2=A0 =C2=A0 =C2=A0 msg (M_INFO, "nice %d succeeded", niceval);
>> -#else
>> - =C2=A0 =C2=A0 =C2=A0msg (M_WARN, "WARNING: nice %d failed (function no=
t implemented)", niceval);
>> -#endif
>> - =C2=A0 =C2=A0}
>> -}
>> -
>> =C2=A0/*
>> =C2=A0 * Pass tunnel endpoint and MTU parms to a user-supplied script.
>> =C2=A0 * Used to execute the up/down script/plugins.
>> @@ -253,7 +137,7 @@ get_pid_file (const char* filename, struct pid_state=
 *state)
>> =C2=A0 =C2=A0CLEAR (*state);
>> =C2=A0 =C2=A0if (filename)
>> =C2=A0 =C2=A0 =C2=A0{
>> - =C2=A0 =C2=A0 =C2=A0state->fp =3D openvpn_fopen (filename, "w");
>> + =C2=A0 =C2=A0 =C2=A0state->fp =3D platform_fopen (filename, "w");
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!state->fp)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_ERR, "Open error on pid file %s", fil=
ename);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0state->filename =3D filename;
>> @@ -266,42 +150,13 @@ write_pid (const struct pid_state *state)
>> =C2=A0{
>> =C2=A0 =C2=A0if (state->filename && state->fp)
>> =C2=A0 =C2=A0 =C2=A0{
>> - =C2=A0 =C2=A0 =C2=A0unsigned int pid =3D openvpn_getpid ();
>> + =C2=A0 =C2=A0 =C2=A0unsigned int pid =3D platform_getpid ();
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(state->fp, "%u\n", pid);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fclose (state->fp))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_ERR, "Close error on pid file %s", st=
ate->filename);
>> =C2=A0 =C2=A0 =C2=A0}
>> =C2=A0}
>>
>> -/* Get current PID */
>> -unsigned int
>> -openvpn_getpid ()
>> -{
>> -#ifdef WIN32
>> - =C2=A0return (unsigned int) GetCurrentProcessId ();
>> -#else
>> -#ifdef HAVE_GETPID
>> - =C2=A0return (unsigned int) getpid ();
>> -#else
>> - =C2=A0return 0;
>> -#endif
>> -#endif
>> -}
>> -
>> -/* Disable paging */
>> -void
>> -do_mlockall(bool print_msg)
>> -{
>> -#ifdef HAVE_MLOCKALL
>> - =C2=A0if (mlockall (MCL_CURRENT | MCL_FUTURE))
>> - =C2=A0 =C2=A0msg (M_WARN | M_ERRNO, "WARNING: mlockall call failed");
>> - =C2=A0else if (print_msg)
>> - =C2=A0 =C2=A0msg (M_INFO, "mlockall call succeeded");
>> -#else
>> - =C2=A0msg (M_WARN, "WARNING: mlockall call failed (function not implem=
ented)");
>> -#endif
>> -}
>> -
>> =C2=A0/*
>> =C2=A0 * Set standard file descriptors to /dev/null
>> =C2=A0 */
>> @@ -325,27 +180,6 @@ set_std_files_to_null (bool stdin_only)
>> =C2=A0}
>>
>> =C2=A0/*
>> - * Wrapper for chdir library function
>> - */
>> -int
>> -openvpn_chdir (const char* dir)
>> -{
>> -#ifdef HAVE_CHDIR
>> -#ifdef WIN32
>> - =C2=A0int res;
>> - =C2=A0struct gc_arena gc =3D gc_new ();
>> - =C2=A0res =3D _wchdir (wide_string (dir, &gc));
>> - =C2=A0gc_free (&gc);
>> - =C2=A0return res;
>> -#else
>> - =C2=A0return chdir (dir);
>> -#endif
>> -#else
>> - =C2=A0return -1;
>> -#endif
>> -}
>> -
>> -/*
>> =C2=A0 * =C2=A0dup inetd/xinetd socket descriptor and save
>> =C2=A0 */
>>
>> @@ -391,32 +225,6 @@ warn_if_group_others_accessible (const char* filena=
me)
>> =C2=A0}
>>
>> =C2=A0/*
>> - * convert system() return into a success/failure value
>> - */
>> -bool
>> -system_ok (int stat)
>> -{
>> -#ifdef WIN32
>> - =C2=A0return stat =3D=3D 0;
>> -#else
>> - =C2=A0return stat !=3D -1 && WIFEXITED (stat) && WEXITSTATUS (stat) =
=3D=3D 0;
>> -#endif
>> -}
>> -
>> -/*
>> - * did system() call execute the given command?
>> - */
>> -bool
>> -system_executed (int stat)
>> -{
>> -#ifdef WIN32
>> - =C2=A0return stat !=3D -1;
>> -#else
>> - =C2=A0return stat !=3D -1 && WEXITSTATUS (stat) !=3D 127;
>> -#endif
>> -}
>> -
>> -/*
>> =C2=A0 * Print an error message based on the status code returned by sys=
tem().
>> =C2=A0 */
>> =C2=A0const char *
>> @@ -456,7 +264,7 @@ openvpn_execve_check (const struct argv *a, const st=
ruct env_set *es, const unsi
>> =C2=A0 =C2=A0const int stat =3D openvpn_execve (a, es, flags);
>> =C2=A0 =C2=A0int ret =3D false;
>>
>> - =C2=A0if (system_ok (stat))
>> + =C2=A0if (platform_system_ok (stat))
>> =C2=A0 =C2=A0 =C2=A0ret =3D true;
>> =C2=A0 =C2=A0else
>> =C2=A0 =C2=A0 =C2=A0{
>> @@ -554,7 +362,6 @@ openvpn_system (const char *command, const struct en=
v_set *es, unsigned int flag
>> =C2=A0{
>> =C2=A0#ifdef HAVE_SYSTEM
>> =C2=A0 =C2=A0int ret;
>> - =C2=A0struct gc_arena gc;
>>
>> =C2=A0 =C2=A0perf_push (PERF_SCRIPT);
>>
>> @@ -573,13 +380,7 @@ openvpn_system (const char *command, const struct e=
nv_set *es, unsigned int flag
>> =C2=A0 =C2=A0/*
>> =C2=A0 =C2=A0 * execute the command
>> =C2=A0 =C2=A0 */
>> -#ifdef WIN32
>> - =C2=A0gc =3D gc_new ();
>> - =C2=A0ret =3D _wsystem (wide_string (command, &gc));
>> - =C2=A0gc_free (&gc);
>> -#else
>> - =C2=A0ret =3D system (command);
>> -#endif
>> + =C2=A0ret =3D platform_system(command);
>>
>> =C2=A0 =C2=A0/* debugging */
>> =C2=A0 =C2=A0dmsg (D_SCRIPT, "SYSTEM return=3D%u", ret);
>> @@ -599,19 +400,6 @@ openvpn_system (const char *command, const struct e=
nv_set *es, unsigned int flag
>> =C2=A0#endif
>> =C2=A0}
>>
>> -int
>> -openvpn_access (const char *path, int mode)
>> -{
>> -#ifdef WIN32
>> - =C2=A0struct gc_arena gc =3D gc_new ();
>> - =C2=A0int ret =3D _waccess (wide_string (path, &gc), mode);
>> - =C2=A0gc_free (&gc);
>> - =C2=A0return ret;
>> -#else
>> - =C2=A0return access (path, mode);
>> -#endif
>> -}
>> -
>> =C2=A0/*
>> =C2=A0 * Run execve() inside a fork(), duping stdout. =C2=A0Designed to =
replicate the semantics of popen() but
>> =C2=A0 * in a safer way that doesn't require the invocation of a shell o=
r the risks
>> @@ -981,7 +769,7 @@ env_set_remove_from_environment (const struct env_se=
t *es)
>>
>> =C2=A0static struct env_item *global_env =3D NULL; /* GLOBAL */
>>
>> -static void
>> +void
>> =C2=A0manage_env (char *str)
>> =C2=A0{
>> =C2=A0 =C2=A0remove_env_item (str, true, &global_env);
>> @@ -1078,27 +866,11 @@ setenv_str_ex (struct env_set *es,
>> =C2=A0 =C2=A0 =C2=A0}
>> =C2=A0 =C2=A0else
>> =C2=A0 =C2=A0 =C2=A0{
>> -#if defined(WIN32)
>> + =C2=A0 =C2=A0 =C2=A0char *str =3D construct_name_value (name_tmp, val_=
tmp, NULL);
>> + =C2=A0 =C2=A0 =C2=A0if (platform_putenv(str))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0{
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!SetEnvironmentVariableW (wide_string (=
name_tmp, &gc),
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wide_string (=
val_tmp, &gc)))
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_WARN | M_ERRNO, "SetEnvironmentVari=
able failed, name=3D'%s', value=3D'%s'",
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name_tmp,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val_tmp ? val_tmp : "N=
ULL");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_WARN | M_ERRNO, "putenv('%s') failed=
", str);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> -#elif defined(HAVE_PUTENV)
>> - =C2=A0 =C2=A0 =C2=A0{
>> - =C2=A0 =C2=A0 =C2=A0 char *str =3D construct_name_value (name_tmp, val=
_tmp, NULL);
>> - =C2=A0 =C2=A0 =C2=A0 int status;
>> -
>> - =C2=A0 =C2=A0 =C2=A0 status =3D putenv (str);
>> - =C2=A0 =C2=A0 =C2=A0 /*msg (M_INFO, "PUTENV '%s'", str);*/
>> - =C2=A0 =C2=A0 =C2=A0 if (!status)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 manage_env (str);
>> - =C2=A0 =C2=A0 =C2=A0 if (status)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_WARN | M_ERRNO, "putenv('%s') faile=
d", str);
>> - =C2=A0 =C2=A0 =C2=A0}
>> -#endif
>> =C2=A0 =C2=A0 =C2=A0}
>>
>> =C2=A0 =C2=A0gc_free (&gc);
>> @@ -1162,35 +934,6 @@ count_netmask_bits(const char *dotted_quad)
>> =C2=A0 =C2=A0return ((int)result);
>> =C2=A0}
>>
>> -/*
>> - * Go to sleep for n milliseconds.
>> - */
>> -void
>> -sleep_milliseconds (unsigned int n)
>> -{
>> -#ifdef WIN32
>> - =C2=A0Sleep (n);
>> -#else
>> - =C2=A0struct timeval tv;
>> - =C2=A0tv.tv_sec =3D n / 1000;
>> - =C2=A0tv.tv_usec =3D (n % 1000) * 1000;
>> - =C2=A0select (0, NULL, NULL, NULL, &tv);
>> -#endif
>> -}
>> -
>> -/*
>> - * Go to sleep indefinitely.
>> - */
>> -void
>> -sleep_until_signal (void)
>> -{
>> -#ifdef WIN32
>> - =C2=A0ASSERT (0);
>> -#else
>> - =C2=A0select (0, NULL, NULL, NULL, NULL);
>> -#endif
>> -}
>> -
>> =C2=A0/* return true if filename can be opened for read */
>> =C2=A0bool
>> =C2=A0test_file (const char *filename)
>> @@ -1198,7 +941,7 @@ test_file (const char *filename)
>> =C2=A0 =C2=A0bool ret =3D false;
>> =C2=A0 =C2=A0if (filename)
>> =C2=A0 =C2=A0 =C2=A0{
>> - =C2=A0 =C2=A0 =C2=A0FILE *fp =3D openvpn_fopen (filename, "r");
>> + =C2=A0 =C2=A0 =C2=A0FILE *fp =3D platform_fopen (filename, "r");
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fp)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fclose (fp);
>> @@ -1246,7 +989,7 @@ create_temp_file (const char *directory, const char=
 *prefix, struct gc_arena *gc
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Atomically create the file. =C2=A0Errors o=
ut if the file already
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exists. =C2=A0*/
>> - =C2=A0 =C2=A0 =C2=A0fd =3D openvpn_open (retfname, O_CREAT | O_EXCL | =
O_WRONLY, S_IRUSR | S_IWUSR);
>> + =C2=A0 =C2=A0 =C2=A0fd =3D platform_open (retfname, O_CREAT | O_EXCL |=
 O_WRONLY, S_IRUSR | S_IWUSR);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd !=3D -1)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close (fd);
>> @@ -1342,22 +1085,6 @@ gen_path (const char *directory, const char *file=
name, struct gc_arena *gc)
>> =C2=A0 =C2=A0 =C2=A0return NULL;
>> =C2=A0}
>>
>> -/* delete a file, return true if succeeded */
>> -bool
>> -delete_file (const char *filename)
>> -{
>> -#if defined(WIN32)
>> - =C2=A0struct gc_arena gc =3D gc_new ();
>> - =C2=A0BOOL ret =3D DeleteFileW (wide_string (filename, &gc));
>> - =C2=A0gc_free (&gc);
>> - =C2=A0return (ret !=3D 0);
>> -#elif defined(HAVE_UNLINK)
>> - =C2=A0return (unlink (filename) =3D=3D 0);
>> -#else
>> - =C2=A0return false;
>> -#endif
>> -}
>> -
>> =C2=A0bool
>> =C2=A0absolute_pathname (const char *pathname)
>> =C2=A0{
>> @@ -1524,7 +1251,7 @@ get_user_pass_cr (struct user_pass *up,
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 warn_if_group_others_accessible (auth=
_file);
>>
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 fp =3D openvpn_fopen (auth_file, "r");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 fp =3D platform_fopen (auth_file, "r");
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!fp)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_ERR, "Error opening '%s=
' auth file: %s", prefix, auth_file);
>>
>> diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
>> index 12a8f71..d4c8e33 100644
>> --- a/src/openvpn/misc.h
>> +++ b/src/openvpn/misc.h
>> @@ -29,6 +29,7 @@
>> =C2=A0#include "common.h"
>> =C2=A0#include "integer.h"
>> =C2=A0#include "buffer.h"
>> +#include "platform.h"
>>
>> =C2=A0/* socket descriptor passed by inetd/xinetd server to us */
>> =C2=A0#define INETD_SOCKET_DESCRIPTOR 0
>> @@ -58,37 +59,6 @@ struct env_set {
>> =C2=A0 =C2=A0struct env_item *list;
>> =C2=A0};
>>
>> -/* Get/Set UID of process */
>> -
>> -struct user_state {
>> -#if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
>> - =C2=A0const char *username;
>> - =C2=A0struct passwd *pw;
>> -#else
>> - =C2=A0int dummy;
>> -#endif
>> -};
>> -
>> -bool get_user (const char *username, struct user_state *state);
>> -void set_user (const struct user_state *state);
>> -
>> -/* Get/Set GID of process */
>> -
>> -struct group_state {
>> -#if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
>> - =C2=A0const char *groupname;
>> - =C2=A0struct group *gr;
>> -#else
>> - =C2=A0int dummy;
>> -#endif
>> -};
>> -
>> -bool get_group (const char *groupname, struct group_state *state);
>> -void set_group (const struct group_state *state);
>> -
>> -void set_nice (int niceval);
>> -void do_chroot (const char *path);
>> -
>> =C2=A0void run_up_down (const char *command,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const str=
uct plugin_list *plugins,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int plugi=
n_type,
>> @@ -111,9 +81,6 @@ struct pid_state {
>>
>> =C2=A0void get_pid_file (const char* filename, struct pid_state *state);
>> =C2=A0void write_pid (const struct pid_state *state);
>> -unsigned int openvpn_getpid (void);
>> -
>> -void do_mlockall (bool print_msg); /* Disable paging */
>>
>> =C2=A0/* check file protections */
>> =C2=A0void warn_if_group_others_accessible(const char* filename);
>> @@ -122,9 +89,6 @@ void warn_if_group_others_accessible(const char* file=
name);
>> =C2=A0#define S_SCRIPT (1<<0)
>> =C2=A0#define S_FATAL =C2=A0(1<<1)
>>
>> -/* interpret the status code returned by system()/execve() */
>> -bool system_ok(int);
>> -bool system_executed (int stat);
>> =C2=A0const char *system_error_message (int, struct gc_arena *gc);
>>
>> =C2=A0/* wrapper around the execve() call */
>> @@ -133,7 +97,6 @@ int openvpn_execve (const struct argv *a, const struc=
t env_set *es, const unsign
>> =C2=A0bool openvpn_execve_check (const struct argv *a, const struct env_=
set *es, const unsigned int flags, const char *error_message);
>> =C2=A0bool openvpn_execve_allowed (const unsigned int flags);
>> =C2=A0int openvpn_system (const char *command, const struct env_set *es,=
 unsigned int flags);
>> -int openvpn_access (const char *path, int mode);
>>
>> =C2=A0static inline bool
>> =C2=A0openvpn_run_script (const struct argv *a, const struct env_set *es=
, const unsigned int flags, const char *hook)
>> @@ -144,37 +107,6 @@ openvpn_run_script (const struct argv *a, const str=
uct env_set *es, const unsign
>> =C2=A0 =C2=A0return openvpn_execve_check(a, es, flags | S_SCRIPT, msg);
>> =C2=A0}
>>
>> -#ifdef WIN32
>> -FILE * openvpn_fopen (const char *path, const char *mode);
>> -#else
>> -static inline FILE *
>> -openvpn_fopen (const char *path, const char *mode)
>> -{
>> - =C2=A0return fopen (path, mode);
>> -}
>> -#endif
>> -
>> -#ifdef WIN32
>> -int openvpn_open (const char *path, int flags, int mode);
>> -#else
>> -static inline int
>> -openvpn_open (const char *path, int flags, mode_t mode)
>> -{
>> - =C2=A0return open (path, flags, mode);
>> -}
>> -#endif
>> -
>> -#ifdef WIN32
>> -typedef struct _stat openvpn_stat_t;
>> -int openvpn_stat (const char *path, openvpn_stat_t *buf);
>> -#else
>> -typedef struct stat openvpn_stat_t;
>> -static inline int
>> -openvpn_stat (const char *path, openvpn_stat_t *buf)
>> -{
>> - =C2=A0return stat (path, buf);
>> -}
>> -#endif
>>
>> =C2=A0#ifdef HAVE_STRERROR
>> =C2=A0/* a thread-safe version of strerror */
>> @@ -184,9 +116,6 @@ const char* strerror_ts (int errnum, struct gc_arena=
 *gc);
>> =C2=A0/* Set standard file descriptors to /dev/null */
>> =C2=A0void set_std_files_to_null (bool stdin_only);
>>
>> -/* Wrapper for chdir library function */
>> -int openvpn_chdir (const char* dir);
>> -
>> =C2=A0/* dup inetd/xinetd socket descriptor and save */
>> =C2=A0extern int inetd_socket_descriptor;
>> =C2=A0void save_inetd_socket_descriptor (void);
>> @@ -242,12 +171,6 @@ const char **make_extended_arg_array (char **p, str=
uct gc_arena *gc);
>> =C2=A0int count_netmask_bits(const char *);
>> =C2=A0unsigned int count_bits(unsigned int );
>>
>> -/* go to sleep for n milliseconds */
>> -void sleep_milliseconds (unsigned int n);
>> -
>> -/* go to sleep indefinitely */
>> -void sleep_until_signal (void);
>> -
>> =C2=A0/* an analogue to the random() function, but use OpenSSL functions=
 if available */
>> =C2=A0#ifdef ENABLE_CRYPTO
>> =C2=A0long int get_random(void);
>> @@ -264,9 +187,6 @@ const char *create_temp_file (const char *directory,=
 const char *prefix, struct
>> =C2=A0/* put a directory and filename together */
>> =C2=A0const char *gen_path (const char *directory, const char *filename,=
 struct gc_arena *gc);
>>
>> -/* delete a file, return true if succeeded */
>> -bool delete_file (const char *filename);
>> -
>> =C2=A0/* return true if pathname is absolute */
>> =C2=A0bool absolute_pathname (const char *pathname);
>>
>> @@ -448,28 +368,4 @@ void argv_printf_cat (struct argv *a, const char *f=
ormat, ...)
>> =C2=A0#endif
>> =C2=A0 =C2=A0;
>>
>> -/*
>> - * Extract UID or GID
>> - */
>> -
>> -static inline int
>> -user_state_uid (const struct user_state *s)
>> -{
>> -#if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
>> - =C2=A0if (s->pw)
>> - =C2=A0 =C2=A0return s->pw->pw_uid;
>> -#endif
>> - =C2=A0return -1;
>> -}
>> -
>> -static inline int
>> -group_state_gid (const struct group_state *s)
>> -{
>> -#if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
>> - =C2=A0if (s->gr)
>> - =C2=A0 =C2=A0return s->gr->gr_gid;
>> -#endif
>> - =C2=A0return -1;
>> -}
>> -
>> =C2=A0#endif
>> diff --git a/src/openvpn/mstats.c b/src/openvpn/mstats.c
>> index b4b864b..3be493c 100644
>> --- a/src/openvpn/mstats.c
>> +++ b/src/openvpn/mstats.c
>> @@ -114,7 +114,7 @@ mstats_close(void)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmap_stats->state =3D MSTATS_EXPIRED;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (munmap((void *)mmap_stats, sizeof(struct =
mmap_stats)))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_WARN | M_ERRNO, "mstats_close: munmap=
 error");
>> - =C2=A0 =C2=A0 =C2=A0delete_file(mmap_fn);
>> + =C2=A0 =C2=A0 =C2=A0platform_unlink(mmap_fn);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmap_stats =3D NULL;
>> =C2=A0 =C2=A0 =C2=A0}
>> =C2=A0}
>> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
>> index e79c6f1..9876b80 100644
>> --- a/src/openvpn/multi.c
>> +++ b/src/openvpn/multi.c
>> @@ -1452,7 +1452,7 @@ multi_client_connect_post (struct multi_context *m,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0option_types_found,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mi->context.c2.es);
>>
>> - =C2=A0 =C2=A0 =C2=A0if (!delete_file (dc_file))
>> + =C2=A0 =C2=A0 =C2=A0if (!platform_unlink (dc_file))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (D_MULTI_ERRORS, "MULTI: problem deletin=
g temporary file: %s",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dc_file);
>>
>> diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
>> index b314885..0732d0f 100644
>> --- a/src/openvpn/openvpn.h
>> +++ b/src/openvpn/openvpn.h
>> @@ -143,8 +143,8 @@ struct context_0
>> =C2=A0 =C2=A0/* workspace for --user/--group */
>> =C2=A0 =C2=A0bool uid_gid_specified;
>> =C2=A0 =C2=A0bool uid_gid_set;
>> - =C2=A0struct user_state user_state;
>> - =C2=A0struct group_state group_state;
>> + =C2=A0struct platform_state_user platform_state_user;
>> + =C2=A0struct platform_state_group platform_state_group;
>> =C2=A0};
>>
>>
>> diff --git a/src/openvpn/openvpn.vcproj b/src/openvpn/openvpn.vcproj
>> index 6c19621..4680e52 100644
>> --- a/src/openvpn/openvpn.vcproj
>> +++ b/src/openvpn/openvpn.vcproj
>> @@ -347,6 +347,10 @@
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 >
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 </File>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 <File
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RelativePath=3D".\platform.c"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 >
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </File>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 <File
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RelativePath=3D".\plugin.c"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 >
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 </File>
>> @@ -649,6 +653,10 @@
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 >
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 </File>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 <File
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RelativePath=3D".\platform.h"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 >
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </File>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 <File
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RelativePath=3D".\plugin.h"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 >
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 </File>
>> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
>> index 258b060..bd83843 100644
>> --- a/src/openvpn/options.c
>> +++ b/src/openvpn/options.c
>> @@ -920,7 +920,7 @@ setenv_settings (struct env_set *es, const struct op=
tions *o)
>> =C2=A0 =C2=A0setenv_int (es, "daemon", o->daemon);
>> =C2=A0 =C2=A0setenv_int (es, "daemon_log_redirect", o->log);
>> =C2=A0 =C2=A0setenv_unsigned (es, "daemon_start_time", time(NULL));
>> - =C2=A0setenv_int (es, "daemon_pid", openvpn_getpid());
>> + =C2=A0setenv_int (es, "daemon_pid", platform_getpid());
>>
>> =C2=A0#ifdef ENABLE_CONNECTION
>> =C2=A0 =C2=A0if (o->connection_list)
>> @@ -2640,18 +2640,18 @@ check_file_access(const int type, const char *fi=
le, const int mode, const char *
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0char *fullpath =3D strdup(file); =C2=A0/* POS=
IX dirname() implementaion may modify its arguments */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0char *dirpath =3D dirname(fullpath);
>>
>> - =C2=A0 =C2=A0 =C2=A0if (openvpn_access (dirpath, mode|X_OK) !=3D 0)
>> + =C2=A0 =C2=A0 =C2=A0if (platform_access (dirpath, mode|X_OK) !=3D 0)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errcode =3D errno;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0free(fullpath);
>> =C2=A0 =C2=A0 =C2=A0}
>>
>> =C2=A0 =C2=A0/* Is the file itself accessible? */
>> - =C2=A0if (!errcode && (type & CHKACC_FILE) && (openvpn_access (file, m=
ode) !=3D 0) )
>> + =C2=A0if (!errcode && (type & CHKACC_FILE) && (platform_access (file, =
mode) !=3D 0) )
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0errcode =3D errno;
>>
>> =C2=A0 =C2=A0/* If the file exists and is accessible, is it writable? */
>> - =C2=A0if (!errcode && (type & CHKACC_FILEXSTWR) && (openvpn_access (fi=
le, F_OK) =3D=3D 0) )
>> - =C2=A0 =C2=A0if (openvpn_access (file, W_OK) !=3D 0)
>> + =C2=A0if (!errcode && (type & CHKACC_FILEXSTWR) && (platform_access (f=
ile, F_OK) =3D=3D 0) )
>> + =C2=A0 =C2=A0if (platform_access (file, W_OK) !=3D 0)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0errcode =3D errno;
>>
>> =C2=A0 =C2=A0/* Scream if an error is found */
>> @@ -3755,7 +3755,7 @@ read_config_file (struct options *options,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (streq (file, "stdin"))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 fp =3D stdin;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
>> - =C2=A0 =C2=A0 =C2=A0 fp =3D openvpn_fopen (file, "r");
>> + =C2=A0 =C2=A0 =C2=A0 fp =3D platform_fopen (file, "r");
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fp)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 line_num =3D 0;
>> @@ -4528,7 +4528,7 @@ add_option (struct options *options,
>> =C2=A0 =C2=A0else if (streq (p[0], "cd") && p[1])
>> =C2=A0 =C2=A0 =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0VERIFY_PERMISSION (OPT_P_GENERAL);
>> - =C2=A0 =C2=A0 =C2=A0if (openvpn_chdir (p[1]))
>> + =C2=A0 =C2=A0 =C2=A0if (platform_chdir (p[1]))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_ERR, "cd to '%s' failed", p[1]=
);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;
>> diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
>> index 186f074..0102129 100644
>> --- a/src/openvpn/packet_id.c
>> +++ b/src/openvpn/packet_id.c
>> @@ -368,7 +368,7 @@ packet_id_persist_load (struct packet_id_persist *p,=
 const char *filename)
>> =C2=A0 =C2=A0if (!packet_id_persist_enabled (p))
>> =C2=A0 =C2=A0 =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* open packet-id persist file for both read =
and write */
>> - =C2=A0 =C2=A0 =C2=A0p->fd =3D openvpn_open (filename,
>> + =C2=A0 =C2=A0 =C2=A0p->fd =3D platform_open (filename,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0O_CREAT | O_RDWR | O_BINARY,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0S_IRUSR | S_IWUSR);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (p->fd =3D=3D -1)
>> diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
>> index 729792e..7ed1e70 100644
>> --- a/src/openvpn/pf.c
>> +++ b/src/openvpn/pf.c
>> @@ -504,8 +504,8 @@ pf_check_reload (struct context *c)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0&& c->c2.pf.filename
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0&& event_timeout_trigger (&c->c2.pf.reload, &=
c->c2.timeval, ETT_DEFAULT))
>> =C2=A0 =C2=A0 =C2=A0{
>> - =C2=A0 =C2=A0 =C2=A0openvpn_stat_t s;
>> - =C2=A0 =C2=A0 =C2=A0if (!openvpn_stat (c->c2.pf.filename, &s))
>> + =C2=A0 =C2=A0 =C2=A0platform_stat_t s;
>> + =C2=A0 =C2=A0 =C2=A0if (!platform_stat (c->c2.pf.filename, &s))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s.st_mtime > c->c2.pf.file_last_m=
od)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
>> @@ -605,7 +605,7 @@ pf_destroy_context (struct pf_context *pfc)
>> =C2=A0#ifdef PLUGIN_PF
>> =C2=A0 =C2=A0if (pfc->filename)
>> =C2=A0 =C2=A0 =C2=A0{
>> - =C2=A0 =C2=A0 =C2=A0delete_file (pfc->filename);
>> + =C2=A0 =C2=A0 =C2=A0platform_unlink (pfc->filename);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0free (pfc->filename);
>> =C2=A0 =C2=A0 =C2=A0}
>> =C2=A0#endif
>> diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
>> new file mode 100644
>> index 0000000..c79f680
>> --- /dev/null
>> +++ b/src/openvpn/platform.c
>> @@ -0,0 +1,369 @@
>> +/*
>> + * =C2=A0OpenVPN -- An application to securely tunnel IP networks
>> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 over a single TCP/UDP port=
, with support for SSL/TLS-based
>> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 session authentication and=
 key exchange,
>> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet encryption, packet =
authentication, and
>> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet compression.
>> + *
>> + * =C2=A0Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...1696...=
15...>
>> + *
>> + * =C2=A0This program is free software; you can redistribute it and/or =
modify
>> + * =C2=A0it under the terms of the GNU General Public License version 2
>> + * =C2=A0as published by the Free Software Foundation.
>> + *
>> + * =C2=A0This program is distributed in the hope that it will be useful,
>> + * =C2=A0but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * =C2=A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See=
 the
>> + * =C2=A0GNU General Public License for more details.
>> + *
>> + * =C2=A0You should have received a copy of the GNU General Public Lice=
nse
>> + * =C2=A0along with this program (see the file COPYING included with th=
is
>> + * =C2=A0distribution); if not, write to the Free Software Foundation, =
Inc.,
>> + * =C2=A059 Temple Place, Suite 330, Boston, MA =C2=A002111-1307 =C2=A0=
USA
>> + */
>> +
>> +#ifdef HAVE_CONFIG_H
>> +#include "config.h"
>> +#elif defined(_MSC_VER)
>> +#include "config-msvc.h"
>> +#endif
>> +
>> +#include "syshead.h"
>> +
>> +#include "buffer.h"
>> +#include "error.h"
>> +#include "win32.h"
>> +
>> +#include "memdbg.h"
>> +
>> +#include "platform.h"
>> +
>> +/* Redefine the top level directory of the filesystem
>> + =C2=A0 to restrict access to files for security */
>> +void
>> +platform_chroot (const char *path)
>> +{
>> + =C2=A0if (path)
>> + =C2=A0 =C2=A0{
>> +#ifdef HAVE_CHROOT
>> + =C2=A0 =C2=A0 =C2=A0const char *top =3D "/";
>> + =C2=A0 =C2=A0 =C2=A0if (chroot (path))
>> + =C2=A0 =C2=A0 =C2=A0 msg (M_ERR, "chroot to '%s' failed", path);
>> + =C2=A0 =C2=A0 =C2=A0if (platform_chdir (top))
>> + =C2=A0 =C2=A0 =C2=A0 msg (M_ERR, "cd to '%s' failed", top);
>> + =C2=A0 =C2=A0 =C2=A0msg (M_INFO, "chroot to '%s' and cd to '%s' succee=
ded", path, top);
>> +#else
>> + =C2=A0 =C2=A0 =C2=A0msg (M_FATAL, "Sorry but I can't chroot to '%s' be=
cause this operating system doesn't appear to support the chroot() system c=
all", path);
>> +#endif
>> + =C2=A0 =C2=A0}
>> +}
>> +
>> +/* Get/Set UID of process */
>> +
>> +bool
>> +platform_user_get (const char *username, struct platform_state_user *st=
ate)
>> +{
>> + =C2=A0bool ret =3D false;
>> + =C2=A0CLEAR (*state);
>> + =C2=A0if (username)
>> + =C2=A0 =C2=A0{
>> +#if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
>> + =C2=A0 =C2=A0 =C2=A0state->pw =3D getpwnam (username);
>> + =C2=A0 =C2=A0 =C2=A0if (!state->pw)
>> + =C2=A0 =C2=A0 =C2=A0 msg (M_ERR, "failed to find UID for user %s", use=
rname);
>> + =C2=A0 =C2=A0 =C2=A0state->username =3D username;
>> + =C2=A0 =C2=A0 =C2=A0ret =3D true;
>> +#else
>> + =C2=A0 =C2=A0 =C2=A0msg (M_FATAL, "cannot get UID for user %s -- platf=
orm lacks getpwname() or setuid() system calls", username);
>> +#endif
>> + =C2=A0 =C2=A0}
>> + =C2=A0return ret;
>> +}
>> +
>> +void
>> +platform_user_set (const struct platform_state_user *state)
>> +{
>> +#if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
>> + =C2=A0if (state->username && state->pw)
>> + =C2=A0 =C2=A0{
>> + =C2=A0 =C2=A0 =C2=A0if (setuid (state->pw->pw_uid))
>> + =C2=A0 =C2=A0 =C2=A0 msg (M_ERR, "setuid('%s') failed", state->usernam=
e);
>> + =C2=A0 =C2=A0 =C2=A0msg (M_INFO, "UID set to %s", state->username);
>> + =C2=A0 =C2=A0}
>> +#endif
>> +}
>> +
>> +/* Get/Set GID of process */
>> +
>> +bool
>> +platform_group_get (const char *groupname, struct platform_state_group =
*state)
>> +{
>> + =C2=A0bool ret =3D false;
>> + =C2=A0CLEAR (*state);
>> + =C2=A0if (groupname)
>> + =C2=A0 =C2=A0{
>> +#if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
>> + =C2=A0 =C2=A0 =C2=A0state->gr =3D getgrnam (groupname);
>> + =C2=A0 =C2=A0 =C2=A0if (!state->gr)
>> + =C2=A0 =C2=A0 =C2=A0 msg (M_ERR, "failed to find GID for group %s", gr=
oupname);
>> + =C2=A0 =C2=A0 =C2=A0state->groupname =3D groupname;
>> + =C2=A0 =C2=A0 =C2=A0ret =3D true;
>> +#else
>> + =C2=A0 =C2=A0 =C2=A0msg (M_FATAL, "cannot get GID for group %s -- plat=
form lacks getgrnam() or setgid() system calls", groupname);
>> +#endif
>> + =C2=A0 =C2=A0}
>> + =C2=A0return ret;
>> +}
>> +
>> +void
>> +platform_group_set (const struct platform_state_group *state)
>> +{
>> +#if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
>> + =C2=A0if (state->groupname && state->gr)
>> + =C2=A0 =C2=A0{
>> + =C2=A0 =C2=A0 =C2=A0if (setgid (state->gr->gr_gid))
>> + =C2=A0 =C2=A0 =C2=A0 msg (M_ERR, "setgid('%s') failed", state->groupna=
me);
>> + =C2=A0 =C2=A0 =C2=A0msg (M_INFO, "GID set to %s", state->groupname);
>> +#ifdef HAVE_SETGROUPS
>> + =C2=A0 =C2=A0 =C2=A0{
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0gid_t gr_list[1];
>> + =C2=A0 =C2=A0 =C2=A0 gr_list[0] =3D state->gr->gr_gid;
>> + =C2=A0 =C2=A0 =C2=A0 if (setgroups (1, gr_list))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_ERR, "setgroups('%s') failed", stat=
e->groupname);
>> + =C2=A0 =C2=A0 =C2=A0}
>> +#endif
>> + =C2=A0 =C2=A0}
>> +#endif
>> +}
>> +
>> +/* Change process priority */
>> +void
>> +platform_nice (int niceval)
>> +{
>> + =C2=A0if (niceval)
>> + =C2=A0 =C2=A0{
>> +#ifdef HAVE_NICE
>> + =C2=A0 =C2=A0 =C2=A0errno =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0if (nice (niceval) < 0 && errno !=3D 0)
>> + =C2=A0 =C2=A0 =C2=A0 msg (M_WARN | M_ERRNO, "WARNING: nice %d failed: =
%s", niceval, strerror(errno));
>> + =C2=A0 =C2=A0 =C2=A0else
>> + =C2=A0 =C2=A0 =C2=A0 msg (M_INFO, "nice %d succeeded", niceval);
>> +#else
>> + =C2=A0 =C2=A0 =C2=A0msg (M_WARN, "WARNING: nice %d failed (function no=
t implemented)", niceval);
>> +#endif
>> + =C2=A0 =C2=A0}
>> +}
>> +
>> +/* Get current PID */
>> +unsigned int
>> +platform_getpid ()
>> +{
>> +#ifdef WIN32
>> + =C2=A0return (unsigned int) GetCurrentProcessId ();
>> +#else
>> +#ifdef HAVE_GETPID
>> + =C2=A0return (unsigned int) getpid ();
>> +#else
>> + =C2=A0return 0;
>> +#endif
>> +#endif
>> +}
>> +
>> +/* Disable paging */
>> +void
>> +platform_mlockall(bool print_msg)
>> +{
>> +#ifdef HAVE_MLOCKALL
>> + =C2=A0if (mlockall (MCL_CURRENT | MCL_FUTURE))
>> + =C2=A0 =C2=A0msg (M_WARN | M_ERRNO, "WARNING: mlockall call failed");
>> + =C2=A0else if (print_msg)
>> + =C2=A0 =C2=A0msg (M_INFO, "mlockall call succeeded");
>> +#else
>> + =C2=A0msg (M_WARN, "WARNING: mlockall call failed (function not implem=
ented)");
>> +#endif
>> +}
>> +
>> +/*
>> + * Wrapper for chdir library function
>> + */
>> +int
>> +platform_chdir (const char* dir)
>> +{
>> +#ifdef HAVE_CHDIR
>> +#ifdef WIN32
>> + =C2=A0int res;
>> + =C2=A0struct gc_arena gc =3D gc_new ();
>> + =C2=A0res =3D _wchdir (wide_string (dir, &gc));
>> + =C2=A0gc_free (&gc);
>> + =C2=A0return res;
>> +#else
>> + =C2=A0return chdir (dir);
>> +#endif
>> +#else
>> + =C2=A0return -1;
>> +#endif
>> +}
>> +
>> +/*
>> + * convert system() return into a success/failure value
>> + */
>> +bool
>> +platform_system_ok (int stat)
>> +{
>> +#ifdef WIN32
>> + =C2=A0return stat =3D=3D 0;
>> +#else
>> + =C2=A0return stat !=3D -1 && WIFEXITED (stat) && WEXITSTATUS (stat) =
=3D=3D 0;
>> +#endif
>> +}
>> +
>> +/*
>> + * did system() call execute the given command?
>> + */
>> +bool
>> +platform_system_executed (int stat)
>> +{
>> +#ifdef WIN32
>> + =C2=A0return stat !=3D -1;
>> +#else
>> + =C2=A0return stat !=3D -1 && WEXITSTATUS (stat) !=3D 127;
>> +#endif
>> +}
>> +
>> +int
>> +platform_access (const char *path, int mode)
>> +{
>> +#ifdef WIN32
>> + =C2=A0struct gc_arena gc =3D gc_new ();
>> + =C2=A0int ret =3D _waccess (wide_string (path, &gc), mode & ~X_OK);
>> + =C2=A0gc_free (&gc);
>> + =C2=A0return ret;
>> +#else
>> + =C2=A0return access (path, mode);
>> +#endif
>> +}
>> +
>> +/*
>> + * Go to sleep for n milliseconds.
>> + */
>> +void
>> +platform_sleep_milliseconds (unsigned int n)
>> +{
>> +#ifdef WIN32
>> + =C2=A0Sleep (n);
>> +#else
>> + =C2=A0struct timeval tv;
>> + =C2=A0tv.tv_sec =3D n / 1000;
>> + =C2=A0tv.tv_usec =3D (n % 1000) * 1000;
>> + =C2=A0select (0, NULL, NULL, NULL, &tv);
>> +#endif
>> +}
>> +
>> +/*
>> + * Go to sleep indefinitely.
>> + */
>> +void
>> +platform_sleep_until_signal (void)
>> +{
>> +#ifdef WIN32
>> + =C2=A0ASSERT (0);
>> +#else
>> + =C2=A0select (0, NULL, NULL, NULL, NULL);
>> +#endif
>> +}
>> +
>> +/* delete a file, return true if succeeded */
>> +bool
>> +platform_unlink (const char *filename)
>> +{
>> +#if defined(WIN32)
>> + =C2=A0struct gc_arena gc =3D gc_new ();
>> + =C2=A0BOOL ret =3D DeleteFileW (wide_string (filename, &gc));
>> + =C2=A0gc_free (&gc);
>> + =C2=A0return (ret !=3D 0);
>> +#elif defined(HAVE_UNLINK)
>> + =C2=A0return (unlink (filename) =3D=3D 0);
>> +#else
>> + =C2=A0return false;
>> +#endif
>> +}
>> +
>> +int platform_system(const char *command) {
>> + =C2=A0int ret;
>> +#ifdef WIN32
>> + =C2=A0struct gc_arena gc =3D gc_new ();
>> + =C2=A0ret =3D _wsystem (wide_string (command, &gc));
>> + =C2=A0gc_free (&gc);
>> +#else
>> + =C2=A0ret =3D system (command);
>> +#endif
>> + =C2=A0return ret;
>> +}
>> +
>> +int platform_putenv(char *string)
>> +{
>> + =C2=A0int status;
>> +#if defined(WIN32)
>> + =C2=A0struct gc_arena gc =3D gc_new ();
>> + =C2=A0char *s =3D string_alloc(string, &gc);
>> + =C2=A0char *value =3D strchr(s, '=3D');
>> + =C2=A0if (value!=3DNULL)
>> + =C2=A0 =C2=A0{
>> + =C2=A0 =C2=A0 =C2=A0*value =3D '\0';
>> + =C2=A0 =C2=A0 =C2=A0value++;
>> + =C2=A0 =C2=A0 =C2=A0if (*value =3D=3D '\0')
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D NULL;
>> + =C2=A0 =C2=A0}
>> +
>> + =C2=A0status =3D SetEnvironmentVariableW (wide_string (s, &gc),
>> + =C2=A0 =C2=A0 =C2=A0wide_string (value, &gc)) ? 1: 0;
>> + =C2=A0gc_free (&gc);
>> +#elif defined(HAVE_PUTENV)
>> + =C2=A0void manage_env (char *str); /* TODO: Resolve properly */
>> + =C2=A0status =3D putenv (string);
>> + =C2=A0if (!status)
>> + =C2=A0 =C2=A0manage_env (string);
>> +#endif
>> +
>> + =C2=A0return status;
>> +}
>> +
>> +FILE *
>> +platform_fopen (const char *path, const char *mode)
>> +{
>> +#ifdef WIN32
>> + =C2=A0struct gc_arena gc =3D gc_new ();
>> + =C2=A0FILE *f =3D _wfopen (wide_string (path, &gc), wide_string (mode,=
 &gc));
>> + =C2=A0gc_free (&gc);
>> + =C2=A0return f;
>> +#else
>> + =C2=A0return fopen(path, mode);
>> +#endif
>> +}
>> +
>> +int
>> +platform_open (const char *path, int flags, int mode)
>> +{
>> +#ifdef WIN32
>> + =C2=A0struct gc_arena gc =3D gc_new ();
>> + =C2=A0int fd =3D _wopen (wide_string (path, &gc), flags, mode);
>> + =C2=A0gc_free (&gc);
>> + =C2=A0return fd;
>> +#else
>> + =C2=A0return open(path, flags, mode);
>> +#endif
>> +}
>> +
>> +int
>> +platform_stat (const char *path, platform_stat_t *buf)
>> +{
>> +#ifdef WIN32
>> + =C2=A0struct gc_arena gc =3D gc_new ();
>> + =C2=A0int res =3D _wstat (wide_string (path, &gc), buf);
>> + =C2=A0gc_free (&gc);
>> + =C2=A0return res;
>> +#else
>> + =C2=A0return stat(path, buf);
>> +#endif
>> +}
>> +
>> diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h
>> new file mode 100644
>> index 0000000..7bd2067
>> --- /dev/null
>> +++ b/src/openvpn/platform.h
>> @@ -0,0 +1,142 @@
>> +/*
>> + * =C2=A0OpenVPN -- An application to securely tunnel IP networks
>> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 over a single TCP/UDP port=
, with support for SSL/TLS-based
>> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 session authentication and=
 key exchange,
>> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet encryption, packet =
authentication, and
>> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet compression.
>> + *
>> + * =C2=A0Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...1696...=
15...>
>> + *
>> + * =C2=A0This program is free software; you can redistribute it and/or =
modify
>> + * =C2=A0it under the terms of the GNU General Public License version 2
>> + * =C2=A0as published by the Free Software Foundation.
>> + *
>> + * =C2=A0This program is distributed in the hope that it will be useful,
>> + * =C2=A0but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * =C2=A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See=
 the
>> + * =C2=A0GNU General Public License for more details.
>> + *
>> + * =C2=A0You should have received a copy of the GNU General Public Lice=
nse
>> + * =C2=A0along with this program (see the file COPYING included with th=
is
>> + * =C2=A0distribution); if not, write to the Free Software Foundation, =
Inc.,
>> + * =C2=A059 Temple Place, Suite 330, Boston, MA =C2=A002111-1307 =C2=A0=
USA
>> + */
>> +
>> +#ifndef PLATFORM_H
>> +#define PLATFORM_H
>> +
>> +#ifdef HAVE_SYS_TYPES_H
>> +#include <sys/types.h>
>> +#endif
>> +
>> +#ifdef HAVE_SYS_STAT_H
>> +#include <sys/stat.h>
>> +#endif
>> +
>> +#ifdef HAVE_UNISTD_H
>> +#include <unistd.h>
>> +#endif
>> +
>> +#ifdef HAVE_PWD_H
>> +#include <pwd.h>
>> +#endif
>> +
>> +#ifdef HAVE_GRP_H
>> +#include <grp.h>
>> +#endif
>> +
>> +#ifdef HAVE_STDIO_H
>> +#include <stdio.h>
>> +#endif
>> +
>> +#include "basic.h"
>> +
>> +/* Get/Set UID of process */
>> +
>> +struct platform_state_user {
>> +#if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
>> + =C2=A0const char *username;
>> + =C2=A0struct passwd *pw;
>> +#else
>> + =C2=A0int dummy;
>> +#endif
>> +};
>> +
>> +/* Get/Set GID of process */
>> +
>> +struct platform_state_group {
>> +#if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
>> + =C2=A0const char *groupname;
>> + =C2=A0struct group *gr;
>> +#else
>> + =C2=A0int dummy;
>> +#endif
>> +};
>> +
>> +bool platform_user_get (const char *username, struct platform_state_use=
r *state);
>> +void platform_user_set (const struct platform_state_user *state);
>> +
>> +bool platform_group_get (const char *groupname, struct platform_state_g=
roup *state);
>> +void platform_group_set (const struct platform_state_group *state);
>> +
>> +/*
>> + * Extract UID or GID
>> + */
>> +
>> +static inline int
>> +platform_state_user_uid (const struct platform_state_user *s)
>> +{
>> +#if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
>> + =C2=A0if (s->pw)
>> + =C2=A0 =C2=A0return s->pw->pw_uid;
>> +#endif
>> + =C2=A0return -1;
>> +}
>> +
>> +static inline int
>> +platform_state_group_gid (const struct platform_state_group *s)
>> +{
>> +#if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
>> + =C2=A0if (s->gr)
>> + =C2=A0 =C2=A0return s->gr->gr_gid;
>> +#endif
>> + =C2=A0return -1;
>> +}
>> +
>> +void platform_chroot (const char *path);
>> +
>> +void platform_nice (int niceval);
>> +
>> +unsigned int platform_getpid (void);
>> +
>> +void platform_mlockall (bool print_msg); /* Disable paging */
>> +
>> +int platform_chdir (const char* dir);
>> +
>> +/* interpret the status code returned by system()/execve() */
>> +bool platform_system_ok (int stat);
>> +bool platform_system_executed (int stat);
>> +int platform_system(const char *command);
>> +
>> +int platform_access (const char *path, int mode);
>> +
>> +void platform_sleep_milliseconds (unsigned int n);
>> +
>> +void platform_sleep_until_signal (void);
>> +
>> +/* delete a file, return true if succeeded */
>> +bool platform_unlink (const char *filename);
>> +
>> +int platform_putenv (char *string);
>> +
>> +FILE *platform_fopen (const char *path, const char *mode);
>> +int platform_open (const char *path, int flags, int mode);
>> +
>> +#ifdef WIN32
>> +typedef struct _stat platform_stat_t;
>> +#else
>> +typedef struct stat platform_stat_t;
>> +#endif
>> +int platform_stat (const char *path, platform_stat_t *buf);
>> +
>> +#endif
>> diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
>> index a4e50e8..5d056ee 100644
>> --- a/src/openvpn/ps.c
>> +++ b/src/openvpn/ps.c
>> @@ -337,7 +337,7 @@ journal_add (const char *journal_dir, struct proxy_c=
onnection *pc, struct proxy_
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0check_malloc_return (jfn);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0openvpn_snprintf (jfn, fnlen, "%s/%s", journa=
l_dir, t);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0dmsg (D_PS_PROXY_DEBUG, "PORT SHARE PROXY: cl=
ient origin %s -> %s", jfn, f);
>> - =C2=A0 =C2=A0 =C2=A0fd =3D openvpn_open (jfn, O_CREAT | O_TRUNC | O_WR=
ONLY, S_IRUSR | S_IWUSR | S_IRGRP);
>> + =C2=A0 =C2=A0 =C2=A0fd =3D platform_open (jfn, O_CREAT | O_TRUNC | O_W=
RONLY, S_IRUSR | S_IWUSR | S_IRGRP);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd !=3D -1)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 write(fd, f, strlen(f));
>> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
>> index 6a60cb5..d712c66 100644
>> --- a/src/openvpn/ssl_openssl.c
>> +++ b/src/openvpn/ssl_openssl.c
>> @@ -280,7 +280,7 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const =
char *pkcs12_file,
>> =C2=A0#endif
>> =C2=A0 =C2=A0 =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Load the PKCS #12 file */
>> - =C2=A0 =C2=A0 =C2=A0if (!(fp =3D openvpn_fopen(pkcs12_file, "rb")))
>> + =C2=A0 =C2=A0 =C2=A0if (!(fp =3D platform_fopen(pkcs12_file, "rb")))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_SSLERR, "Error opening file %s", pkcs1=
2_file);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0p12 =3D d2i_PKCS12_fp(fp, NULL);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0fclose(fp);
>> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
>> index 51457f8..e837e39 100644
>> --- a/src/openvpn/ssl_verify.c
>> +++ b/src/openvpn/ssl_verify.c
>> @@ -517,7 +517,7 @@ verify_cert_call_command(const char *verify_command,=
 struct env_set *es,
>> =C2=A0 =C2=A0if (verify_export_cert)
>> =C2=A0 =C2=A0 =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tmp_file)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0delete_file(tmp_file);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0platform_unlink(tmp_file);
>> =C2=A0 =C2=A0 =C2=A0}
>>
>> =C2=A0 =C2=A0gc_free(&gc);
>> @@ -551,7 +551,7 @@ verify_check_crl_dir(const char *crl_dir, openvpn_x5=
09_cert_t *cert)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0x509_free_serial(serial);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return FAILURE;
>> =C2=A0 =C2=A0 =C2=A0}
>> - =C2=A0fd =3D openvpn_open (fn, O_RDONLY, 0);
>> + =C2=A0fd =3D platform_open (fn, O_RDONLY, 0);
>> =C2=A0 =C2=A0if (fd >=3D 0)
>> =C2=A0 =C2=A0 =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (D_HANDSHAKE, "VERIFY CRL: certificate se=
rial number %s is revoked", serial);
>> @@ -735,7 +735,7 @@ key_state_rm_auth_control_file (struct key_state *ks)
>> =C2=A0{
>> =C2=A0 =C2=A0if (ks && ks->auth_control_file)
>> =C2=A0 =C2=A0 =C2=A0{
>> - =C2=A0 =C2=A0 =C2=A0delete_file (ks->auth_control_file);
>> + =C2=A0 =C2=A0 =C2=A0platform_unlink (ks->auth_control_file);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0free (ks->auth_control_file);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0ks->auth_control_file =3D NULL;
>> =C2=A0 =C2=A0 =C2=A0}
>> @@ -987,7 +987,7 @@ verify_user_pass_script (struct tls_session *session=
, const struct user_pass *up
>>
>> =C2=A0 done:
>> =C2=A0 =C2=A0if (tmp_file && strlen (tmp_file) > 0)
>> - =C2=A0 =C2=A0delete_file (tmp_file);
>> + =C2=A0 =C2=A0platform_unlink (tmp_file);
>>
>> =C2=A0 =C2=A0argv_reset (&argv);
>> =C2=A0 =C2=A0gc_free (&gc);
>> diff --git a/src/openvpn/status.c b/src/openvpn/status.c
>> index 0be5e4c..5f9ab9e 100644
>> --- a/src/openvpn/status.c
>> +++ b/src/openvpn/status.c
>> @@ -78,17 +78,17 @@ status_open (const char *filename,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (so->flags)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case STATUS_OUTPUT_WRITE:
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0so->fd =3D openvpn_ope=
n (filename,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0so->fd =3D platform_op=
en (filename,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 O_CREAT | O_=
TRUNC | O_WRONLY,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 S_IRUSR | S_=
IWUSR);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case STATUS_OUTPUT_READ:
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0so->fd =3D openvpn_ope=
n (filename,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0so->fd =3D platform_op=
en (filename,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 O_RDONLY,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 S_IRUSR | S_=
IWUSR);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case STATUS_OUTPUT_READ|=
STATUS_OUTPUT_WRITE:
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0so->fd =3D openvpn_ope=
n (filename,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0so->fd =3D platform_op=
en (filename,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 O_CREAT | O_=
RDWR,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 S_IRUSR | S_=
IWUSR);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
>> index abc6a99..e6a7bc8 100644
>> --- a/src/openvpn/tun.c
>> +++ b/src/openvpn/tun.c
>> @@ -1545,22 +1545,22 @@ tuncfg (const char *dev, const char *dev_type, c=
onst char *dev_node, int persist
>> =C2=A0 =C2=A0 =C2=A0msg (M_ERR, "Cannot ioctl TUNSETPERSIST(%d) %s", per=
sist_mode, dev);
>> =C2=A0 =C2=A0if (username !=3D NULL)
>> =C2=A0 =C2=A0 =C2=A0{
>> - =C2=A0 =C2=A0 =C2=A0struct user_state user_state;
>> + =C2=A0 =C2=A0 =C2=A0struct platform_state_user platform_state_user;
>>
>> - =C2=A0 =C2=A0 =C2=A0if (!get_user (username, &user_state))
>> + =C2=A0 =C2=A0 =C2=A0if (!platform_user_get (username, &platform_state_=
user))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_ERR, "Cannot get user entry for=
 %s", username);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ioctl (tt->fd, TUNSETOWNER, user_state.=
pw->pw_uid) < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ioctl (tt->fd, TUNSETOWNER, platform_st=
ate_user.pw->pw_uid) < 0)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_ERR, "Cannot ioctl TUNSE=
TOWNER(%s) %s", username, dev);
>> =C2=A0 =C2=A0 =C2=A0}
>> =C2=A0 =C2=A0if (groupname !=3D NULL)
>> =C2=A0 =C2=A0 =C2=A0{
>> - =C2=A0 =C2=A0 =C2=A0struct group_state group_state;
>> + =C2=A0 =C2=A0 =C2=A0struct platform_state_group platform_state_group;
>>
>> - =C2=A0 =C2=A0 =C2=A0if (!get_group (groupname, &group_state))
>> + =C2=A0 =C2=A0 =C2=A0if (!platform_group_get (groupname, &platform_stat=
e_group))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_ERR, "Cannot get group entry fo=
r %s", groupname);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ioctl (tt->fd, TUNSETGROUP, group_state=
.gr->gr_gid) < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ioctl (tt->fd, TUNSETGROUP, platform_st=
ate_group.gr->gr_gid) < 0)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_ERR, "Cannot ioctl TUNSE=
TOWNER(%s) %s", groupname, dev);
>> =C2=A0 =C2=A0 =C2=A0}
>> =C2=A0 =C2=A0close_tun (tt);
>> diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
>> index e94343b..e8e69dc 100644
>> --- a/src/openvpn/win32.c
>> +++ b/src/openvpn/win32.c
>> @@ -976,33 +976,6 @@ wide_string (const char* utf8, struct gc_arena *gc)
>> =C2=A0 =C2=A0return ucs16;
>> =C2=A0}
>>
>> -FILE *
>> -openvpn_fopen (const char *path, const char *mode)
>> -{
>> - =C2=A0struct gc_arena gc =3D gc_new ();
>> - =C2=A0FILE *f =3D _wfopen (wide_string (path, &gc), wide_string (mode,=
 &gc));
>> - =C2=A0gc_free (&gc);
>> - =C2=A0return f;
>> -}
>> -
>> -int
>> -openvpn_open (const char *path, int flags, int mode)
>> -{
>> - =C2=A0struct gc_arena gc =3D gc_new ();
>> - =C2=A0int fd =3D _wopen (wide_string (path, &gc), flags, mode);
>> - =C2=A0gc_free (&gc);
>> - =C2=A0return fd;
>> -}
>> -
>> -int
>> -openvpn_stat (const char *path, openvpn_stat_t *buf)
>> -{
>> - =C2=A0struct gc_arena gc =3D gc_new ();
>> - =C2=A0int res =3D _wstat (wide_string (path, &gc), buf);
>> - =C2=A0gc_free (&gc);
>> - =C2=A0return res;
>> -}
>> -
>> =C2=A0/*
>> =C2=A0 * call ourself in another process
>> =C2=A0 */
>> --
>> 1.7.3.4
>>
>>
>> ------------------------------------------------------------------------=
------
>> Virtualization & Cloud Management Using Capacity Planning
>> Cloud computing makes use of virtualization - but cloud computing
>> also focuses on allowing computing to be delivered as a service.
>> http://www.accelacomm.com/jaw/sfnl/114/51521223/
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

